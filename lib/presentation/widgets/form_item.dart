import 'package:flutter/material.dart';
import 'package:mobile_user_accurate/common/constants.dart';

class FormItem extends StatelessWidget {
  const FormItem({
    super.key,
    required this.nameController,
    required this.label,
  });

  final TextEditingController nameController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: nameController,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: kSubtitle.copyWith(color: kGrey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
