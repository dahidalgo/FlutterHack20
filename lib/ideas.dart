import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hack20/imageDetail.dart';
import 'package:hack20/models/pictureConstants.dart';

class IdeasPage extends StatefulWidget {
  final String material;

  IdeasPage(this.material);

  @override
  _IdeasPageState createState() => _IdeasPageState();
}

class _IdeasPageState extends State<IdeasPage> {
  List<Container> listado = new List();

  @override
  void initState() {
    super.initState();
    _grid(widget.material);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[600],
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.material,
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
          textAlign: TextAlign.start,
        ),
        backgroundColor: Colors.green[600],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: GridView.count(
              primary: false,
              shrinkWrap: true,
              crossAxisCount: 2,
              children: listado)),
    );
  }

  _grid(String material) async {
    
 List<String> list = [];

    switch (material) {
      case "Botellas":
        list = botellas;
        break;
      case "Cartón":
        list = cartones;
        break;
      case "Latas":
        list = latas;
        break;
      default:
      
    }

    for (var i = 0; i < list.length; i++) {
      final imagenes = list[i];
      listado.add(
        Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white)),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => IdeasDetail(imagenes)));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(imagenes, fit: BoxFit.cover),
              ),
            )),
      );
    }
  }
}
