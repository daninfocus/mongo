import 'package:flutter/material.dart';
import 'package:mongo/pages/splash_page.dart';
import 'package:mongo/services/db_connection_service.dart';
import 'package:provider/provider.dart';

import 'provider/coche_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CocheProvider>(
            create: (context) => CocheProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mongo',
        home: SplashPage(),
      ),
    );
  }
}
