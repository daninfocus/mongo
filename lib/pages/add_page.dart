import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:mongo/provider/coche_provider.dart';
import 'package:provider/provider.dart';

import '../model/coche.dart';
import 'home_page.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  late Color appbarColor = Colors.black;
  TextEditingController modeloController = TextEditingController();
  TextEditingController makeController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CocheProvider cocheProvider =
        Provider.of<CocheProvider>(context, listen: false);

    appbarColor = appbarColor == Colors.black ? appbarColor : appbarColor;

    CircleColorPickerController circleController =
        CircleColorPickerController();
    circleController.color = Colors.black;

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
                    icon: Icon(Icons.attach_money),
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
                    Coche newCoche = Coche(
                        make: makeController.text,
                        model: modeloController.text,
                        year: int.parse(yearController.text),
                        color:
                            '#${appbarColor.value.toRadixString(16).substring(2)}',
                        price: '\$' + priceController.text);
                    cocheProvider.addCoche(newCoche);
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
