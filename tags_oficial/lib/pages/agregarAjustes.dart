import 'package:animate_do/animate_do.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tags_oficial/colores/colores.dart';
import 'package:tags_oficial/pages/tabs.dart';

import '../class/usuarios.dart';

void main() => runApp(Agregar());

class Agregar extends StatefulWidget {
  @override
  State<Agregar> createState() => _AgregarState();
}

class _AgregarState extends State<Agregar> {
  final _formKey = GlobalKey<FormState>();
  String _nombreCliente = "";
  String _usuario = "";
  String _contra = "";
  String _confirmarContra = "";
  //controlador para el textFormField.

  final controllerNameClient = TextEditingController();
  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    controllerNameClient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text("Modificar",
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
                    _txtNombreCliente(),
                    Divider(
                      height: 20,
                      color: Colors.white,
                    ),
                    _botonGuardar(),
                    Divider(
                      height: 20,
                      color: Colors.white,
                    ),
                    _botonCancelar(),
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

  Widget _txtNombreCliente() {
    return Container(
        padding: EdgeInsets.only(top: 0.0, left: 30.0, right: 30.0),
        child: TextFormField(
          //controlador del nombre
          controller: controllerNameClient,
          decoration: InputDecoration(
              labelText: 'Nombre de cliente',
              labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              hintText: 'Ingresa tu nombre de usuario'),
          keyboardType: TextInputType.text,
          validator: (valor) {
            if (valor!.isEmpty) {
              return "Escriba un nombre de cliente";
            }
            return null;
          },
          onSaved: (valor) {
            return setState(() {
              _usuario = valor!;
            });
          },
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
              if (_formKey.currentState!.validate()) {
                DatabaseReference ref = FirebaseDatabase.instance.reference();
                await ref.update({
                  "Tl3LuaHhP3YjpLvoVrSs24XcTuS2/usuario1/nombre":
                      controllerNameClient.text,
                });
                Fluttertoast.showToast(msg: "Datos Guardados");
                Navigator.of(context).pushNamedAndRemoveUntil(
                    'tabs', (Route<dynamic> route) => false);
              }
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

  Widget _botonCancelar() {
    return Container(
        padding: EdgeInsets.only(top: 0.0, left: 30.0, right: 30.0),
        height: 40.0,
        child: Material(
          borderRadius: BorderRadius.circular(20.0),
          shadowColor: Color.fromARGB(255, 0, 0, 0),
          color: Colors.red[700],
          elevation: 7.0,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  'tabs', (Route<dynamic> route) => false);
            },
            child: Center(
              child: Text(
                'Cancelar',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              ),
            ),
          ),
        ));
  }

  obtener() async {
    final ref = FirebaseDatabase.instance.reference();
    //obtener usuario
    final snapshot1 = await ref
        .child('"Tl3LuaHhP3YjpLvoVrSs24XcTuS2/usuario1/nombre_usuario"')
        .get();
    return snapshot1.value;
  }
}
