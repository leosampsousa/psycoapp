import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final String? labelText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  const PasswordTextField(
      {this.labelText,
      this.validator,
      this.onChanged,
      this.autovalidateMode,
      super.key});

  @override
  State<StatefulWidget> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  var _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: widget.labelText ?? 'Senha',
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
              icon: _isObscure
                  ? Icon(Icons.visibility)
                  : Icon(Icons.visibility_off))),
      obscureText: _isObscure,
      validator: widget.validator,
      onChanged: widget.onChanged,
      autovalidateMode: widget.autovalidateMode,
    );
  }
}
