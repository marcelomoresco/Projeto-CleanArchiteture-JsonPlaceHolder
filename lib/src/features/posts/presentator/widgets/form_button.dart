import 'package:flutter/material.dart';

class FormSubmitBtn extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdatePost;

  const FormSubmitBtn({
    Key? key,
    required this.onPressed,
    required this.isUpdatePost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 110,
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
          ),
          onPressed: onPressed,
          icon: isUpdatePost
              ? const Icon(
                  Icons.edit,
                  color: Colors.white,
                )
              : const Icon(Icons.add, color: Colors.white),
          label: Text(
            isUpdatePost ? "Atualizar" : "Adicionar",
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )),
    );
  }
}
