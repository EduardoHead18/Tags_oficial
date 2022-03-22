import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tags_oficial/colores/colores.dart';
import 'package:tags_oficial/pages/login.dart';
import 'agregarAjustes.dart';

void main() => runApp(Ajustes());

class Ajustes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Ajustes",
              style:
                  TextStyle(fontSize: 30, color: colores.textSecondaryColor)),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: FadeInDown(
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Agregar()),
                      );
                    },
                    color: Colors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 80, vertical: 15.0),
                    label: Text(
                      "Modificar Cuenta",
                      style: TextStyle(
                          fontSize: 20, color: colores.textSecondaryColor),
                    ),
                    icon: const Icon(
                      Icons.arrow_forward,
                      size: 20,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                    highlightColor: Color.fromARGB(255, 153, 255, 122),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  RaisedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    color: Colors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 95, vertical: 15.0),
                    label: Text(
                      "Cerrar Sesión",
                      style: TextStyle(
                          fontSize: 20, color: colores.textSecondaryColor),
                    ),
                    icon: const Icon(
                      Icons.logout,
                      size: 20,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 5,
                    highlightColor: Color.fromARGB(255, 153, 255, 122),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
