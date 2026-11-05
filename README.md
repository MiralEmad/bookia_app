# 📚 Bookia Store App (Flutter)

A responsive, localized Flutter implementation of the **Bookia** book-store Figma design.
It covers the full user journey: **Splash → Welcome → Register / Login → Password recovery → Home, Book Details, Wishlist, Cart and Profile**, with all data saved locally using **Hive**, **English / Arabic (RTL)** localization, and **reusable widgets** everywhere.

---

## 📑 Table of Contents
1. [Feature Overview](#-feature-overview)
2. [App Flow](#-app-flow)
3. [Screens in Detail](#-screens-in-detail)
4. [Local Storage with Hive](#-local-storage-with-hive)
5. [Localization (English + Arabic)](#-localization-english--arabic)
6. [Responsive Design](#-responsive-design)
7. [Smart Text Field](#-smart-text-field)
8. [Reusable Widgets](#-reusable-widgets)
9. [Project Structure](#-project-structure)
10. [Getting Started](#-getting-started)
11. [Images](#-images)
12. [How to Test](#-how-to-test)
13. [Troubleshooting](#-troubleshooting)
14. [Feedback Addressed](#-feedback-addressed)
15. [Notes and Limitations](#-notes-and-limitations)

---

## ✨ Feature Overview

| Area | What is included |
|---|---|
| **Authentication** | Register, Login, session kept after closing the app, Logout |
| **Password recovery** | Forgot Password, OTP Verification (5 digits), Create new password, Password Changed |
| **Store** | Home (search, banner slider, Best Seller grid), Book Details, Wishlist, Cart, Profile |
| **Navigation** | Bottom navigation bar (Home, Wishlist, Cart with item badge, Profile) |
| **Local database** | Hive: users, session, language, wishlist and cart (per user) |
| **Localization** | English + Arabic, full RTL, language switch inside the app, remembered between launches |
| **Responsive** | Phones, tablets and web, no overflow, scrolls when needed |
| **Reusable code** | 16 shared widgets, shared validators, repositories and theme |

---

## 🧭 App Flow

```
Splash ──(session saved in Hive?)──┬── yes ──► Main Shell (Home / Wishlist / Cart / Profile)
                                   └── no ───► Welcome ──► Login ◄──► Register
                                                           │
                                                           └─► Forgot Password ─► OTP Verification
                                                                 ─► Create new password ─► Password Changed ─► Login

Main Shell
 ├─ Home ───────► Book Details (bookmark = Wishlist, Add To Cart = Cart)
 ├─ Wishlist ───► Book Details
 ├─ Cart
 └─ Profile ────► Reset Password (opens the Forgot Password flow) / Logout ─► Welcome
```

---

## 🖥 Screens in Detail

### 1. Authentication

| Screen | File | Description |
|---|---|---|
| **Splash** | `features/welcome/splash_screen.dart` | Logo + tagline for 2 seconds, then opens the **Main Shell** if a session is saved in Hive, otherwise **Welcome**. |
| **Welcome** | `features/welcome/welcome_screen.dart` | Background photo (gradient fallback), logo, tagline, **Login** and **Register** buttons, language switch. |
| **Login** | `features/auth/login_screen.dart` | Email + password (show/hide), "Forgot Password?" link, Google / Apple buttons (UI only), link to Register. Checks the account stored in Hive. Wrong credentials show a localized error. |
| **Register** | `features/auth/register_screen.dart` | Username, email, password, confirm password. Saves the new user in Hive, then opens Login with the email pre-filled. Duplicate emails are blocked. |

### 2. Password Recovery

| Screen | File | Description |
|---|---|---|
| **Forgot Password?** | `features/auth/forgot_password_screen.dart` | Enter the account email. If it exists in Hive, a 5-digit code is generated and stored. |
| **OTP Verification** | `features/auth/otp_verification_screen.dart` | 5 code boxes (auto-focus, backspace goes back, paste fills all boxes), **Verify** and **Resend**. |
| **Create new password** | `features/auth/create_new_password_screen.dart` | New password + confirm. Updates the user's password in Hive. |
| **Password Changed!** | `features/auth/password_changed_screen.dart` | Green check, success message and **Back to Login** button. |

How it works:
- The password can only be changed **after** the code was verified (verification state is stored in Hive).
- The code row is always left-to-right, even in Arabic.
- There is no email server in this demo, so the code appears in a SnackBar ("Demo code: 12345").

### 3. Store

| Screen | File | Description |
|---|---|---|
| **Main Shell** | `features/main/main_shell.dart` | The frame that holds the bottom navigation and switches between the four tabs. Cart icon shows a badge with the item count. Content is limited to 720 px wide. |
| **Home** | `featuresmain/home_screen.dart` | Logo + search icon. Search filters books by **title or author** (in the current language). Auto-sliding banner (every 4 seconds) with dot indicator. **Best Seller** grid. The gold **+** adds a book to the cart. Tapping a card opens Book Details. Shows "No books found" when a search has no result. |
| **Book Details** | `features/main/book_details_screen.dart` | Back button, **bookmark** (saves / removes from the wishlist, gold when saved), cover with shadow, title, author, format, description, price and the dark **Add To Cart** button. Shows SnackBar feedback. |
| **Wishlist** | `features/main/wishlist_screen.dart` | Grid of saved books with a ⊗ remove button. Tapping a card opens Book Details. Friendly empty state when nothing is saved. |
| **Cart (My Cart)** | `features/main/cart_screen.dart` | Each item shows cover, title, unit price, quantity stepper **+ 01 −**, line total and a ⊗ remove button. Bottom shows **Total:** and the gold **Checkout** button (shows "Coming soon"). Empty state when the cart is empty. Quantity cannot go below 1; use ⊗ to delete. |
| **Profile** | `features/maine/profile_screen.dart` | Centered title, logout icon, language icon, avatar (first letter of the name), name and email from Hive, and the list: **My Orders, Edit Profile, Reset Password, FAQ, Contact Us, Privacy & Terms**. Reset Password opens the Forgot Password flow; the other rows show "Coming soon". |

---

## 💾 Local Storage with Hive

All boxes are opened in `HiveService.init()` before the app starts.

| Box | Content |
|---|---|
| `users` | `UserModel` per account: username, email, **hashed** password, created date. Key = lowercase email. |
| `settings` | `lang` (selected language), `session_email` (logged-in user), and the temporary reset values `reset_email`, `reset_code`, `reset_verified`. |
| `wishlist` | Key = user email, value = list of book ids. |
| `cart` | Key = user email, value = map of book id → quantity. |

Details:
- Passwords are hashed with **SHA-256** (never stored as plain text).
- Emails are stored in lowercase, so `Test@Mail.com` and `test@mail.com` are the same account.
- Wishlist and cart are saved **per user**, so every account sees only its own data. A `guest` key is used if nobody is logged in.
- The **session** survives closing the app, so the user stays logged in.
- The **language** choice is saved and restored on launch.
- Data layer files: `hive_service.dart`, `user_model.dart` (hand-written `TypeAdapter`, **no `build_runner` needed**), `auth_repository.dart`, `wishlist_repository.dart`, `cart_repository.dart`.
- The wishlist and cart repositories are `ChangeNotifier`s, so every screen updates instantly (for example, the cart badge changes as soon as a book is added).
- Sample catalog: `book_model.dart` and `books_data.dart` (6 books with English and Arabic title, author and description).

---

## 🌍 Localization (English + Arabic)

- Built on Flutter's `LocalizationsDelegate` with `flutter_localizations`.
- **Every** text uses `context.tr('key')`: titles, buttons, hints, validation errors, SnackBars, tooltips, navigation labels, and the book titles, authors and descriptions.
- Full **RTL** support for Arabic: layouts, chevrons, back arrows and alignment mirror automatically (`AlignmentDirectional`, directional padding).
- A language switch is available on Welcome, Login, Register and Profile. The app rebuilds instantly.
- The selected language is saved in Hive.
- To add a language: add a new map in `app_localizations.dart` and add its `Locale` to `supportedLocales`.

Text groups in `app_localizations.dart`: app and welcome, login and register, validation, password recovery, store (home, details, wishlist), cart, profile and navigation.

---

## 📱 Responsive Design

- Sizes scale with the screen width relative to the 390 px Figma frame: `context.sp(...)` (clamped between 0.85x and 1.25x).
- Content width limits: **480 px** for forms, **600 px** for Book Details, **720 px** for the main shell.
- Book grids use `maxCrossAxisExtent`, so **phones show 2 columns and tablets / web show 3 to 4**.
- Screens scroll on small devices and when the keyboard is open (no overflow errors). Bottom links stay pinned to the bottom on tall screens.
- Uses `SafeArea`, `LayoutBuilder`, `Expanded` and `AlignmentDirectional`.

---

## ✍️ Smart Text Field

- `AppTextField` is a normal `TextFormField`.
- `AppTextField.multiline(...)` is for **description / bio / notes** fields:
  - starts at a fixed height (1 line by default),
  - **grows automatically** as the user types more lines,
  - stops at `maxLines` (default 6) and then scrolls inside the field,
  - supports `maxLength` (default 300) and `minLines`.
- Password fields include a show / hide eye icon.

```dart
AppTextField.multiline(
  controller: descriptionController,
  hint: context.tr('description'),
  minLines: 1,
  maxLines: 6,
)
```

Validation (all messages localized): required fields, email format, minimum 6-character password, confirm password must match.

---

## 🧩 Reusable Widgets (`lib/core/widgets`)

| Widget | Purpose |
|---|---|
| `AppLogo` | Bookia logo (icon + name), scales with the screen. |
| `PrimaryButton` | Filled or outlined button with a loading spinner and optional `backgroundColor`. |
| `AppTextField` | Text field with password toggle and expandable multiline mode. |
| `SocialButton` | Google / Apple style outlined button. |
| `AuthScaffold` | Shared layout for auth screens: back button, language switch, title, optional subtitle, scrolling. |
| `AuthBottomLink` | "Don't have an account? Register Now" style link. |
| `LanguageButton` | Switches between English and Arabic. |
| `OtpField` | OTP input with auto-focus, backspace and paste support. |
| `BookCover` | Cover image, with a colored title cover if the image is missing. |
| `BookCard` | Book card used by Home and Wishlist (the bottom-end action is passed in). Also exports the shared `bookGridDelegate`. |
| `SmallActionButton` | Small square button on cards (add to cart / remove). |
| `SquareIconButton` | White rounded square button (back, bookmark). |
| `EmptyState` | Icon + message for empty wishlist, cart and search. |
| `AppBottomNav` | Bottom navigation with a cart badge. |
| `CartItemTile` | One cart row with quantity stepper, line total and remove. |
| `ProfileTile` | White row with title and chevron for the Profile list. |
| `ResponsiveBody` *(in `responsive.dart`)* | Centered, max-width, scrollable body. |
| `Validators` *(in `utils`)* | Reusable localized form validators. |

---

## 🗂 Project Structure

```
lib/
├── main.dart                          # Initializes Hive, sets up localization and theme
├── core/
│   ├── l10n/
│   │   ├── app_localizations.dart     # EN + AR strings and delegate
│   │   └── locale_controller.dart     # Current locale, saved in Hive
│   ├── responsive/responsive.dart     # sp() scaling and ResponsiveBody
│   ├── theme/                         # app_colors.dart, app_theme.dart
│   ├── utils/validators.dart
│   └── widgets/
│       ├── app_bottom_nav.dart        ├── app_logo.dart
│       ├── app_text_field.dart        ├── auth_bottom_link.dart
│       ├── auth_scaffold.dart         ├── book_card.dart
│       ├── book_cover.dart            ├── cart_item_tile.dart
│       ├── empty_state.dart           ├── language_button.dart
│       ├── otp_field.dart             ├── primary_button.dart
│       ├── profile_tile.dart          ├── small_action_button.dart
│       ├── social_button.dart         └── square_icon_button.dart
├── data/
│   ├── hive_service.dart              # Hive init and boxes
│   ├── user_model.dart                # UserModel + TypeAdapter
│   ├── auth_repository.dart           # register / login / logout / session / password reset
│   ├── book_model.dart                # Book model
│   ├── books_data.dart                # Sample catalog (EN + AR)
│   ├── wishlist_repository.dart       # Wishlist in Hive (per user)
│   └── cart_repository.dart           # Cart in Hive (per user)
└── features/
    ├── splash/splash_screen.dart
    ├── welcome/welcome_screen.dart
    ├── auth/              login_screen.dart, register_screen.dart
    ├── pass/              forgot_password_screen.dart, create_new_password_screen.dart, password_changed_screen.dart
    ├── verification/      otp_verification_screen.dart
    ├── shell/main_shell.dart
    ├── home/home_screen.dart
    ├── book_details/book_details_screen.dart
    ├── wishlist/wishlist_screen.dart
    ├── cart/cart_screen.dart
    └── profile/profile_screen.dart
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

### Packages
| Package | Use |
|---|---|
| `hive`, `hive_flutter` | Local database |
| `crypto` | SHA-256 password hashing |
| `flutter_localizations`, `intl` | Localization and RTL |

---

## 🖼 Images

All images are optional. If a file is missing, the app shows a gradient or a colored cover with the book title, so it always looks complete. Add files to `assets/images/` using these names:

| File | Used for |
|---|---|
| `welcome_bg.jpg` | Welcome screen background |
| `banner_1.jpg`, `banner_2.jpg`, `banner_3.jpg` | Home banner slides |
| `book_republic.jpg`, `book_black_heart.jpg`, `book_meditations.jpg`, `book_alchemist.jpg`, `book_pride.jpg`, `book_1984.jpg` | Book covers |

Flutter does not read sub-folders of `assets/images/`, so keep these files directly inside it.

---

## 🧪 How to Test

1. Open the app and **Register** a new account (saved in Hive). You land on Login with the email filled in, so **Login**.
2. On **Home**, try the search, watch the banner slide, and tap **+** on a book. The cart badge increases.
3. Open a book. Tap the **bookmark** (it turns gold), then check the **Wishlist** tab. Remove it with ⊗.
4. In **Cart**, use **+ / −**, remove an item, and check that the **Total** updates.
5. Close and reopen the app: you are still logged in, and the wishlist and cart are still there.
6. In **Profile**, tap the language icon: the whole app switches to Arabic (RTL) and stays that way after restart.
7. Log out, then log in with another account: it has its own empty wishlist and cart.
8. Test password recovery: Login, **Forgot Password?**, enter your email, copy the demo code from the SnackBar, verify it, set a new password, then log in with it. (Also reachable from Profile, **Reset Password**.)
9. Try registering the same email again: a duplicate error appears.

---

## 🛠 Troubleshooting

| Problem | Fix |
|---|---|
| `The named parameter 'subtitle' isn't defined` | `auth_scaffold.dart` is the old version, or it is in the wrong folder. Put the latest one in `lib/core/widgets/`. |
| Red error on an `import '../../core/widgets/...'` line | That widget file is missing from `lib/core/widgets/`. Add it. |
| Red error on `import '../../data/...'` | The file is missing from `lib/data/`. |
| Screens cannot find each other | Check the folders match [Project Structure](#-project-structure): `pass/` and `verification/` sit next to `auth/` inside `features/`. |
| A strange `{core` folder inside `lib` | Created by a wrong command. Move any needed files into `core/` and delete it. |
| Many errors right after copying files | Run `flutter pub get`, then in VS Code run **Dart: Restart Analysis Server**. |
| Odd Hive errors after changing the data model | Uninstall the app once (or clear its storage) and run again. |

---

## ✅ Feedback Addressed

- ✔ **Hive is used** to save data locally: users, session, language, wishlist and cart.
- ✔ **Text field** is a normal `TextFormField` with a fixed starting height that expands for long text, then scrolls.
- ✔ **Localization** is included: English + Arabic with full RTL.
- ✔ **Responsive** layouts on every screen.
- ✔ **Reusable widgets** instead of repeated code.

---

## 📝 Notes and Limitations

- Google / Apple sign-in buttons, Checkout, and the Profile rows **My Orders, Edit Profile, FAQ, Contact Us, Privacy & Terms** show a "Coming soon" message (UI only).
- The OTP code is shown on screen because there is no email server. Replace `requestResetCode` in `auth_repository.dart` with a real email / SMS service in production.
- SHA-256 hashing is suitable for a local demo. Use a real backend with salted hashing for production.
- The book catalog is local sample data in `books_data.dart`. Replace it with an API when a backend is available.
