import 'package:animate_do/animate_do.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tags_oficial/colores/colores.dart';

import '../class/usuarios.dart';

void main() => runApp(Homepage());

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _bodyRealTimeDB());
  }
}

/*
dataUser() async {
  final ref = FirebaseDatabase.instance.reference();
  //obtener usuario
  final snapshot1 = await ref.child('usuarios/usuario1/nombre_usuario').get();
  if (snapshot1.exists) {
    return Text("Buenas Tardes " + snapshot1.value,
        style: TextStyle(fontSize: 30, color: colores.textSecondaryColor));
  }
}

Image _imagen() => Image.asset('assets/dog2.png');

*/
Widget _bodyRealTimeDB() {
  return Center(
    child: StreamBuilder<Event>(
      stream: FirebaseDatabase.instance
          .reference()
          .child("Tl3LuaHhP3YjpLvoVrSs24XcTuS2")
          .child("usuario1")
          .onValue,
      builder: (context, evento) {
        if (!evento.hasData)
          return CircularProgressIndicator(color: Colors.deepPurple);
        final Registro r = Registro.fromMap(evento.data?.snapshot.value);
        return Center(
          child: FadeInDown(
            child: Container(
              padding: const EdgeInsets.all(38),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _nombre(r.nombre),
                    Divider(
                      color: Color.fromARGB(0, 255, 255, 255),
                      height: 150,
                    ),
                    _imagen()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

Text _nombre(String name) => Text("Hola, Bienvenido " + name.toString(),
    style: TextStyle(fontSize: 30, color: colores.textSecondaryColor));

Image _imagen() => Image.asset('assets/dog2.png');


/*
Widget vistaHome() {
  return Scaffold(
      body: Center(
          child: FadeInDown(
    child: Container(
        padding: const EdgeInsets.all(38),
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          FadeIn(
            duration: Duration(seconds: 2),
            child: Text("Buenas Tardes",
                style:
                    TextStyle(fontSize: 30, color: colores.textSecondaryColor)),
          ),
          Image.asset('assets/dog2.png')
        ]))),
  )));
}
 */
