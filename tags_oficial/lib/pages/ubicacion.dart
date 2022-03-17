import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tags_oficial/maps/directions_model.dart';

class Ubicacion extends StatelessWidget {
  late GoogleMapController _mapController;
  Directions? _info;
  late Dio _dio;
  final LatLng Puntoinicio = LatLng(16.90998093016416, -92.09027151281458);
  final LatLng Destino = LatLng(16.906696116767225, -92.09336141729014);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text('Buscando Mochila'),
          actions: [
            TextButton(
              onPressed: () => _mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: Puntoinicio,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.green,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('ORIGIN'),
            ),
            TextButton(
              onPressed: () => _mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: Destino,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.yellow,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('DEST'),
            )
          ],
        ),
        body: _body(),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.zoom_out_map),
            onPressed: () {
              _centerView();
            }));
  }

  //Mostrar el mapa en pantalla
  Widget _body() {
    return Stack(alignment: Alignment.center, children: [
      GoogleMap(
        initialCameraPosition: CameraPosition(target: Puntoinicio, zoom: 12),
        markers: _createMarkers(),
        onMapCreated: _createMapa,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
      Positioned(
        top: 20.0,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 6.0,
            horizontal: 12.0,
          ),
          decoration: BoxDecoration(
            color: Colors.yellowAccent,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              )
            ],
          ),
          child: Text(
            '${_info?.totalDistance}, ${_info?.totalDuration}',
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ]);
  }

  //Colocar marcacion de ambos sitios
  Set<Marker> _createMarkers() {
    var tmp = Set<Marker>();
    tmp.add(Marker(
        markerId: MarkerId('Puntoinicio'),
        position: Puntoinicio,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(title: "Inicio")));
    tmp.add(Marker(
        markerId: MarkerId('Destino'),
        position: Destino,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        infoWindow: InfoWindow(title: "Mochila")));
    return tmp;
  }

  _createMapa(GoogleMapController controller) {
    _mapController = controller;
    _centerView();
  }

  _centerView() async {
    //var api =Provider.of<Direccion>;
    await _mapController.getVisibleRegion();
    print("Buscando Direcciones");

    //await api.findDirecctions(Puntoinicio, Destino);
    await _mapController.getVisibleRegion();
    var izquieda = min(Puntoinicio.latitude, Destino.latitude);
    var derecha = max(Puntoinicio.latitude, Destino.latitude);
    var top = max(Puntoinicio.longitude, Destino.longitude);
    var botton = min(Puntoinicio.longitude, Destino.longitude);

    /*api.correntRoute.first.points.forEach((point) {
     izquieda= min(izquieda ,point.latitude);
     derecha=max(derecha, point.latitude);
     top=max(top, point.longitude);
     botton= min(botton, point.longitude);
    });
    */
    var bounds = LatLngBounds(
        southwest: LatLng(izquieda, botton), northeast: LatLng(derecha, top));
    var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
    _mapController.animateCamera(cameraUpdate);
  }
}












/*import 'package:flutter/material.dart';
import 'package:tags_oficial/class/usuarios.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

Future iniciarFire() async {
  FirebaseApp initialization = await Firebase.initializeApp();
  return initialization;
}

class Ubicacion extends StatefulWidget {
  @override
  State<Ubicacion> createState() => _UbicacionState();
}

class _UbicacionState extends State<Ubicacion> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(body: _bodyRealTimeDB());
    return Material(
      child: Center(
        child: FutureBuilder(
          future: iniciarFire(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _bodyRealTimeDB();
            } else {
              return const CircularProgressIndicator(color: Colors.deepPurple);
            }
          },
        ),
      ),
    );
  }
}

Widget _bodyRealTimeDB() {
  return StreamBuilder<Event>(
    stream: FirebaseDatabase.instance
        .reference()
        .child("usuarios")
        .child("usuario1")
        .onValue,
    builder: (context, evento) {
      if (!evento.hasData)
        return CircularProgressIndicator(color: Colors.deepPurple);
      final Registro r = Registro.fromMap(evento.data?.snapshot.value);
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_nombre(r.nombre)],
        ),
      );
    },
  );
}

Text _nombre(String name) => Text("Nombre: " + name.toString());
*/







