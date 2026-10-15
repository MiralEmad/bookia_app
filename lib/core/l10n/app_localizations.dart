import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Lightweight localization (English + Arabic) using Flutter's
/// LocalizationsDelegate. Use `context.tr('key')` anywhere in the UI.
class AppLocalizations {
  AppLocalizations(this.locale);
  final Locale locale;

  static const supportedLocales = [Locale('en'), Locale('ar')];
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  String t(String key) =>
      _values[locale.languageCode]?[key] ?? _values['en']![key] ?? key;

  static const Map<String, Map<String, String>> _values = {
    'en': {
      'appName': 'Bookia',
      'tagline': 'Order Your Book Now!',
      'login': 'Login',
      'register': 'Register',
      'loginTitle': 'Welcome back! Glad to see you, Again!',
      'registerTitle': 'Hello! Register to get started',
      'enterEmail': 'Enter your email',
      'enterPassword': 'Enter your password',
      'username': 'Username',
      'email': 'Email',
      'password': 'Password',
      'confirmPassword': 'Confirm password',
      'forgotPassword': 'Forgot Password?',
      'or': 'Or',
      'signGoogle': 'Sign in with Google',
      'signApple': 'Sign in with Apple',
      'noAccount': "Don't have an account? ",
      'registerNow': 'Register Now',
      'haveAccount': 'Already have an account? ',
      'loginNow': 'Login Now',
      'required': 'This field is required',
      'invalidEmail': 'Enter a valid email',
      'shortPassword': 'Password must be at least 6 characters',
      'passwordMismatch': 'Passwords do not match',
      'emailExists': 'This email is already registered',
      'wrongCredentials': 'Wrong email or password',
      'registeredOk': 'Account created successfully, please login',
      'comingSoon': 'Coming soon',
      'hello': 'Hello',
      'homeMessage': 'Your data is saved locally with Hive.',
      'logout': 'Logout',
      'language': 'العربية',
    },
    'ar': {
      'appName': 'بوكيا',
      'tagline': 'اطلب كتابك الآن!',
      'login': 'تسجيل الدخول',
      'register': 'إنشاء حساب',
      'loginTitle': 'أهلاً بعودتك! سعداء برؤيتك مجدداً!',
      'registerTitle': 'مرحباً! سجّل حسابك للبدء',
      'enterEmail': 'أدخل بريدك الإلكتروني',
      'enterPassword': 'أدخل كلمة المرور',
      'username': 'اسم المستخدم',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'confirmPassword': 'تأكيد كلمة المرور',
      'forgotPassword': 'نسيت كلمة المرور؟',
      'or': 'أو',
      'signGoogle': 'تسجيل الدخول عبر جوجل',
      'signApple': 'تسجيل الدخول عبر آبل',
      'noAccount': 'ليس لديك حساب؟ ',
      'registerNow': 'سجّل الآن',
      'haveAccount': 'لديك حساب بالفعل؟ ',
      'loginNow': 'سجّل الدخول',
      'required': 'هذا الحقل مطلوب',
      'invalidEmail': 'أدخل بريداً إلكترونياً صحيحاً',
      'shortPassword': 'يجب ألا تقل كلمة المرور عن 6 أحرف',
      'passwordMismatch': 'كلمتا المرور غير متطابقتين',
      'emailExists': 'هذا البريد مسجّل بالفعل',
      'wrongCredentials': 'البريد أو كلمة المرور غير صحيحة',
      'registeredOk': 'تم إنشاء الحساب بنجاح، يرجى تسجيل الدخول',
      'comingSoon': 'قريباً',
      'hello': 'مرحباً',
      'homeMessage': 'بياناتك محفوظة محلياً باستخدام Hive.',
      'logout': 'تسجيل الخروج',
      'language': 'English',
    },
  };
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture(AppLocalizations(locale));

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}

extension LocalizationX on BuildContext {
  String tr(String key) => AppLocalizations.of(this).t(key);
}
