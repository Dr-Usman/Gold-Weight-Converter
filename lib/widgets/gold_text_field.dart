import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.amber[800],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            info,
            style: TextStyle(
              color: Colors.grey[600],
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
              color: Colors.amber.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
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
                  color: Colors.amber.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
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
              border: Border.all(color: Colors.amber[300]!, width: 1.5),
              gradient: LinearGradient(
                colors: [Colors.amber[50]!, Colors.amber[100]!],
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
                    color: Colors.amber[800],
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  dropdownColor: Colors.amber[50],
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.amber[700],
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
      hintStyle: TextStyle(
        color: Colors.grey[400],
        fontWeight: FontWeight.w400,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.amber[200]!, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.amber[200]!, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.amber[600]!, width: 2),
      ),
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
