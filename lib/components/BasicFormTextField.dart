import 'package:flutter/material.dart';

class BasicFormTextField extends StatefulWidget {
  final String labelText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;

  const BasicFormTextField(
      {required this.labelText,
      this.validator,
      this.onChanged,
      this.controller,
      this.autovalidateMode,
      this.focusNode,
      super.key});

  @override
  State<StatefulWidget> createState() => _BasicFormTextFieldState();
}

class _BasicFormTextFieldState extends State<BasicFormTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(),
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
      controller: widget.controller,
      autovalidateMode: widget.autovalidateMode,
      focusNode: widget.focusNode,
    );
  }
}
