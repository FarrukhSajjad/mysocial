import 'package:flutter/material.dart';

circularProgressBar() {
  return CircularProgressIndicator(
    backgroundColor: Colors.red,
    valueColor: AlwaysStoppedAnimation(Colors.black45),
  );
}

linearProgressBar() {
  return LinearProgressIndicator();
}
