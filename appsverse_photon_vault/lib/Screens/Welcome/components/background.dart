import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text(
            "Main Page",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
