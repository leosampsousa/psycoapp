import 'package:flutter/material.dart';
import 'package:teste/pages/LoginPage.dart';
import 'package:teste/pages/MainBackground.dart';
import 'package:teste/service/AuthService.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _voltar(BuildContext context) async {
    await Authservice.saveToken("");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainBackground(
        child: Center(
          child: ElevatedButton(
              onPressed: () => _voltar(context), child: Text("voltar")),
        ),
      ),
    );
  }
}
