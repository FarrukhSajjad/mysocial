import 'package:flutter/material.dart';

AppBar header(context, {String title, bool removeBackButton = false}) {
  return AppBar(
    automaticallyImplyLeading: removeBackButton ? false : true,
    backgroundColor: Colors.redAccent,
    title: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Signatra',
        fontSize: 50.0,
      ),
    ),
    centerTitle: true,
  );
}
