import 'package:flutter/material.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/responsive/responsive.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/auth_bottom_link.dart';
import '../../core/widgets/auth_scaffold.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/auth_repository.dart';
import 'login_screen.dart';

/// Screen 4: Register (saves the new user in Hive).
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final result = await AuthRepository.instance.register(
      username: _username.text,
      email: _email.text,
      password: _password.text,
    );
    if (!mounted) return;
    setState(() => _loading = false);

    final messenger = ScaffoldMessenger.of(context);
    if (result == AuthResult.emailExists) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(context.tr('emailExists'))));
      return;
    }

    final msg = context.tr('registeredOk');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (_) => LoginScreen(prefillEmail: _email.text.trim())),
    );
    messenger.showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: context.tr('registerTitle'),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AppTextField(
              controller: _username,
              hint: context.tr('username'),
              validator: (v) => Validators.required(context, v),
            ),
            SizedBox(height: context.sp(12)),
            AppTextField(
              controller: _email,
              hint: context.tr('email'),
              keyboardType: TextInputType.emailAddress,
              validator: (v) => Validators.email(context, v),
            ),
            SizedBox(height: context.sp(12)),
            AppTextField(
              controller: _password,
              hint: context.tr('password'),
              isPassword: true,
              validator: (v) => Validators.password(context, v),
            ),
            SizedBox(height: context.sp(12)),
            AppTextField(
              controller: _confirm,
              hint: context.tr('confirmPassword'),
              isPassword: true,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
              validator: (v) =>
                  Validators.confirm(context, v, _password.text),
            ),
            SizedBox(height: context.sp(24)),
            PrimaryButton(
              label: context.tr('register'),
              isLoading: _loading,
              onPressed: _submit,
            ),
            const Spacer(),
            AuthBottomLink(
              text: context.tr('haveAccount'),
              action: context.tr('loginNow'),
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const LoginScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
