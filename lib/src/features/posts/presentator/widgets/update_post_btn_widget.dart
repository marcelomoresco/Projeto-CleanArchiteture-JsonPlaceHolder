import 'package:flutter/material.dart';
import '../../domain/entities/post_entity.dart';
import '../views/add/post_add_update_page.dart';

class UpdatePostBtnWidget extends StatelessWidget {
  final Post post;
  const UpdatePostBtnWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PostAddUpdatePage(
                isUpdate: true,
                post: post,
              ),
            ));
      },
      icon: const Icon(Icons.edit),
      label: const Text("Editar"),
    );
  }
}
