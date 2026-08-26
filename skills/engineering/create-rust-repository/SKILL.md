---
name: create-rust-repository
description: Scaffolds the template rust project repository
disable-model-invocation: true
---

# Create Rust Repository

When the user invocates this skill, create a rust repository in the designated directory, using template files.

Before moving on, ask the user the directory they want to create the project. Suggest current working directory.

Never create project before the explicit user approval.

## Creating the project

Start from `temaplte/`.

1. Ask the user the name of the project. Suggest current directory name if applicable as the project name.
2. Ask the user if they want to initialize github repository from local source contents.
3. If user accepts gh repo creation at step 2, ask the repository name, license and visibility. Suggest by default: project name as the repository name, public visibility, apache 2.0 license.
4. Copy all files from `template/` directory of this skill to the target directory.
5. Apply name changes to all files containing `{{ project_name }}` to the project name specified by the user at step 1.
6. Initialize git repository: `git init -b main`.
7. Make an initial commit:
```
git add .
git commit -m "bootstrapped project {{ project_name }} [skip ci]"
```

**NOTE**: If user specified license type for a repository during step 3, before staging files create the LICENSE file: `gh license <license-name>`.

8. Create github repository based on user answers from step 2 and 3 if applicable:
```
gh repo create {{ project_name }} --<visibility> --source=. --push
```

When handing off the work to user, report the made changes, including the created file tree.

If the user also wanted to create github repository and one was created, provide the link to the created directory.
