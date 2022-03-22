import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Registro {
  //late final String NombreUusario;
  late String nombre;
  late String password;
  late double destino;
  late String objeto_mascota;
  // ignore: non_constant_identifier_names
  late String nombre_usuario;
  //late final String pass;

  Registro.fromMap(dynamic map) {
    assert(map['nombre'] != null);
    assert(map['objeto_mascota'] != null);
    nombre = map['nombre'];
    objeto_mascota = map['objeto_mascota'];
    //nombre_usuario = map['nombre_usuario'];
    //destino = map['destino'];

    @override
    String toString() => "usuarios<$nombre>,usuarios<$objeto_mascota>";
  }
}
