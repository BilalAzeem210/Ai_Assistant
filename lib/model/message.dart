import 'package:flutter/material.dart';

class Message {
  String msg;
  final MessageType type;

  Message({required this.msg, required this.type});

}

enum MessageType{user,bot}