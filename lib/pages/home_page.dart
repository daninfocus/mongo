import 'package:flutter/material.dart';
import 'package:mongo/provider/coche_provider.dart';
import 'package:provider/provider.dart';
import 'package:avatar_glow/avatar_glow.dart';
import '../model/coche.dart';
import '../widgets/appbar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(context, 'Mongo', false),
      body: Consumer<CocheProvider>(
        builder: (context, cocheProvider, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return tile(cocheProvider.allCoches[index], context);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/add');
        },
        child: const AvatarGlow(
          glowColor: Colors.blue,
          endRadius: 190.0,
          duration: Duration(milliseconds: 2000),
          repeat: true,
          showTwoGlows: true,
          repeatPauseDuration: Duration(milliseconds: 1100),
          child: Material(
            // Replace this child with your own
            elevation: 8.0,
            shape: CircleBorder(),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
              radius: 14.0,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  Widget tile(Coche coche, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: ShapeBorder.lerp(null, null, 90),
        elevation: 5,
        shadowColor: HexColor(coche.color),
        child: GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, '/detail', arguments: coche),
          child: ListTile(
            style: ListTileStyle.drawer,
            title: Text(coche.make),
            subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(coche.model),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(coche.year.toString()),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  )
                ]),
            trailing: Text(
              coche.price,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            leading: Icon(
              Icons.car_rental_outlined,
              color: HexColor(coche.color),
            ),
            iconColor: Colors.black,
            hoverColor: Colors.amberAccent,
            horizontalTitleGap: 20.2,
            shape: ShapeBorder.lerp(null, null, 20),
            // tileColor: Colors.grey,
          ),
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
