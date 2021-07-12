import 'package:flutter/material.dart';
import 'dart:io';

class Enlarge extends StatelessWidget {
  String imagePath;
  Enlarge({required this.imagePath});
  @override
  Widget build(BuildContext context) {
    final stringList = imagePath.split("/");
    final imageName = stringList[stringList.length - 1];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Image Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(imageName),
        ),
        body: new Container(
          color: Colors.grey[200],
          child: Image.file(new File(imagePath)),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
