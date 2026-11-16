import 'package:flutter/material.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/responsive/responsive.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/auth_scaffold.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/select_field.dart';
import '../../data/cart_repository.dart';
import '../../data/governorates.dart';
import '../../data/order_repository.dart';
import '../main/checkout_card_sheet.dart';
import '../main/congrats_screen.dart';

/// Place Your Order: delivery details, total and Submit Order.
/// The order is saved in Hive and the cart is emptied.
class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _phone = TextEditingController();
  String? _governorateId;
  String? _governorateError;
  bool _loading = false;

  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _pickGovernorate() async {
    FocusScope.of(context).unfocus();
    final id = await showSelectGovernorateSheet(context,
        selectedId: _governorateId);
    if (id != null && mounted) {
      setState(() {
        _governorateId = id;
        _governorateError = null;
      });
    }
  }

  String? _validatePhone(String? v) {
    if (v == null || v.trim().isEmpty) return context.tr('required');
    final cleaned = v.replaceAll(RegExp(r'[\s-]'), '');
    return RegExp(r'^\+?\d{8,15}$').hasMatch(cleaned)
        ? null
        : context.tr('invalidPhone');
  }

  Future<void> _submit() async {
    final valid = _formKey.currentState!.validate();
    if (_governorateId == null) {
      setState(() => _governorateError = context.tr('required'));
    }
    if (!valid || _governorateId == null) return;

    setState(() => _loading = true);
    final order = await OrdersRepository.instance.placeOrder(
      fullName: _name.text,
      address: _address.text,
      phone: _phone.text,
      governorateId: _governorateId!,
    );
    if (!mounted) return;
    setState(() => _loading = false);

    if (order == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(context.tr('orderFailed'))));
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const CongratsScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    final gap = SizedBox(height: context.sp(12));
    final total = CartRepository.instance.total;

    return AuthScaffold(
      title: context.tr('placeOrderTitle'),
      subtitle: context.tr('placeOrderSubtitle'),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AppTextField(
              controller: _name,
              hint: context.tr('fullName'),
              validator: (v) => Validators.required(context, v),
            ),
            gap,
            // Normal TextFormField that grows with the text, then scrolls.
            AppTextField.multiline(
              controller: _address,
              hint: context.tr('address'),
              maxLines: 4,
              maxLength: 200,
              validator: (v) => Validators.required(context, v),
            ),
            gap,
            AppTextField(
              controller: _phone,
              hint: context.tr('phone'),
              keyboardType: TextInputType.phone,
              validator: _validatePhone,
            ),
            gap,
            SelectField(
              hint: context.tr('governorate'),
              value: governorateById(_governorateId)?.name(lang),
              errorText: _governorateError,
              onTap: _pickGovernorate,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${context.tr('total')}:',
                    style: TextStyle(
                        fontSize: context.sp(18),
                        fontWeight: FontWeight.w600)),
                Text('${context.tr('currency')}$total',
                    style: TextStyle(
                        fontSize: context.sp(20),
                        fontWeight: FontWeight.w700)),
              ],
            ),
            SizedBox(height: context.sp(16)),
            PrimaryButton(
              label: context.tr('submitOrder'),
              isLoading: _loading,
              onPressed: _submit,
            ),
            SizedBox(height: context.sp(24)),
          ],
        ),
      ),
    );
  }
}