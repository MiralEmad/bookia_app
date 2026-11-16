import 'package:flutter/material.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/responsive/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../data/governorates.dart';

/// "Checkout card" screen of the design: a bottom sheet to pick a governorate.
/// Returns the selected governorate id, or null if dismissed.
Future<String?> showSelectGovernorateSheet(
  BuildContext context, {
  String? selectedId,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    constraints: const BoxConstraints(maxWidth: 600),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (_) => SelectGovernorateSheet(selectedId: selectedId),
  );
}

class SelectGovernorateSheet extends StatelessWidget {
  const SelectGovernorateSheet({super.key, this.selectedId});
  final String? selectedId;

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    final height = MediaQuery.sizeOf(context).height * 0.65;

    return SafeArea(
      child: SizedBox(
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  context.sp(24), context.sp(20), context.sp(24), context.sp(8)),
              child: Text(
                context.tr('selectGovernorate'),
                style: TextStyle(
                    fontSize: context.sp(18), fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: context.sp(24)),
                itemCount: kGovernorates.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, color: AppColors.border),
                itemBuilder: (context, i) {
                  final g = kGovernorates[i];
                  final selected = g.id == selectedId;
                  return InkWell(
                    onTap: () => Navigator.pop(context, g.id),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: context.sp(16)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              g.name(lang),
                              style: TextStyle(
                                fontSize: context.sp(14),
                                fontWeight: selected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.dark,
                              ),
                            ),
                          ),
                          if (selected)
                            const Icon(Icons.check_rounded,
                                color: AppColors.primary),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}