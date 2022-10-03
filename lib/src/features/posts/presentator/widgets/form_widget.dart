import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_project_clean_arch/src/features/posts/presentator/blocs/crud_posts/crud_post_bloc.dart';
import 'package:post_project_clean_arch/src/features/posts/presentator/widgets/text_form_field_widget.dart';

import '../../domain/entities/post_entity.dart';
import 'form_button.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdate;
  final Post? post;

  const FormWidget({
    Key? key,
    required this.isUpdate,
    this.post,
  }) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdate) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(
                name: "Title", multiLines: false, controller: _titleController),
            TextFormFieldWidget(
                name: "Body", multiLines: true, controller: _bodyController),
            FormSubmitBtn(
                isUpdatePost: widget.isUpdate,
                onPressed: validateFormThenUpdateOrAddPost),
          ]),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final post = Post(
          id: widget.isUpdate ? widget.post!.id : null,
          title: _titleController.text,
          body: _bodyController.text);

      if (widget.isUpdate) {
        context.read<CrudPostBloc>().add(UpdatePostEvent(post: post));
      } else {
        context.read<CrudPostBloc>().add(AddPostEvent(post: post));
      }
    }
  }
}
