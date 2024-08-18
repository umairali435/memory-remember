import 'package:flutter/material.dart';
import 'package:memory/utils/colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final bool? isRead;
  final VoidCallback? onTap;
  const CustomTextField({
    super.key,
    this.validator,
    required this.controller,
    required this.labelText,
    this.isRead,
    this.onTap,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primaryColor,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        onTap: widget.onTap,
        controller: widget.controller,
        validator: widget.validator,
        readOnly: widget.isRead ?? false,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          labelText: widget.labelText,
          focusedErrorBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          labelStyle: const TextStyle(
            color: AppColors.grey,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
        ),
      ),
    );
  }
}
