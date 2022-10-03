// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  const ErrorMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.warning,
        color: Colors.yellow,
      ),
      backgroundColor: Colors.red,
      title: const Text(
        "ERRO INESPERADO",
        style: TextStyle(color: Colors.white),
      ),
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
