import 'package:flutter/material.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/responsive/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/auth_bottom_link.dart';
import '../../core/widgets/auth_scaffold.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/social_button.dart';
import '../../data/auth_repository.dart';
import 'register_screen.dart';
import '../welcome/welcome_screen.dart';

/// Screen 3: Login (checks the account stored in Hive).
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.prefillEmail});
  final String? prefillEmail;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _email = TextEditingController(text: widget.prefillEmail);
  final _password = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _snack(String msg) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(msg)));

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final result =
        await AuthRepository.instance.login(_email.text, _password.text);
    if (!mounted) return;
    setState(() => _loading = false);

    if (result == AuthResult.success) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
        (_) => false,
      );
    } else {
      _snack(context.tr('wrongCredentials'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: context.tr('loginTitle'),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AppTextField(
              controller: _email,
              hint: context.tr('enterEmail'),
              keyboardType: TextInputType.emailAddress,
              validator: (v) => Validators.email(context, v),
            ),
            SizedBox(height: context.sp(14)),
            AppTextField(
              controller: _password,
              hint: context.tr('enterPassword'),
              isPassword: true,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
              validator: (v) => Validators.password(context, v),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () => _snack(context.tr('comingSoon')),
                child: Text(context.tr('forgotPassword'),
                    style: TextStyle(
                        color: AppColors.gray, fontSize: context.sp(12))),
              ),
            ),
            SizedBox(height: context.sp(10)),
            PrimaryButton(
              label: context.tr('login'),
              isLoading: _loading,
              onPressed: _submit,
            ),
            SizedBox(height: context.sp(22)),
            Text(context.tr('or'),
                style: TextStyle(
                    fontSize: context.sp(12), fontWeight: FontWeight.w600)),
            SizedBox(height: context.sp(22)),
            SocialButton(
              label: context.tr('signGoogle'),
              icon: const Text('G',
                  style: TextStyle(
                      color: Color(0xFF4285F4),
                      fontWeight: FontWeight.w900,
                      fontSize: 20)),
              onTap: () => _snack(context.tr('comingSoon')),
            ),
            SizedBox(height: context.sp(12)),
            SocialButton(
              label: context.tr('signApple'),
              icon: const Icon(Icons.apple, color: Colors.black),
              onTap: () => _snack(context.tr('comingSoon')),
            ),
            const Spacer(),
            AuthBottomLink(
              text: context.tr('noAccount'),
              action: context.tr('registerNow'),
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const RegisterScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
