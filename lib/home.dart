import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack20/ideas.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:hack20/footer.dart';
import 'package:hack20/picture_picker.dart';
import 'package:hack20/models/result.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ImagePicker _imagePicker = ImagePicker();
  File _selectedPicture;
  Result _result;

  Future pickImage(ImageSource source) async {
    PickedFile pickedFile =
        await _imagePicker.getImage(source: source);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      setState(() {
        _selectedPicture = file;
      });
      identifyImage(file);
    }
  }

  void cropImage(File image) async {
    File croppedImage = await ImageCropper.cropImage(
      cropStyle: CropStyle.rectangle,
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 2),
      maxWidth: 512,
      maxHeight: 512,
    );

    if (croppedImage != null && this.mounted) {
      setState(() {
        this._selectedPicture = croppedImage;
        identifyImage(croppedImage);
      });
    }
  }

  Future identifyImage(File file) async {
    String _ = await Tflite.loadModel(
      model: "assets/tflite/model_unquant.tflite",
      labels: "assets/tflite/labels.txt",
    );

    List<dynamic> recognitions = await Tflite.runModelOnImage(
      path: file.path,
      numResults: 1,
      imageMean: 128,
      imageStd: 128,
    );

    if (recognitions.isNotEmpty) {
      print(recognitions);
      setState(() {
        _result = Result.fromMap(recognitions.first);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[600],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green[600],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 12),
                  width: 70,
                  height: 70,
                  child: Image.asset(
                    'assets/img/earth.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        "Recycling",
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Select a picture to start!",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 36.0),
              child: PicturePicker(
                  imageFile: _selectedPicture,
                  shape: BoxShape.rectangle,
                  width: MediaQuery.of(context).size.width - 56,
                  onTap: () => _modalBottomSheetMenu()),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0, bottom: 12),
              child: Divider(),
            ),
            if (_result != null) buildResult(),
            if (_result != null) ideasHandler(),
            Spacer(),
            Footer(),
          ],
        ),
      ),
    );
  }

  Container buildResult() {

    if (_result.label == "Otros"){
      return Container();
    } else {
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Text(
              _result.label,
              style: Theme.of(context).textTheme.headline5.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
            ),
          ),
          Text(
            '${(_result.confidence * 100).toStringAsFixed(2)} %',
            style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w400,
                  height: 1,
                ),
          ),
        ],
      ),
    );
    }
  }

  Widget ideasButton(bool resultOk) {
    return GestureDetector(
        onTap: () {
          resultOk
              ? Navigator.of(context).push(CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => IdeasPage(_result.label)))
              : print('');
        },
        child: Center(
          child: resultOk ? Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40.0),
                  decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.green[900], width: 2)),
                  child: Text('Ideas for recycling',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ) : Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text('Nothing found, please try again..',
                      style: TextStyle(color: Colors.white)),
                ),
              
        ));
  }

  Widget ideasHandler() {
    switch (_result.label) {
      case "Botellas":
        return ideasButton(true);
        break;
      case "Cartón":
        return ideasButton(true);
        break;
      case "Latas":
        return ideasButton(true);
        break;
      default:
        return ideasButton(false);
    }
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
              padding: EdgeInsets.symmetric(horizontal: 100),
              height: 140,
              color: Colors.white,
              child: Row(children: [
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: GestureDetector(
                      onTap: () {
                        pickImage(ImageSource.camera);
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.green, shape: BoxShape.circle),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Camera", style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: GestureDetector(
                      onTap: () {
                        pickImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.green, shape: BoxShape.circle),
                            child: Icon(
                              Icons.photo_library,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Gallery", style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      )),
                ),
              ]));
        });
  }
}
