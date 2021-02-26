import 'package:flutter/material.dart';
import 'package:mysocial/widgets/header.dart';

class ActivityFeed extends StatefulWidget {
  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, title: 'Notificaitons'),
      body: Container(
        child: Center(
          child: Text('Activity Feed'),
        ),
      ),
    );
  }
}
