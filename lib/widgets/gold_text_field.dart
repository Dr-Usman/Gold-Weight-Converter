import 'package:flutter/material.dart';
import 'package:gold_weight_converter/constants/app_colors.dart';

import '../utils/number_formatter.dart';

class GoldTextField extends StatelessWidget {
  final String label;
  final String info;
  final TextEditingController controller;
  final String? semanticLabel;
  final VoidCallback? onChanged;
  final String? Function(String?)? validator;
  final String? hintText;

  // Optional dropdown properties
  final bool hasDropdown;
  final String? dropdownValue;
  final List<String>? dropdownItems;
  final ValueChanged<String?>? onDropdownChanged;

  const GoldTextField({
    super.key,
    required this.label,
    required this.info,
    required this.controller,
    this.semanticLabel,
    this.onChanged,
    this.validator,
    this.hintText,
    this.hasDropdown = false,
    this.dropdownValue,
    this.dropdownItems,
    this.onDropdownChanged,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            info,
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.ink.withValues(alpha: 0.62),
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          hasDropdown
              ? _buildTextFieldWithDropdown(context)
              : _buildTextField(context),
        ],
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? 'Enter $label value',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: validator,
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          inputFormatters: [ThousandsSeparatorInputFormatter()],
          onChanged: (value) {
            if (value.isNotEmpty && onChanged != null) {
              onChanged!();
            }
          },
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          decoration: _getInputDecoration(),
        ),
      ),
    );
  }

  Widget _buildTextFieldWithDropdown(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Semantics(
              label: semanticLabel ?? '$label input field',
              child: TextFormField(
                controller: controller,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: validator,
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                inputFormatters: [ThousandsSeparatorInputFormatter()],
                onChanged: (value) {
                  if (value.isNotEmpty && onChanged != null) {
                    onChanged!();
                  }
                },
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                decoration: _getInputDecoration(),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.cardBorder.withValues(alpha: 0.95),
                width: 1.5,
              ),
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.08),
                  AppColors.secondaryLight.withValues(alpha: 0.95),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Semantics(
              label: '$label unit selector',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  isExpanded: true,
                  style: TextStyle(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  dropdownColor: AppColors.surface,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.primaryDark,
                  ),
                  items:
                      dropdownItems
                          ?.map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                  onChanged: onDropdownChanged,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _getInputDecoration() {
    return InputDecoration(
      hintText: hintText ?? 'Enter $label value',
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      errorMaxLines: 2,
      errorStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    );
  }
}
