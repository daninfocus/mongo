import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mongo/pages/home_page.dart';
import 'package:mongo/provider/coche_provider.dart';
import 'package:provider/provider.dart';

import '../model/coche.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cocheProvider = Provider.of<CocheProvider>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: cocheProvider.setAllCoches(),
        builder: (context, AsyncSnapshot<List<Coche>> snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return SpinKitPouringHourGlassRefined(
              color: Colors.green.shade200,
            );
          }
        },
      ),
    );
  }
}
