---
name: run-ios-simulator
description: Launch a Flutter lab from this repo (Lab4, LAB1, task1, task3, hello_ios, ...) on the iOS Simulator with hot reload, and set up VS Code so F5 boots the simulator and runs the app. Use when the user wants to run, launch, test, or preview a lab app, set up VS Code for a new lab, or hits "Device ... was not found", "Untrusted Developer", or "debug mode flutter apps can only be launched from Flutter tooling".
---

# Run a Flutter lab on the iOS Simulator

The default workflow for this repo is the **iOS Simulator + VS Code F5 + hot reload on save**.
Building once and hot-reloading is much faster than reinstalling on a physical iPhone.

## Environment facts

- Mac: macOS 14.6, Xcode 16.2, Flutter installed via Homebrew (`/opt/homebrew/share/flutter`).
- VS Code with `dart-code.dart-code` and `dart-code.flutter` extensions.
- Simulator used so far: **iPhone 16 Pro (Lab4)**, UDID `A1CBE9D2-BD85-4B66-8E5B-0ED2884DF418`, iOS 18.3.
  UDIDs are machine-specific; if it's missing, pick another with
  `xcrun simctl list devices available | grep iPhone`.
- The user's physical iPhone is also visible to Flutter (USB and wireless). **Always pin the
  device id** so VS Code doesn't pick the phone by accident.

## Set up VS Code for a lab (once per lab folder)

Create these two files inside the lab folder (e.g. `Lab4/.vscode/`). The lab folder itself must be
the VS Code workspace root, or VS Code won't read the config.

`.vscode/tasks.json`. Boots the simulator and waits until it is ready:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Boot iPhone Simulator",
      "type": "shell",
      "command": "xcrun simctl boot <UDID> 2>/dev/null; open -a Simulator; xcrun simctl bootstatus <UDID>",
      "presentation": { "reveal": "silent" },
      "problemMatcher": []
    }
  ]
}
```

`.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "<App name> (iPhone Simulator)",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "deviceId": "<UDID>",
      "preLaunchTask": "Boot iPhone Simulator"
    }
  ]
}
```

`Lab4/.vscode/` is a working reference copy.

## Daily use

1. Open the lab folder in VS Code and press **F5**.
2. The Debug Console shows `Launching lib/main.dart on iPhone 16 Pro (Lab4)...` and then `Running Xcode build...`.
   The first build in a session takes about 20–120 s.
3. Edit and save with **Cmd+S**: hot reload takes under 1 s and keeps the app's state.
   **Cmd+Shift+F5** does a hot restart, which resets state. **Shift+F5** stops the app.
4. Stop and press F5 again only after changing `pubspec.yaml` dependencies or anything under `ios/`.

Terminal alternative (needs an interactive terminal for the `r`/`R`/`q` keys, so tell the
user to run it in their own Terminal, not through Claude's Bash tool):

```
xcrun simctl boot <UDID>; open -a Simulator
flutter run -d <UDID>
```

## Verifying from Claude's side

- `flutter devices`: the simulator must appear here. Flutter only lists simulators that are **booted**.
- `pgrep -fl flutter_tools`: if only `daemon` processes are running, no app launch is in progress.
- Pre-warm the build cache: `flutter build ios --simulator --debug`.

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| `Device "<UDID>" was not found` | Simulator is shut down (e.g. Simulator window was closed) | The `preLaunchTask` handles it; otherwise run `xcrun simctl boot <UDID>` |
| Simulator shows its home screen but no app | F5 never ran or failed early | Check the Debug Console and press F5 again |
| F5 ignores launch.json | VS Code opened at the repo root instead of the lab folder | Open the lab folder itself |

## Physical iPhone: avoid unless asked

This was tried and is slow and awkward with a free Apple developer account:

- After the first install, the phone shows **"Untrusted Developer"**. The user must go to Settings → General →
  VPN & Device Management → Apple Development → Trust. Uninstalling the app drops this trust again.
- A **debug** build can't be opened from the home screen ("In iOS 14+, debug mode flutter apps can
  only be launched from Flutter tooling..."). Only a running `flutter run` can launch it.
- For an app that opens standalone, run `flutter build ios --release`, then
  `xcrun devicectl device install app --device <phone id> build/ios/iphoneos/Runner.app`.
  (`flutter install --release` stopped partway once and left the old debug build installed.)
- Apps signed with a free account stop opening after about 7 days and must be reinstalled.
