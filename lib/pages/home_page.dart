import 'package:flutter/material.dart';
import 'package:mongo/provider/coche_provider.dart';
import 'package:provider/provider.dart';

import '../model/coche.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<CocheProvider>(
      builder: (context, cocheProvider, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return tile(cocheProvider.allCoches[index], context);
          },
        );
      },
    ));
  }

  Widget tile(Coche coche, BuildContext context) {
    TextEditingController modeloController = TextEditingController();
    TextEditingController makeController = TextEditingController();
    TextEditingController yearController = TextEditingController();
    TextEditingController colorController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    modeloController.text = coche.model;
    makeController.text = coche.make;
    yearController.text = coche.year.toString();
    colorController.text = coche.color;
    priceController.text = coche.price;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: ListTile(
          title: Text(coche.make),
          subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(coche.model),
                Text(coche.year.toString()),
                Text(coche.price)
              ]),
          leading: Icon(
            Icons.car_repair_rounded,
            color: HexColor(colorController.text),
          ),
          iconColor: Colors.black,
          trailing: IconButton(
            icon: Icon(Icons.edit),
            color: Colors.black,
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 500,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextField(
                          controller: makeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Make',
                            alignLabelWithHint: true,
                          ),
                        ),
                        TextField(
                          controller: modeloController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Modelo',
                            alignLabelWithHint: true,
                          ),
                        ),
                        TextField(
                          controller: yearController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Year',
                            alignLabelWithHint: true,
                          ),
                        ),
                        TextField(
                          controller: colorController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Color',
                            alignLabelWithHint: true,
                          ),
                          maxLength: 7,
                        ),
                        TextField(
                          controller: priceController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Price',
                            alignLabelWithHint: true,
                          ),
                        ),
                        ElevatedButton(
                          child: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
          hoverColor: Colors.amberAccent,
          tileColor: Colors.blueGrey,
        ),
      ),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
