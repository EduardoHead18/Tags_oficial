import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tags_oficial/colores/colores.dart';
import 'package:tags_oficial/pages/tabs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _usuario = "";
  String _contra = "";
  bool _vercontra = true;

  //controlador para el textFormField.
  final controllerUserName = TextEditingController();
  final controllerPass = TextEditingController();

  @override
  void _ver() {
    setState(() {
      _vercontra = !_vercontra;
    });
    @override
    void dispose() {
      // Limpia el controlador cuando el Widget se descarte
      controllerUserName.dispose();
      controllerPass.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: _body()),
    );
  }

  Widget _body() {
    return Form(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _logo(),
              _txtUsuario(),
              _txtContra(),
              _botonMostrar(),
              _botonIngresar(),
              Divider(
                height: 20,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      key: _formKey,
    );
  }

  Widget _logo() {
    return Container(
      padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
      width: 200,
      height: 200,
      child: Center(
        child: Image.asset('assets/Logo2.png'),
      ),
    );
  }

  Widget _txtUsuario() {
    return Container(
        padding: EdgeInsets.only(top: 0.0, left: 30.0, right: 30.0),
        child: TextFormField(
          //controlador del nombre
          controller: controllerUserName,
          decoration: InputDecoration(
              labelText: 'Usuario',
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
              return "Debe ingresar su nombre de usuario";
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

  Widget _txtContra() {
    return Container(
        padding: EdgeInsets.only(top: 0.0, left: 30.0, right: 30.0),
        child: TextFormField(
          //controlador de la contraseña
          controller: controllerPass,
          decoration: InputDecoration(
              labelText: 'Contraseña',
              labelStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              hintText: 'Ingresa tu contraseña de usuario'),
          obscureText: _vercontra,
          keyboardType: TextInputType.visiblePassword,
          validator: (valor) {
            if (valor!.isEmpty) {
              return "Debe ingresar su contrseña de usuario";
            }
            return null;
          },
          onSaved: (valor) {
            return setState(() {
              _contra = valor!;
            });
          },
        ));
  }

  Widget _botonMostrar() {
    return SizedBox(
      child: Container(
        alignment: Alignment(1.0, 0.0),
        padding: EdgeInsets.only(top: 12.0, right: 20.0),
        child: TextButton(
          onPressed: _ver,
          child: Text(
            _vercontra ? 'Mostrar Contraseña' : 'Ocultar Contraseña',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: colores.backgroundSecondaryColor,
                decoration: TextDecoration.underline),
          ),
        ),
      ),
    );
  }

  Widget _botonIngresar() {
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
              try {
                final result = await InternetAddress.lookup('google.com');
                if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                  if (_formKey.currentState!.validate()) {
                    final ref = FirebaseDatabase.instance.reference();
                    //obtener usuario
                    final snapshot1 = await ref
                        .child('usuarios/usuario1/nombre_usuario')
                        .get();
                    //obtener contraseña
                    final snapshot2 =
                        await ref.child('usuarios/usuario1/password').get();
                    if (snapshot1.exists && snapshot2.exists) {
                      if (snapshot1.value == controllerUserName.text &&
                          snapshot2.value == controllerPass.text) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Tabs()),
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "Error verifique el usuario o contraseña",
                        );
                      }
                    }
                  }
                }
              } on SocketException catch (_) {
                Fluttertoast.showToast(msg: 'Revise su conexion a internet');
              }
            },
            child: Center(
              child: Text(
                'INICIAR SESION',
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
