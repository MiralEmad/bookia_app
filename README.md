# 📚 Bookia Store App (Flutter)

A responsive, localized Flutter implementation of the **Bookia** Figma design.
It includes the Splash, Welcome, Login and Register screens, with local data
storage using **Hive**, **English / Arabic** localization, and **reusable widgets**.

---

## ✨ Features

### Screens
| Screen | Description |
|---|---|
| **Splash** | Logo + tagline for 2 seconds, then routes automatically: to **Home** if a saved session exists in Hive, otherwise to **Welcome**. |
| **Welcome** | Background photo, logo, tagline, **Login** and **Register** buttons, and a language switch. |
| **Login** | Email + password (with show/hide), forgot password link, Google / Apple buttons, link to Register. Validates credentials against the account stored in Hive. |
| **Register** | Username, email, password, confirm password. Saves the new user in Hive, then opens Login with the email pre-filled. |
| **Home** *(extra)* | Simple page that shows the saved user's name and email, a language switch and Logout. Proves the Hive session works. |

### Local storage with Hive
- Users are saved in a `users` box (username, email, hashed password, created date).
- Passwords are hashed with **SHA-256** (never stored as plain text).
- Emails are stored lowercase, so `Test@Mail.com` and `test@mail.com` are the same account.
- Duplicate registration is blocked ("This email is already registered").
- The login **session** is saved in a `settings` box, so the user stays logged in after closing the app.
- The chosen **language** is saved in the same box and restored on launch.
- A hand-written `TypeAdapter` is used, so **no `build_runner` is required**.

### Localization (English + Arabic)
- Built on Flutter's `LocalizationsDelegate` with `flutter_localizations`.
- Every text in the app uses `context.tr('key')`, including validation errors, snack bars and buttons.
- Full **RTL** support for Arabic (layout, back arrows and alignment mirror automatically).
- A language button on Welcome, Login, Register and Home switches the language instantly.
- The selected language is remembered between launches.
- To add a language: add a new map in `app_localizations.dart` and add its `Locale` to `supportedLocales`.

### Responsive design
- Content is centered with a maximum width of **480 px**, so it looks right on phones, tablets and web.
- Sizes scale with the screen width, relative to the 390 px Figma frame (`context.sp(...)`).
- Screens scroll on small devices and when the keyboard is open (no overflow errors).
- Bottom links stay pinned to the bottom on tall screens.
- Uses `SafeArea`, `LayoutBuilder` and `AlignmentDirectional` (RTL friendly).

### Smart text field
- `AppTextField` is a normal `TextFormField`.
- `AppTextField.multiline(...)` is for **description / bio / notes** fields:
  - starts at a fixed height (1 line by default),
  - **grows automatically** as the user types more lines,
  - stops at `maxLines` (default 6) and then scrolls inside the field,
  - supports `maxLength` (default 300) and `minLines`.
- Password fields include a show / hide eye icon.

Example:
```dart
AppTextField.multiline(
  controller: descriptionController,
  hint: context.tr('description'),
  minLines: 1,
  maxLines: 6,
)
```

### Validation
- Required fields
- Email format check
- Password minimum 6 characters
- Confirm password must match
- All error messages are localized

---

## 🧩 Reusable Widgets (`lib/core/widgets`)
| Widget | Purpose |
|---|---|
| `AppLogo` | Bookia logo (icon + name), size scales automatically. |
| `PrimaryButton` | Filled or outlined button with a loading spinner. |
| `AppTextField` | Text field with password toggle and expandable multiline mode. |
| `SocialButton` | Google / Apple style outlined button. |
| `AuthScaffold` | Shared layout for Login and Register (back button, language switch, title, scrolling). |
| `AuthBottomLink` | "Don't have an account? Register Now" style link. |
| `LanguageButton` | Switches between English and Arabic. |
| `ResponsiveBody` | Centered, max-width, scrollable body. |
| `Validators` | Reusable localized form validators. |

---

## 🗂 Project Structure
```
lib/
├── main.dart                      # Initializes Hive, sets up localization and theme
├── core/
│   ├── l10n/
│   │   ├── app_localizations.dart # EN + AR strings and delegate
│   │   └── locale_controller.dart # Current locale, saved in Hive
│   ├── responsive/responsive.dart # sp() scaling and ResponsiveBody
│   ├── theme/                     # Colors and ThemeData
│   ├── utils/validators.dart
│   └── widgets/                   # Reusable widgets
├── data/
│   ├── hive_service.dart          # Hive init and boxes
│   ├── user_model.dart            # UserModel + TypeAdapter
│   └── auth_repository.dart       # register / login / logout / session
└── features/
    ├── splash/splash_screen.dart
    ├── welcome/welcome_screen.dart
    ├── auth/login_screen.dart
    ├── auth/register_screen.dart
    └── home/home_screen.dart
```

---

## 🚀 Getting Started

1. Install Flutter (3.x or newer, Dart 3+).
2. Unzip the project and open a terminal inside it.
3. Generate the platform folders (keeps `lib/` and `pubspec.yaml`):
   ```bash
   flutter create .
   ```
4. Install packages:
   ```bash
   flutter pub get
   ```
5. Run:
   ```bash
   flutter run
   ```

### Optional: Welcome background image
Add your photo as `assets/images/welcome_bg.jpg`.
If it is missing, a gradient background is shown instead.

---

## 📦 Packages
| Package | Use |
|---|---|
| `hive`, `hive_flutter` | Local database |
| `crypto` | SHA-256 password hashing |
| `flutter_localizations`, `intl` | Localization and RTL |

---

## 🧪 How to Test
1. Open the app, then **Register** a new account (data is saved in Hive).
2. You are taken to Login with the email filled in, so **Login**.
3. Close and reopen the app: you land on **Home** (session saved).
4. Tap the language button: the whole app switches to Arabic (RTL) and stays that way after restart.
5. **Logout** returns you to Welcome.
6. Try registering the same email again: a duplicate error appears.

---

## ✅ Feedback Addressed
- ✔ **Hive is used** to save data locally (users, session, language).
- ✔ **Text field** is a normal `TextFormField` with a fixed starting height that expands for long text, then scrolls.
- ✔ **Localization** is included: English + Arabic with RTL.
- ✔ **Responsive** layout and **reusable widgets**.

## 📝 Notes
- Google / Apple sign-in buttons and "Forgot Password?" show a "Coming soon" message (UI only).
- Hashing is suitable for a local demo; use a real backend with salted hashing for production.
