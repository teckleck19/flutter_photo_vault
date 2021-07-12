import 'dart:io';

import "package:flutter/material.dart";
import 'package:appsverse_photon_vault/Screens/GalleryScreen/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Albums extends StatefulWidget {
  @override
  _AlbumsState createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  late String passwordText;
  TextEditingController _textFieldController = TextEditingController();
  List<FileSystemEntity> albums = [];

  Future<void> _displayPasswordInput(
      BuildContext context, FileSystemEntity album, String albumName) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter Album\'s Password'),
            content: TextField(
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  passwordText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Password"),
            ),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: Text('CANCEL', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                style: ButtonStyle(
                  alignment: Alignment.bottomLeft,
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                ),
                child: Text('OK', style: TextStyle(color: Colors.black)),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  final realPassword = prefs.getString(albumName);
                  print("RealPassword");
                  print(realPassword);
                  if (passwordText == realPassword) {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomePage(album: album, albumName: albumName)));
                  }
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Directory?>(
        future: getExternalStorageDirectory(),
        builder: (context, AsyncSnapshot<Directory?> snapshot) {
          if (snapshot.hasData) {
            albums = snapshot.data!.listSync();
            return Container(
              margin: EdgeInsets.all(20),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: albums.length,
                itemBuilder: (context, index) {
                  final albumNameSplit = albums[index].toString().split("/");
                  final albumName = albumNameSplit[albumNameSplit.length - 1]
                      .replaceAll('\'', '');
                  //print(albumName);
                  return RawMaterialButton(
                    onPressed: () async {
                      _displayPasswordInput(context, albums[index], albumName);
                    },
                    fillColor: Colors.amber,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.folder),
                        Text(albumName, style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
