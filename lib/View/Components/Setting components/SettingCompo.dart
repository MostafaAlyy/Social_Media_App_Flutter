// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

Widget EditTextFormField(
    {required TextEditingController controller,
    required String validateString,
    required String label}) {
  return TextFormField(
    controller: controller,
    validator: (String? value) {
      if (value!.isEmpty) {
        return validateString;
      }
      return null;
    },
    keyboardType: TextInputType.name,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: label,
      prefixIcon: const Icon(Icons.people),
    ),
  );
}
