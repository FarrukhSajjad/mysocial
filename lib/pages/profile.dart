import 'package:flutter/material.dart';
import 'package:mysocial/widgets/header.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, title: 'Profile'),
      body: Container(
        child: Center(
          child: Text('Profile'),
        ),
      ),
    );
  }
}
