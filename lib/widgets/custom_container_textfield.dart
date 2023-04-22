import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomContainerTextField extends StatelessWidget {
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction textInputAction;
  final String labelText;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry padding;
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final Function()? onTap;
  final Color? cursorColor;
  final FocusNode? focusNode;

  const CustomContainerTextField({
    Key? key,
    this.onChanged,
    required this.keyboardType,
    this.inputFormatters,
    required this.textInputAction,
    required this.labelText,
    required this.padding,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.textCapitalization = TextCapitalization.none,
    this.autoValidateMode,
    this.prefixIcon,
    this.readOnly = false,
    this.onTap,
    this.cursorColor,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        focusNode: focusNode,
        cursorColor: cursorColor,
        readOnly: readOnly,
        onTap: onTap,
        validator: validator,
        controller: controller,
        autovalidateMode: autoValidateMode,
        textCapitalization: textCapitalization,
        onChanged: onChanged,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        obscureText: obscureText,
        style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          errorStyle:
              const TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500),
          labelText: labelText,
          labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
          prefixIcon: prefixIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
          hintStyle:
              const TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
