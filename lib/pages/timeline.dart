import 'package:flutter/material.dart';
import 'package:mysocial/widgets/header.dart';
import 'dart:core';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: header(context, title: 'DumbInsta'),
      body: Center(
        child: Text('Timeline'),
      ),
    );
  }
}
