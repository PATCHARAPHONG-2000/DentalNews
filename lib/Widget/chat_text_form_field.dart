import 'package:flutter/material.dart';

class ChatTextFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool isRoadOnly;
  final void Function(String)? onFieldSubmitted;

  const ChatTextFormField({
    super.key,
    this.focusNode,
    this.controller,
    this.isRoadOnly = false,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      autocorrect: false,
      focusNode: focusNode,
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hintText: "พิมพ์ข้อความ...",
        contentPadding: EdgeInsets.all(10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "กรุณากรอกข้อความ";
        }
        return null;
      },
    );
  }
}
