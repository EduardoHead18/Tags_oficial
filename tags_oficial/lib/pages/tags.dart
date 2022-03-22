import 'package:animate_do/animate_do.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tags_oficial/colores/colores.dart';
import 'package:tags_oficial/pages/tabs.dart';

void main() => runApp(Tags());

class Tags extends StatefulWidget {
  @override
  State<Tags> createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  final _formKey = GlobalKey<FormState>();
  String _nombreMascotaObjeto = "";
  //controlador para el textFormField.
  final controllerNombreMascota = TextEditingController();
  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    controllerNombreMascota.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Tags",
              style:
                  TextStyle(fontSize: 30, color: colores.textSecondaryColor)),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          centerTitle: true,
        ),
        body: Form(
          child: FadeInDown(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Divider(
                      height: 20,
                      color: Colors.white,
                    ),
                    _txtNombreDelObjeto(),
                    Divider(
                      height: 20,
                      color: Colors.white,
                    ),
                    _botonGuardar(),
                    Divider(
                      height: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          key: _formKey,
        ));
  }

  Widget _txtNombreDelObjeto() {
    return Container(
        padding: EdgeInsets.only(top: 0.0, left: 30.0, right: 30.0),
        child: TextFormField(
          //controlador del nombre
          controller: controllerNombreMascota,
          decoration: InputDecoration(
              labelText: 'Nombre del objeto u mascota',
              labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              hintText: 'Ingresa un nombre de objeto u mascota'),
          keyboardType: TextInputType.text,
        ));
  }

  Widget _botonGuardar() {
    return Container(
        padding: EdgeInsets.only(top: 0.0, left: 30.0, right: 30.0),
        height: 40.0,
        child: Material(
          borderRadius: BorderRadius.circular(20.0),
          shadowColor: Color.fromARGB(255, 0, 0, 0),
          color: colores.backgroundSecondaryColor,
          elevation: 7.0,
          child: TextButton(
            onPressed: () async {
              DatabaseReference ref = FirebaseDatabase.instance.reference();
              await ref.update({
                "usuarios/usuario1/objeto_mascota":
                    controllerNombreMascota.text,
              });
              Fluttertoast.showToast(msg: "Datos Guardados");
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) => Tabs()));
            },
            child: Center(
              child: Text(
                'Guardar',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              ),
            ),
          ),
        ));
  }
}
