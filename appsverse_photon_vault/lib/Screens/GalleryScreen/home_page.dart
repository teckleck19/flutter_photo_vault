import 'dart:io';

import 'package:flutter/material.dart';
import 'package:appsverse_photon_vault/Screens/GalleryScreen/enlarge.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;

class HomePage extends StatefulWidget {
  @override
  final FileSystemEntity album;
  final String albumName;
  const HomePage({required this.album, required this.albumName});
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  late ImagePicker _imagePicker;
  late String imageurl;
  late FileSystemEntity _album;
  late Directory _albumDirectory;
  File? _imageFile;
  late String _status;
  late bool _imgLoading;
  Widget build(BuildContext context) {
    _imagePicker = ImagePicker();

    late List<FileSystemEntity> _imagesEntity;
    List<String> _imagesList = [];
    _status = '';
    _imgLoading = false;
    _album = widget.album;
    _albumDirectory = Directory(
        _album.toString().replaceFirst('Directory: ', '').replaceAll("'", ""));
    _imagesEntity = _albumDirectory.listSync();

    _imagesEntity.map((value) {
      final templist = [];
    });
    print(_imagesList);
    print(_imagesEntity);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              widget.albumName,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        child: Image.file(File(_imagesEntity[index]
                            .toString()
                            .replaceFirst("File: '/", "")
                            .replaceAll("'", ""))),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Enlarge(
                                  imagePath: _imagesEntity[index]
                                      .toString()
                                      .replaceFirst("File: '/", "")
                                      .replaceAll("'", "")),
                            ),
                          );
                        });
                  },
                  itemCount: _imagesEntity.length,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            setState(() {
              _imgLoading = true;
              _imageFile = null;
            });
            File? file = await _loadImage(ImageSource.gallery);

            if (null != file) {
              setState(() {
                _imageFile = file;
                _imgLoading = false;
                //_status = "loaded";
              });
            }
            setState(() {
              _imageFile = null;
              _imgLoading = false;
              //_status = "error";
            });
            setState(() {});
          },
          tooltip: 'Increment',
          child: Icon(Icons.camera_alt)),
    );
  }

  Future<File?> _loadImage(ImageSource imageSource) async {
    PickedFile? file = await _imagePicker.getImage(source: imageSource);
    File? mfile;

    if (null != file) {
      Directory? directory = _albumDirectory;
      Map map = Map();
      map['path'] = file.path;
      map['directory'] = directory;
      mfile = await _saveImageToDisk(map);
    } else {
      mfile = null;
    }
    return mfile;
  }

  Future<File?> _saveImageToDisk(Map map) async {
    try {
      String path = map['path'];

      Directory directory = map['directory'];
      File tempFile = File(path);

      Img.Image? image = Img.decodeImage(tempFile.readAsBytesSync());
      Img.Image mImage = Img.copyResize(image!, width: 512);
      String imgType = path.split('.').last;

      String mPath =
          '${directory.path.toString()}/image_${DateTime.now()}.$imgType';
      /* setState(() {
        _imagesList.add(mPath);
      }); */
      File dFile = File(mPath);
      if (imgType == 'jpg' || imgType == 'jpeg') {
        dFile.writeAsBytesSync(Img.encodeJpg(mImage));
      } else {
        dFile.writeAsBytesSync(Img.encodePng(mImage));
      }
      return dFile;
    } catch (e) {
      //print(e)
      return null;
    }
  }

  Future<Directory?> getFilePath() async {
    Directory? appDocumentsDirectory = await getExternalStorageDirectory();
    /* String appDocumentsPath = appDocumentsDirectory!.path;
    String filePath = '$appDocumentsPath/assets/images/'; */
    return appDocumentsDirectory;
  }
}
