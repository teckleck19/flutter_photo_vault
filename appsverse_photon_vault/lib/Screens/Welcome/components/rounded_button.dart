import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  VoidCallback press;
  final Color color, textColor;

  RoundedButton({
    required this.text,
    required this.press,
    this.color = Colors.lightBlueAccent,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
            backgroundColor: MaterialStateProperty.all<Color>(color),
          ),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
