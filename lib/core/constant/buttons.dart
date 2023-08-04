import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({super.key, required this.fn, required this.text});

  final Function()? fn;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      width: 80,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color(0xff096552),
          backgroundColor: Colors.white.withOpacity(0.5),
        ),
        onPressed: fn,
        child: Text(
          text,
          style: const TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
