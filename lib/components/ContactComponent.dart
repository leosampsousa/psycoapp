import 'package:flutter/material.dart';

class ContactComponent extends StatefulWidget {
  final String name;
  final String? lastMessage;
  final String? lastMessageHour;

  const ContactComponent(
      {required this.name, this.lastMessage, this.lastMessageHour, super.key});

  @override
  State<ContactComponent> createState() => _ContactComponentState();
}

class _ContactComponentState extends State<ContactComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 75.0,
          height: 65.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
                image: AssetImage('assets/missingIcon.png'), fit: BoxFit.fill),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text("Ultima mensagem enviada")
          ],
        ),
        Spacer(),
        Text("22:16")
      ],
    );
  }
}
