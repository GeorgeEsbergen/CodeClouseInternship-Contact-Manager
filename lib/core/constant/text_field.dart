import 'package:flutter/material.dart';

class MainTextFormField extends StatelessWidget {
  const MainTextFormField({
    super.key,
    required this.fn,
    required this.controller,
    required this.name,
    required this.hint,
    required this.inputType,
  });

  final String? Function(String? value) fn;
  final TextEditingController controller;
  final String name;
  final String hint;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 300,
      child: TextFormField(
        keyboardType: inputType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        cursorColor: Colors.white,
        validator: fn,
        controller: controller,
        decoration: InputDecoration(
          labelText: name,
          labelStyle: TextStyle(color: Colors.white),
          hintText: hint,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.white,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
