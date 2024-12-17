import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wifi_List_Test_Task/core/styles/app_colors.dart';
import 'package:wifi_List_Test_Task/core/styles/app_text_styles.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String hintText;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool readOnly;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.suffixIcon,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.onChanged,
  });

  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onChangedHandler(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (widget.onChanged != null) {
        widget.onChanged!(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: AppTextStyles.textHelper,
      validator: (value) {
        final validationResult = widget.validator?.call(value);
        if (validationResult != null) return '';
        return null;
      },
      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? _obscureText : false,
      onChanged: _onChangedHandler,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.grey,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(31.0)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(31.0)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(31.0)),
          borderSide: BorderSide.none,
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(31.0)),
          gapPadding: 0,
          borderSide: BorderSide(color: AppColors.grey),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(31.0)),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        hintText: widget.hintText,
        hintStyle: AppTextStyles.textHelper,
        labelStyle: AppTextStyles.textHelper,
        errorStyle: const TextStyle(height: 0),
        // to remove padding caused by validator text
        suffixIcon: widget.suffixIcon ??
            (widget.isPassword
                ? Container(
                    width: 112.0,
                    height: 112.0,
                    decoration: BoxDecoration(
                      color: AppColors.grey2,
                      borderRadius: BorderRadius.circular(31.0),
                    ),
                    child: InkWell(
                      child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        size: 52,
                      ),
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  )
                : null),
      ),
    );
  }
}
