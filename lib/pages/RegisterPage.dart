import 'package:flutter/material.dart';
import 'package:teste/components/BasicFormTextField.dart';
import 'package:teste/components/PasswordTextField.dart';
import 'package:teste/pages/CompleteRegistrationPage.dart';
import 'package:teste/pages/MainBackground.dart';
import 'package:teste/service/AuthService.dart';
import 'package:teste/utils/StringUtils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  var focusNode = FocusNode();
  final _usernameCtrl = TextEditingController();
  String _username = "";
  String _password = "";
  String? usernameValidationMsg;
  bool _isAvailable = false;
  List<String> errors = List.empty(growable: true);
  final _buffer = StringBuffer();

  Future<bool> isUsernameAvailable(String username) async {
    return await Authservice.isUsernameAvailable(username);
  }

  Future<void> _usernameValidator(String username) async {
    _isAvailable = await isUsernameAvailable(username);
    if (!_isAvailable) {
      usernameValidationMsg = "$username já está em uso";
      return;
    }
    usernameValidationMsg = null;
  }

  void cleanUsernameValidator() {
    _usernameCtrl.text = "";
    usernameValidationMsg = null;
  }

  String? _passwordValidator(String? password) {
    errors.clear();
    _buffer.clear();

    if (password == null || password.isEmpty || password.length < 8) {
      errors.add("• mínimo de 8 caracteres\n");
    }

    if (!StringUtils.hasUpperCase(password) ||
        !StringUtils.hasLowerCase(password)) {
      errors.add("• conter variação de maiúscula e minúscula \n");
    }

    if (errors.isNotEmpty) {
      errors[errors.length - 1] = errors[errors.length - 1].trim();
      for (String error in errors) {
        _buffer.write(error);
      }

      return _buffer.toString();
    }

    return null;
  }

  String? fieldRequiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Esse campo é obrigatório';
    }
    return usernameValidationMsg;
  }

  void handleUsernameFocus(bool hasFocus) {
    if (hasFocus) {
      cleanUsernameValidator();
      _isAvailable = false;
    } else {
      _usernameValidator(_usernameCtrl.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: MainBackground(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.black,
              ),
              Expanded(
                child: Center(
                  child: Card(
                    margin: EdgeInsets.all(10),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Crie sua conta.",
                                textScaler: TextScaler.linear(2),
                              ),
                              SizedBox(height: 16),
                              Focus(
                                  onFocusChange: (hasFocus) =>
                                      handleUsernameFocus(hasFocus),
                                  child: BasicFormTextField(
                                      focusNode: focusNode,
                                      labelText: "Usuario",
                                      controller: _usernameCtrl,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) =>
                                          fieldRequiredValidator(value),
                                      onChanged: (value) {
                                        setState(() {
                                          _usernameCtrl.text =
                                              value.toLowerCase();
                                        });
                                        _username = value;
                                      })),
                              SizedBox(height: 30),
                              PasswordTextField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) => _passwordValidator(value),
                                onChanged: (value) => {_password = value},
                              ),
                              SizedBox(height: 10),
                              PasswordTextField(
                                labelText: "Confirme sua senha",
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) => value != _password
                                    ? "senhas não correspondem"
                                    : null,
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (!_isAvailable) {
                                        await _usernameValidator(
                                            _usernameCtrl.text);
                                        focusNode.unfocus();
                                      }
                                      if (_formKey.currentState!.validate()) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CompleteRegistrationPage(
                                                    username: _username,
                                                    password: _password,
                                                  )),
                                        );
                                      }
                                    },
                                    child: const Text('Criar conta'),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
