import 'package:flutter/material.dart';
import 'package:tags_oficial/bluetooth/MainPage.dart';

void main() => runApp(new Bluetooth());

class Bluetooth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainPage());
  }
}
