/*class NombreUsuario {
  String nombre = "";
  late DocumentReference referencia;

  //NameUs(this.nombre);

  NombreUsuario.fromMap(
      Map<String, dynamic> map) //, {required this.referencia})
      : assert(map['nombre'] != null),
        nombre = map['nombre'];

  NombreUsuario.fromSnapshot(AsyncSnapshot snapshot)
      : this.fromMap(snapshot.data()); //, referencia: snapshot.requireData);
  /*: assert(snapshot.get),
        nombre = snapshot.get!;*/
}*/

class Registro {
  //late final String NombreUusario;
  late String nombre;
  late String password;
  // ignore: non_constant_identifier_names
  late String nombre_usuario;
  //late final String pass;

  Registro.fromMap(dynamic map) {
    assert(map['nombre'] != null);
    assert(map['password'] != null);
    assert(map['nombre_usuario'] != null);
    nombre = map['nombre'];
    password = map['password'];
    nombre_usuario = map['nombre_usuario'];

    @override
    String toString() =>
        "usuarios<$nombre>,usuarios<$password>,usuarios<$nombre_usuario>";
  }
}
