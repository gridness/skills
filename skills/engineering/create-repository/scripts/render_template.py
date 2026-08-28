#!/usr/bin/env python3
"""Render one repository asset tree into an empty destination."""

from __future__ import annotations

import argparse
import re
import shutil
import sys
import tempfile
from pathlib import Path


SKILL_ROOT = Path(__file__).resolve().parent.parent
ASSET_ROOT = SKILL_ROOT / "assets"
PATH_TOKEN = "__crate_name__"
GITHUB_START = "__GITHUB_ONLY_START__"
GITHUB_END = "__GITHUB_ONLY_END__"


def parse_args() -> argparse.Namespace:
	parser = argparse.ArgumentParser(
		description="Render a typed repository template into an empty directory."
	)
	parser.add_argument("--type", required=True, dest="repository_type")
	parser.add_argument("--destination", required=True, type=Path)
	parser.add_argument("--project-name", required=True)
	parser.add_argument("--description", required=True)
	parser.add_argument("--crate-name")
	parser.add_argument("--github-slug")
	return parser.parse_args()


def normalize_crate_name(project_name: str) -> str:
	normalized = re.sub(r"[^A-Za-z0-9_-]+", "-", project_name.strip().lower())
	normalized = normalized.strip("-_")
	if normalized and normalized[0].isdigit():
		normalized = f"project-{normalized}"
	return normalized


def escape_toml_basic_string(value: str) -> str:
	return (
		value.replace("\\", "\\\\")
		.replace('"', '\\"')
		.replace("\t", "\\t")
	)


def validate_inputs(args: argparse.Namespace) -> tuple[Path, Path, str]:
	if not re.fullmatch(r"[a-z0-9][a-z0-9-]*", args.repository_type):
		raise ValueError("repository type must use lowercase letters, digits, and hyphens")

	source = (ASSET_ROOT / args.repository_type).resolve()
	if not source.is_dir() or source.parent != ASSET_ROOT.resolve():
		available = ", ".join(
			path.name for path in sorted(ASSET_ROOT.iterdir()) if path.is_dir()
		)
		raise ValueError(
			f"unknown repository type {args.repository_type!r}; available: {available}"
		)

	destination = args.destination.expanduser().resolve()
	if destination == source or source in destination.parents:
		raise ValueError("destination cannot be inside the selected template")
	if destination.exists() and (not destination.is_dir() or any(destination.iterdir())):
		raise ValueError(f"destination is not an empty directory: {destination}")

	project_name = args.project_name.strip()
	if not project_name:
		raise ValueError("project name cannot be empty")
	if "\n" in project_name or "\r" in project_name:
		raise ValueError("project name must be one line")
	if not args.description.strip() or any(
		character in args.description for character in "\r\n"
	):
		raise ValueError("description must be one non-empty line")

	crate_name = (args.crate_name or normalize_crate_name(project_name)).strip()
	if not re.fullmatch(r"[A-Za-z][A-Za-z0-9_-]*", crate_name):
		raise ValueError(
			"crate name must start with a letter and contain only "
			"letters, digits, hyphens, and underscores"
		)

	if args.github_slug and not re.fullmatch(
		r"[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+", args.github_slug
	):
		raise ValueError("GitHub slug must have the form owner/repository")

	return source, destination, crate_name


def render_text(text: str, replacements: dict[str, str], github: bool) -> str:
	output: list[str] = []
	in_github_block = False
	for line in text.splitlines(keepends=True):
		marker = line.strip()
		if marker == GITHUB_START:
			if in_github_block:
				raise ValueError("nested GitHub-only template block")
			in_github_block = True
			continue
		if marker == GITHUB_END:
			if not in_github_block:
				raise ValueError("GitHub-only template block closes before it opens")
			in_github_block = False
			continue
		if not in_github_block or github:
			output.append(line)

	if in_github_block:
		raise ValueError("unclosed GitHub-only template block")

	rendered = "".join(output)
	tokens = re.compile("|".join(re.escape(token) for token in replacements))
	return tokens.sub(lambda match: replacements[match.group(0)], rendered)


def render_tree(
	source: Path,
	staged: Path,
	replacements: dict[str, str],
	github: bool,
) -> int:
	file_count = 0
	for source_path in sorted(source.rglob("*")):
		relative = source_path.relative_to(source)
		rendered_relative = Path(
			*(part.replace(PATH_TOKEN, replacements["{{ crate_name }}"]) for part in relative.parts)
		)
		target_path = staged / rendered_relative

		if source_path.is_dir():
			target_path.mkdir(parents=True, exist_ok=True)
			continue
		if source_path.is_symlink():
			raise ValueError(f"template symlinks are not supported: {relative}")

		target_path.parent.mkdir(parents=True, exist_ok=True)
		try:
			text = source_path.read_text(encoding="utf-8")
		except UnicodeDecodeError:
			shutil.copy2(source_path, target_path)
		else:
			target_path.write_text(
				render_text(text, replacements, github), encoding="utf-8"
			)
			shutil.copymode(source_path, target_path)
		file_count += 1
	return file_count


def unresolved_tokens(root: Path) -> list[str]:
	unresolved: list[str] = []
	template_token = re.compile(
		r"{{\s*(project_name|project_description|project_description_toml|crate_name|github_slug)\s*}}"
	)
	for path in sorted(root.rglob("*")):
		if PATH_TOKEN in path.as_posix():
			unresolved.append(path.as_posix())
		if not path.is_file():
			continue
		try:
			text = path.read_text(encoding="utf-8")
		except UnicodeDecodeError:
			continue
		if template_token.search(text) or GITHUB_START in text or GITHUB_END in text:
			unresolved.append(path.as_posix())
	return unresolved


def main() -> int:
	args = parse_args()
	try:
		source, destination, crate_name = validate_inputs(args)
		replacements = {
			"{{ project_name }}": args.project_name.strip(),
			"{{ project_description }}": args.description.strip(),
			"{{ project_description_toml }}": escape_toml_basic_string(
				args.description.strip()
			),
			"{{ crate_name }}": crate_name,
			"{{ github_slug }}": args.github_slug or "",
		}

		destination.parent.mkdir(parents=True, exist_ok=True)
		with tempfile.TemporaryDirectory(
			prefix=".create-repository-", dir=destination.parent
		) as temporary:
			staged = Path(temporary) / "repository"
			staged.mkdir()
			file_count = render_tree(
				source, staged, replacements, github=bool(args.github_slug)
			)
			unresolved = unresolved_tokens(staged)
			if unresolved:
				raise ValueError(
					"unresolved template tokens in: " + ", ".join(unresolved)
				)

			if destination.exists():
				shutil.copytree(staged, destination, dirs_exist_ok=True)
			else:
				staged.rename(destination)

		print(f"Rendered {args.repository_type} repository at {destination}")
		print(f"Cargo package: {crate_name}")
		print(f"Files: {file_count}")
		return 0
	except (OSError, ValueError) as error:
		print(f"error: {error}", file=sys.stderr)
		return 2


if __name__ == "__main__":
	raise SystemExit(main())
