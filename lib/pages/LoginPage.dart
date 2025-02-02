import 'package:flutter/material.dart';
import 'package:teste/components/BasicFormTextField.dart';
import 'package:teste/components/PasswordTextField.dart';
import 'package:teste/pages/HomePage.dart';
import 'package:teste/pages/MainBackground.dart';
import 'package:teste/pages/RegisterPage.dart';
import 'package:teste/service/AuthService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String username = "";
  String password = "";
  bool isObscure = false;

  @override
  Widget build(BuildContext context) {
    final imageWidth = MediaQuery.of(context).size.width * 0.7;
    final imageHeight = MediaQuery.of(context).size.height * 0.23;

    Future<void> login(String username, String password) async {
      try {
        await Authservice.login(username, password);

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ));
        }
      }
    }

    String? fieldRequiredValidator(String? value) {
      if (value == null || value.isEmpty) {
        return 'Esse campo é obrigatório';
      }
      return null;
    }

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: MainBackground(
          child: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(
                width: imageWidth,
                height: imageHeight,
                child: Image.asset(
                  "assets/Logo.png",
                )),
            SizedBox(
              height: 50,
            ),
            Card(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BasicFormTextField(
                        labelText: "Usuário",
                        validator: (value) => fieldRequiredValidator(value),
                        onChanged: (value) => {username = value},
                      ),
                      const SizedBox(height: 16),
                      PasswordTextField(
                          validator: (value) => fieldRequiredValidator(value),
                          onChanged: (value) => {password = value}),
                      TextButton(
                        onPressed: () {},
                        child: Text("Esqueceu a senha?",
                            style: TextStyle(fontWeight: FontWeight.normal)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                login(username, password);
                              }
                            },
                            child: const Text(
                              'Entrar',
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()),
                                );
                              },
                              child: Text("Cadastre-se")),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ])),
        ));
  }
}
