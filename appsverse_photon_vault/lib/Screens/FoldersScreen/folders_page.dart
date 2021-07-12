import 'package:flutter/material.dart';
import 'package:appsverse_photon_vault/Screens/FoldersScreen/components/albums.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FolderScreen extends StatefulWidget {
  @override
  FolderScreenState createState() {
    return FolderScreenState();
  }
}

class FolderScreenState extends State<FolderScreen> {
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();
  late String valueText;
  late String passwordText;

  //Display Text Field for new album async
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Folder Name'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Folder Name"),
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
              SizedBox(width: 120),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                ),
                child: Text('OK', style: TextStyle(color: Colors.black)),
                onPressed: () async {
                  String? _ = await _createDirectory(valueText);
                  Navigator.pop(context);
                  await _displayTextInputDialog2(context);
                  setState(() {});
                },
              ),
            ],
          );
        });
  }

  // display second dialog for password
  Future<void> _displayTextInputDialog2(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter Your Password'),
            content: TextField(
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  passwordText = value;
                });
              },
              controller: _textFieldController2,
              decoration: InputDecoration(hintText: "Password"),
            ),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                  alignment: Alignment.bottomLeft,
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                ),
                child: Text('OK', style: TextStyle(color: Colors.black)),
                onPressed: () async {
                  /* print("Album name:");
                  print(valueText);
                  print("Password name");
                  print(passwordText); */
                  prefs.setString(valueText, passwordText);
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
            ],
          );
        });
  }

  //create new folder for new album
  Future<String?> _createDirectory(String albumName) async {
    Directory? _appDocumentsDirectory = await getExternalStorageDirectory();
    final Directory _appDocDirFolder =
        Directory('${_appDocumentsDirectory!.path}/$albumName');
    //print(_appDocDirFolder);
    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      //TODO: Implement notification if album name already used
      return _appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      return _appDocDirNewFolder.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    //print("building");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Your Albums"),
      ),
      body: Container(child: Albums()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          _displayTextInputDialog(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add_rounded),
      ),
    );
  }
}
