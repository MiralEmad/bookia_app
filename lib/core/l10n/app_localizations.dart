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
      'forgotTitle': 'Forgot Password?',
      'forgotSubtitle': "Don't worry! It occurs. Please enter the email address linked with your account.",
      'sendCode': 'Send Code',
      'rememberPassword': 'Remember Password? ',
      'emailNotFound': 'No account found with this email',
      'otpTitle': 'OTP Verification',
      'otpSubtitle': 'Enter the verification code we just sent on your email address.',
      'verify': 'Verify',
      'didntReceive': "Didn't received code? ",
      'resend': 'Resend',
      'invalidCode': 'Invalid verification code',
      'enterFullCode': 'Please enter the full code',
      'codeResent': 'A new code has been sent',
      'demoCode': 'Demo code: ',
      'newPasswordTitle': 'Create new password',
      'newPasswordSubtitle': 'Your new password must be unique from those previously used.',
      'newPassword': 'New Password',
      'resetPassword': 'Reset Password',
      'sessionExpired': 'Session expired, please try again',
      'passwordChanged': 'Password Changed!',
      'passwordChangedSubtitle': 'Your password has been changed successfully.',
      'backToLogin': 'Back to Login',
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
      'forgotTitle': 'نسيت كلمة المرور؟',
      'forgotSubtitle': 'لا تقلق! يحدث هذا. من فضلك أدخل البريد الإلكتروني المرتبط بحسابك.',
      'sendCode': 'إرسال الرمز',
      'rememberPassword': 'تتذكر كلمة المرور؟ ',
      'emailNotFound': 'لا يوجد حساب بهذا البريد',
      'otpTitle': 'التحقق من الرمز',
      'otpSubtitle': 'أدخل رمز التحقق الذي أرسلناه إلى بريدك الإلكتروني.',
      'verify': 'تحقق',
      'didntReceive': 'لم يصلك الرمز؟ ',
      'resend': 'إعادة الإرسال',
      'invalidCode': 'رمز التحقق غير صحيح',
      'enterFullCode': 'من فضلك أدخل الرمز كاملاً',
      'codeResent': 'تم إرسال رمز جديد',
      'demoCode': 'رمز تجريبي: ',
      'newPasswordTitle': 'إنشاء كلمة مرور جديدة',
      'newPasswordSubtitle': 'يجب أن تختلف كلمة المرور الجديدة عن كلمات المرور السابقة.',
      'newPassword': 'كلمة المرور الجديدة',
      'resetPassword': 'إعادة تعيين كلمة المرور',
      'sessionExpired': 'انتهت الجلسة، حاول مرة أخرى',
      'passwordChanged': 'تم تغيير كلمة المرور!',
      'passwordChangedSubtitle': 'تم تغيير كلمة المرور بنجاح.',
      'backToLogin': 'العودة لتسجيل الدخول',
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