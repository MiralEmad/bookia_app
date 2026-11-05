import 'package:flutter/material.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/responsive/responsive.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/auth_scaffold.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/auth_repository.dart';
import 'password_changed_screen.dart';

/// Create new password: updates the user's password in Hive.
class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key, required this.email});
  final String email;

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _reset() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final ok = await AuthRepository.instance
        .resetPassword(widget.email, _password.text);
    if (!mounted) return;
    setState(() => _loading = false);

    if (ok) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const PasswordChangedScreen()),
        (_) => false,
      );
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(context.tr('sessionExpired'))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: context.tr('newPasswordTitle'),
      subtitle: context.tr('newPasswordSubtitle'),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AppTextField(
              controller: _password,
              hint: context.tr('newPassword'),
              isPassword: true,
              validator: (v) => Validators.password(context, v),
            ),
            SizedBox(height: context.sp(12)),
            AppTextField(
              controller: _confirm,
              hint: context.tr('confirmPassword'),
              isPassword: true,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _reset(),
              validator: (v) =>
                  Validators.confirm(context, v, _password.text),
            ),
            SizedBox(height: context.sp(24)),
            PrimaryButton(
              label: context.tr('resetPassword'),
              isLoading: _loading,
              onPressed: _reset,
            ),
          ],
        ),
      ),
    );
  }
}