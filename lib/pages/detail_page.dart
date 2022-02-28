import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:mongo/provider/coche_provider.dart';
import 'package:provider/provider.dart';

import '../model/coche.dart';
import 'home_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Color appbarColor = Colors.black;
  @override
  Widget build(BuildContext context) {
    final coche = ModalRoute.of(context)!.settings.arguments as Coche;
    CocheProvider cocheProvider =
        Provider.of<CocheProvider>(context, listen: false);
    appbarColor =
        appbarColor == Colors.black ? HexColor(coche.color) : appbarColor;
    TextEditingController modeloController = TextEditingController();
    TextEditingController makeController = TextEditingController();
    TextEditingController yearController = TextEditingController();
    TextEditingController colorController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    CircleColorPickerController circleController =
        CircleColorPickerController();
    modeloController.text = coche.model;
    makeController.text = coche.make;
    yearController.text = coche.year.toString();
    colorController.text = coche.color;
    circleController.color = HexColor(coche.color);
    priceController.text = coche.price.substring(1);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 2500,
          color: Color.fromRGBO(255, 255, 255, 1),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextField(
                  controller: makeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Marca',
                    alignLabelWithHint: true,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: modeloController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Modelo',
                    alignLabelWithHint: true,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: yearController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Año',
                    alignLabelWithHint: true,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Color:'),
                CircleColorPicker(
                  controller: circleController,
                  onChanged: (color) {
                    setState(() {
                      colorController.text = color.toString();
                      appbarColor = color;
                    });
                  },
                  size: const Size(240, 240),
                  strokeWidth: 4,
                  thumbSize: 36,
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: priceController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Precio',
                    alignLabelWithHint: true,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  child: const Icon(Icons.save),
                  onPressed: () {
                    Coche modCoche = Coche(
                        id: coche.id,
                        make: makeController.text,
                        model: modeloController.text,
                        year: int.parse(yearController.text),
                        color:
                            '#${appbarColor.value.toRadixString(16).substring(2)}',
                        price: '\$' + priceController.text);

                    cocheProvider.updateCoche(modCoche);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
