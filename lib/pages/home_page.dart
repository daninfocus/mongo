import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextEditingController editingController = TextEditingController();

  Icon customIcon = const Icon(
    Icons.search,
    color: Colors.black,
  );
  Widget customSearchBar = const Text(
    'Wongo',
    style: TextStyle(color: Colors.black),
  );

  @override
  Widget build(BuildContext context) {
    CocheProvider cocheProvider =
        Provider.of<CocheProvider>(context, listen: false);

    _filter(value) {
      if (value.isNotEmpty) {
        cocheProvider.sortCoches(value);
      }
    }

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark),
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Container(
              color: Color.fromARGB(144, 0, 237, 99),
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.sort_sharp),
          onPressed: () {
            final snackBar = SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      cocheProvider.sortAlphabetical();
                    },
                    icon: Icon(Icons.sort_by_alpha_rounded),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {
                      cocheProvider.sortPrice();
                    },
                    icon: Icon(Icons.price_change_outlined),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {
                      cocheProvider.sortYear();
                    },
                    icon: Icon(Icons.format_list_numbered_outlined),
                    color: Colors.white,
                  )
                ],
              ),
              // action: SnackBarAction(
              //   label: 'Undo',
              //   onPressed: () {
              //     // Some code to undo the change.
              //   },
              // ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          color: Colors.black,
        ),
        title: customSearchBar,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customIcon = const Icon(
                    Icons.cancel,
                    color: Colors.black,
                  );
                  customSearchBar = ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 28,
                    ),
                    title: TextField(
                      controller: editingController,
                      onChanged: _filter,
                      decoration: InputDecoration(
                        hintText: 'Introduce una marca de coche...',
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  );
                } else {
                  customIcon = const Icon(
                    Icons.search,
                    color: Colors.black,
                  );
                  customSearchBar = const Text(
                    'Wongo',
                    style: TextStyle(color: Colors.black),
                  );
                }
              });
            },
            icon: customIcon,
          )
        ],
        centerTitle: true,
      ),
      body: Consumer<CocheProvider>(
        builder: (context, cocheProvider, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Dismissible(
                  background: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Container(
                      child: Icon(Icons.delete_outline_rounded,
                          color: Colors.white),
                      alignment: Alignment.centerLeft,
                      color: Color.fromARGB(255, 1, 255, 22),
                      padding: EdgeInsets.only(left: 10),
                    ),
                  ),
                  secondaryBackground: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Container(
                      child: Icon(Icons.delete_outline_rounded,
                          color: Colors.white),
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      padding: EdgeInsets.only(right: 10),
                    ),
                  ),
                  key: UniqueKey(),
                  onDismissed: (DismissDirection direction) async {
                    cocheProvider.allCoches.removeAt(index);
                    print(index);
                    print(cocheProvider.allCoches[index].id);
                    await cocheProvider
                        .deleteCoche(cocheProvider.allCoches[index]);
                  },
                  child: tile(cocheProvider.allCoches[index], context));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add');
        },
        child: Material(
          // Replace this child with your own
          elevation: 8.0,
          shape: CircleBorder(),
          child: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 0, 237, 100),
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
            radius: 24.0,
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
