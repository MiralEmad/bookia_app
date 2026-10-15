# Bookia (Flutter)

Screens: Splash, Welcome, Login, Register (+ simple Home).

## Run
```
flutter create .          # generates android/ios/web folders (keeps lib/ and pubspec)
flutter pub get
flutter run
```
Optional: add `assets/images/welcome_bg.jpg` for the Welcome background.

## Feedback fixed
- Hive: users, session and language are saved locally (lib/data).
- Text field: `AppTextField.multiline` is a normal TextFormField that starts at one line and grows up to 6 lines, then scrolls.
- Localization: English + Arabic (RTL), switchable from every screen, remembered in Hive.
