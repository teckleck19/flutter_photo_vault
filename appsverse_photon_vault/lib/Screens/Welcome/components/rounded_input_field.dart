import 'package:flutter/material.dart';
import './text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final String password;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    required this.hintText,
    required this.password,
    this.icon = Icons.lock,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter password";
          } else if (value == password) {
            return null;
          } else {
            return "Wrong Password";
          }
        },
        obscureText: true,
        onChanged: onChanged,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.black,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
