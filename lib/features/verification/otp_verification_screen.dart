import 'package:flutter/material.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/responsive/responsive.dart';
import '../../core/widgets/auth_bottom_link.dart';
import '../../core/widgets/auth_scaffold.dart';
import '../../core/widgets/otp_field.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/auth_repository.dart';
import '../pass/create_new_pass_screen.dart';

/// OTP Verification: 5-digit code check (code is stored in Hive).
class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});
  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  static const _codeLength = 5;
  String _code = '';
  bool _loading = false;

  void _snack(String msg, {int seconds = 4}) =>
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text(msg), duration: Duration(seconds: seconds)));

  Future<void> _verify() async {
    if (_code.length < _codeLength) {
      _snack(context.tr('enterFullCode'));
      return;
    }
    setState(() => _loading = true);
    final ok =
        await AuthRepository.instance.verifyResetCode(widget.email, _code);
    if (!mounted) return;
    setState(() => _loading = false);

    if (ok) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CreateNewPasswordScreen(email: widget.email)),
      );
    } else {
      _snack(context.tr('invalidCode'));
    }
  }

  Future<void> _resend() async {
    final code = await AuthRepository.instance.requestResetCode(widget.email);
    if (!mounted || code == null) return;
    _snack('${context.tr('codeResent')}\n${context.tr('demoCode')}$code',
        seconds: 8);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: context.tr('otpTitle'),
      subtitle: context.tr('otpSubtitle'),
      child: Column(
        children: [
          OtpField(
            length: _codeLength,
            onChanged: (v) => _code = v,
          ),
          SizedBox(height: context.sp(28)),
          PrimaryButton(
            label: context.tr('verify'),
            isLoading: _loading,
            onPressed: _verify,
          ),
          const Spacer(),
          AuthBottomLink(
            text: context.tr('didntReceive'),
            action: context.tr('resend'),
            onTap: _resend,
          ),
        ],
      ),
    );
  }
}