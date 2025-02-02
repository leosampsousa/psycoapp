import 'package:flutter/material.dart';
import 'package:teste/components/BasicFormTextField.dart';
import 'package:teste/pages/LoginPage.dart';
import 'package:teste/pages/MainBackground.dart';
import 'package:teste/service/AuthService.dart';
import 'package:teste/utils/ValidationUtils.dart';

class CompleteRegistrationPage extends StatefulWidget {
  final String username;
  final String password;

  const CompleteRegistrationPage(
      {required this.username, required this.password, super.key});

  @override
  State<CompleteRegistrationPage> createState() =>
      _CompleteRegistrationPageState();
}

class _CompleteRegistrationPageState extends State<CompleteRegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  String nome = "";
  String sobrenome = "";

  @override
  Widget build(BuildContext context) {
    Future<void> register(
        String username, String password, String nome, String sobrenome) async {
      try {
        await Authservice.register(username, password, nome, sobrenome);

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Usuário criado com sucesso"),
          backgroundColor: Colors.green,
        ));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
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
                                "Falta pouco...",
                                textScaler: TextScaler.linear(2),
                              ),
                              SizedBox(height: 16),
                              BasicFormTextField(
                                labelText: "Nome",
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    ValidationUtils.fieldRequiredValidator(
                                        value),
                                onChanged: (value) => nome = value,
                              ),
                              SizedBox(height: 15),
                              BasicFormTextField(
                                labelText: "Sobrenome",
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    ValidationUtils.fieldRequiredValidator(
                                        value),
                                onChanged: (value) => sobrenome = value,
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        register(widget.username,
                                            widget.password, nome, sobrenome);
                                      }
                                    },
                                    child: const Text('Finalizar'),
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
