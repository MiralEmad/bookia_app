import 'package:flutter/material.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/responsive/responsive.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/auth_bottom_link.dart';
import '../../core/widgets/auth_scaffold.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/auth_repository.dart';
import '../verification/otp_verification_screen.dart';

/// Forgot Password: the user enters the email linked to the account.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final code = await AuthRepository.instance.requestResetCode(_email.text);
    if (!mounted) return;
    setState(() => _loading = false);

    final messenger = ScaffoldMessenger.of(context)..hideCurrentSnackBar();
    if (code == null) {
      messenger.showSnackBar(
          SnackBar(content: Text(context.tr('emailNotFound'))));
      return;
    }

    final demo = '${context.tr('demoCode')}$code';
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(email: _email.text.trim())),
    );
    // No email server in this demo, so the code is shown on screen.
    messenger.showSnackBar(SnackBar(
        content: Text(demo), duration: const Duration(seconds: 8)));
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: context.tr('forgotTitle'),
      subtitle: context.tr('forgotSubtitle'),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AppTextField(
              controller: _email,
              hint: context.tr('enterEmail'),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _sendCode(),
              validator: (v) => Validators.email(context, v),
            ),
            SizedBox(height: context.sp(24)),
            PrimaryButton(
              label: context.tr('sendCode'),
              isLoading: _loading,
              onPressed: _sendCode,
            ),
            const Spacer(),
            AuthBottomLink(
              text: context.tr('rememberPassword'),
              action: context.tr('login'),
              onTap: () => Navigator.maybePop(context),
            ),
          ],
        ),
      ),
    );
  }
}