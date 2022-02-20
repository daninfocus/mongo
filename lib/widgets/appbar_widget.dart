import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarWidget extends AppBar {
  BuildContext context;

  String appBarTitle;

  bool isDarkTheme;

  AppBarWidget(this.context, this.appBarTitle, this.isDarkTheme)
      : super(
            actions: [
              IconButton(
                onPressed: () => null,
                icon: Icon(Icons.search),
                color: Colors.black,
              ),
              SizedBox(
                width: 15,
              )
            ],
            title: Text(
              '${appBarTitle}',
              style: TextStyle(
                  fontSize: 25,
                  color: isDarkTheme ? Colors.white : Colors.black,
                  fontFamily: 'SF-Compact'),
            ),
            leading: AnimatedButton(
              text: '?',
              buttonTextStyle:
                  TextStyle(color: isDarkTheme ? Colors.white : Colors.black),
              color: Colors.transparent,
              pressEvent: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.INFO_REVERSED,
                  borderSide: BorderSide(color: Colors.green, width: 2),
                  width: 280,
                  buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                  headerAnimationLoop: false,
                  animType: AnimType.BOTTOMSLIDE,
                  title: '',
                  desc: 'Mongo Crud con datos de Mockaroo',
                  showCloseIcon: true,
                  btnOkOnPress: () {},
                ).show();
              },
            ),
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
                  color: Colors.transparent,
                ),
              ),
            ));
}
