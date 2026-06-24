import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/main.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomBtn({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;
    return Align(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).buttonColor,
          shape: const StadiumBorder(),
          elevation: 0,
          minimumSize: Size(mq.width * .4, 50),
        ),
        onPressed: onTap,
        child: Text(text,style:
        TextStyle(
            color: Colors.white,
            fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
