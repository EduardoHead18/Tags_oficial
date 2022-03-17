import 'package:animate_do/animate_do.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tags_oficial/colores/colores.dart';
import 'package:tags_oficial/pages/home.dart';
import 'package:tags_oficial/pages/tabs.dart';

import '../class/usuarios.dart';

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
  @override
  void _ver() {
    setState(() {
      _vercontra = !_vercontra;
    });
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
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textLogin(),
              //_logo(),
              _txtUsuario(),
              _txtContra(),
              _botonMostrar(),
              _botonIngresar(),
              //_botonRegistrar()
            ],
          ),
        ),
      ),
      key: _formKey,
    );
  }

  Widget _textLogin() {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
          child: Text(
            'Login',
            style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
          child: Text(
            'Tags',
            style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(195.0, 175.0, 0.0, 0.0),
          child: Text(
            '.',
            style: TextStyle(
                fontSize: 80.0,
                fontWeight: FontWeight.bold,
                color: Colors.green),
          ),
        ),
      ],
    );
  }

  Widget _txtUsuario() {
    return Container(
        padding: EdgeInsets.only(top: 0.0, left: 30.0, right: 30.0),
        child: TextFormField(
          initialValue: _usuario,
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
          initialValue: _contra,
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
              if (_formKey.currentState!.validate()) {
                final ref = FirebaseDatabase.instance.reference();
                //obtener usuario
                final snapshot1 =
                    await ref.child('usuarios/usuario1/nombre_usuario').get();
                //obtener contraseña
                final snapshot2 =
                    await ref.child('usuarios/usuario1/password').get();
                if (snapshot1.exists && snapshot2.exists) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Tabs()),
                  );
                  print(snapshot1.value);
                  print(snapshot2.value);
                } else {
                  print('No data available.');
                }
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

  //registrarse
/*
  Widget _botonRegistrar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '¿Nuevo en Tags?',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Tabs()),
            );
          },
          child: Text('Registrar',
              style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline)),
        ),
      ],
    );
  }
  */

}
