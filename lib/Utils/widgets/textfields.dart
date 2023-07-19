import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  const LoginTextField({super.key, required this.labelText,required this.controller});

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        controller: widget.controller,
        obscureText: true,
        decoration: InputDecoration(
          labelText: widget.labelText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(width: 1, color: Color(0xffFF8c23))),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(width: 1, color: Color(0xffFF8c23))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(width: 1, color: Color(0xffFF8c23))),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(width: 1, color: Color(0xffFF8c23))),
        ),
      ),
    );
  }
}
