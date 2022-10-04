import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool multiLines;
  final String name;
  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.multiLines,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        minLines: multiLines ? 6 : 1,
        maxLines: multiLines ? 6 : 1,
        controller: controller,
        validator: (value) =>
            value!.isEmpty ? "$name não pode estar vazio!" : null,
        decoration: InputDecoration(
          hintText: name,
          prefixIcon: const Icon(Icons.newspaper, color: Colors.black),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(30.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(30.0)),
          contentPadding: const EdgeInsets.all(10),
          hintStyle: const TextStyle(
              fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
