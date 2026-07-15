# ios-ci-probe

A throwaway probe to validate an **agent-visible iOS screenshot loop**.

The goal: let an AI agent developing a SwiftUI app on a headless Linux box
actually *see* the rendered UI — instead of a human screenshotting every change.

## How it works

1. The app is a normal [xtool](https://github.com/xtool-org/xtool) SwiftPM
   iOS project (builds on Linux, no Mac).
2. On push, a GitHub Actions job on a **macOS runner** builds the app for the
   iOS Simulator (`xtool dev build --triple arm64-apple-ios-simulator`), boots
   a simulator, installs + launches the app, and captures a screenshot with
   `simctl io screenshot`.
3. Screenshots upload as workflow **artifacts**. The agent downloads them
   (`gh run download`) and inspects them with its vision tooling.

macOS runner minutes are **free on public repositories**, which is why this
repo is public.

## Files

- `Sources/ScreenshotProbe/` — a deliberately colorful SwiftUI screen
  (gradient + SF Symbols + a card) so a screenshot unambiguously proves real
  rendering, not a blank canvas.
- `.github/workflows/screenshot.yml` — the macOS build + screenshot job.

This is infrastructure validation, not a real app.
