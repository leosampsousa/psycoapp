import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:teste/components/ContactComponent.dart';
import 'package:teste/pages/LoginPage.dart';
import 'package:teste/service/AuthService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _textKey = GlobalKey();
  bool _isTextHidden = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkIfTextIsHidden);
  }

  void _checkIfTextIsHidden() {
    final RenderBox? textRenderBox =
        _textKey.currentContext?.findRenderObject() as RenderBox?;
    if (textRenderBox != null) {
      final textPosition = textRenderBox.localToGlobal(Offset.zero).dy;
      final appBarHeight = kToolbarHeight + MediaQuery.of(context).padding.top;

      setState(() {
        _isTextHidden = textPosition < appBarHeight;
      });
    }
  }

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
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          title: AnimatedOpacity(
            opacity: _isTextHidden ? 1.0 : 0.0,
            duration: Duration(milliseconds: 200),
            child: Text("Conversas"),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.black,
                ))
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Conversas'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Amigos'),
          ],
          currentIndex: 0,
          onTap: (index) {},
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    key: _textKey,
                    "Conversas",
                    textScaler: TextScaler.linear(2),
                  ),
                  SizedBox(height: 10),
                  ContactComponent(name: "Leonardo Sampaio"),
                  SizedBox(height: 20),
                  ContactComponent(name: "Lize"),
                  SizedBox(height: 20),
                  ContactComponent(name: "Derozin"),
                  SizedBox(height: 20),
                  ContactComponent(name: "Joãozin"),
                  SizedBox(height: 20),
                  ContactComponent(name: "Michel"),
                  SizedBox(height: 20),
                  ContactComponent(name: "Bibi"),
                  SizedBox(height: 20),
                  ContactComponent(name: "Iguim"),
                  SizedBox(height: 20),
                  ContactComponent(name: "Cecis"),
                  SizedBox(height: 20),
                  ContactComponent(name: "Cecis"),
                  SizedBox(height: 20),
                  ContactComponent(name: "Cecis"),
                  SizedBox(height: 20),
                  ContactComponent(name: "Cecis"),
                  SizedBox(height: 20),
                  ContactComponent(name: "Cecis"),
                  SizedBox(height: 20),
                  ContactComponent(name: "Cecis"),
                ],
              )),
        ));
  }
}
