import 'package:flutter/material.dart';

class CustomDropdownButtonFormField extends StatefulWidget {
  final Object? value;
  final List<DropdownMenuItem<Object>>? items;
  final void Function(Object?) onChanged;
  final String? labelText;
  final String? hintText;
  final EdgeInsetsGeometry padding;
  final FocusNode? focusNode;

  const CustomDropdownButtonFormField(
      {Key? key,
      required this.value,
      required this.items,
      required this.onChanged,
      required this.labelText,
      required this.padding,
      this.focusNode,
      this.hintText})
      : super(key: key);

  @override
  State<CustomDropdownButtonFormField> createState() =>
      _CustomDropdownButtonFormFieldState();
}

class _CustomDropdownButtonFormFieldState
    extends State<CustomDropdownButtonFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: DropdownButtonFormField(
        focusNode: widget.focusNode,
        elevation: 2,
        alignment: Alignment.centerLeft,
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        value: widget.value,
        style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white),
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          errorStyle:
              const TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500),
          labelText: widget.labelText,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
          hintStyle:
              const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
        ),
        items: widget.items,
        onChanged: widget.onChanged,
      ),
    );
  }
}
