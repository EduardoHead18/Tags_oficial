import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tags_oficial/pages/bluetooth.dart';
import 'package:tags_oficial/pages/home.dart';
import 'package:tags_oficial/pages/login.dart';
import 'package:tags_oficial/pages/tabs.dart';
import 'package:tags_oficial/pages/tags.dart';
import 'package:tags_oficial/pages/ubicacion.dart';

import '../class/usuarios.dart';

//void main() => runApp(MyApp());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tags',
      debugShowCheckedModeBanner: false,

      //rutas de la aplicacion.

      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => Login(),
        'tabs': (BuildContext context) => Tabs(),
        'home': (BuildContext context) => Homepage(),
        'bluetooth': (BuildContext context) => Bluetooth(),
        'ubicacion': (BuildContext context) => Ubicacion(),
        'tags': (BuildContext context) => Tags()
      },
    );
  }
}
