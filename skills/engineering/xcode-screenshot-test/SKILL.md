---
name: xcode-screenshot-test
description: Take a proper screenshot from XCode application without interrupting the user or messing with screen appearence order on the screen
disable-model-invocation: false
---

# Xcode Screenshot Test

Whenever you need to make a screenshot from an XCode application to see its UI, use this skill.

## Mission

- Take the screenshot.
- Never interrupt the user.
- Never change the order of the apps opened right now on the user device.

## Workflow

1. Find the running application. e.g.:

```zsh
swift -e '
import CoreGraphics

let windows = CGWindowListCopyWindowInfo(
    [.optionOnScreenOnly, .excludeDesktopElements],
    kCGNullWindowID
) as! [[String: Any]]

for w in windows {
    let owner = w[kCGWindowOwnerName as String] ?? ""
    let name = w[kCGWindowName as String] ?? ""
    let id = w[kCGWindowNumber as String] ?? ""
    print("\(id)\t\(owner)\t\(name)")
}
'
```

2. When PID is known, make a screenshot. e.g.:

```zsh
screencapture -l 9999 ~/tmp/ui-test.png
```
