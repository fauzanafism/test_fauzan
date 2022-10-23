import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final bool isObscure;
  final String hintText;
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.isObscure,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      width: 340,
      height: 53,
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(style: BorderStyle.none, width: 0),
            ),
            hintText: hintText,
            hintStyle: GoogleFonts.mulish()),
      ),
    );
  }
}
