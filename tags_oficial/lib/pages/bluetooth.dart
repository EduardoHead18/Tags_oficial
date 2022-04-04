import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../bluetooth/ChatPage.dart';
import '../bluetooth/DiscoveryPage.dart';
import '../bluetooth/SelectBondedDevicePage.dart';
import '../class/usuarios.dart';
import '../colores/colores.dart';

// import './helpers/LineChart.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => new _MainPage();
}

class _MainPage extends State<MainPage> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String _address = "...";
  String _name = "...";

  Timer? _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  //BackgroundCollectingTask? _collectingTask;

  bool _autoAcceptPairingRequests = false;

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address!;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name!;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        // Discoverable mode is disabled when Bluetooth gets disabled
        _discoverableTimeoutTimer = null;
        _discoverableTimeoutSecondsLeft = 0;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    // _collectingTask?.dispose();
    _discoverableTimeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text("Bluetooth",
            style: TextStyle(fontSize: 30, color: colores.textSecondaryColor)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            _nombreObjeto(),
            Divider(),
            _wifiConexion(),
            _wifi(),
            Divider(),
            _bluetoothConexion(),
            SwitchListTile(
              activeColor: colores.backgroundSecondaryColor,
              title: const Text('Habilitar Bluetooth'),
              value: _bluetoothState.isEnabled,
              onChanged: (bool value) {
                // Do the request and update with the true value then
                future() async {
                  // async lambda seems to not working
                  if (value)
                    await FlutterBluetoothSerial.instance.requestEnable();
                  else
                    await FlutterBluetoothSerial.instance.requestDisable();
                }

                future().then((_) {
                  setState(() {});
                });
              },
            ),
            ListTile(
              title: const Text('Nombre del Dispositivo'),
              subtitle: Text(_name),
              onLongPress: null,
            ),
            Divider(),
            SwitchListTile(
              activeColor: colores.backgroundSecondaryColor,
              title: const Text('Pin de conexión'),
              subtitle: const Text('Pin 1234'),
              value: _autoAcceptPairingRequests,
              onChanged: (bool value) {
                setState(() {
                  _autoAcceptPairingRequests = value;
                });
                if (value) {
                  FlutterBluetoothSerial.instance.setPairingRequestHandler(
                      (BluetoothPairingRequest request) {
                    print("Trying to auto-pair with Pin 1234");
                    if (request.pairingVariant == PairingVariant.Pin) {
                      return Future.value("1234");
                    }
                    return Future.value(null);
                  });
                } else {
                  FlutterBluetoothSerial.instance
                      .setPairingRequestHandler(null);
                }
              },
            ),
            ListTile(
              title: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: colores.backgroundSecondaryColor,
                  ),
                  child: const Text('Explorar Nuevos Dispositivos'),
                  onPressed: () async {
                    final BluetoothDevice? selectedDevice =
                        await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return DiscoveryPage();
                        },
                      ),
                    );

                    if (selectedDevice != null) {
                      print('Discovery -> selected ' + selectedDevice.address);
                    } else {
                      print('Discovery -> no device selected');
                    }
                  }),
            ),
            ListTile(
              title: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: colores.backgroundSecondaryColor,
                ),
                child: const Text('Conectar Para Encender Sonido'),
                onPressed: () async {
                  final BluetoothDevice? selectedDevice =
                      await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SelectBondedDevicePage(checkAvailability: false);
                      },
                    ),
                  );

                  if (selectedDevice != null) {
                    print('Connect -> selected ' + selectedDevice.address);
                    _startChat(context, selectedDevice);
                  } else {
                    print('Connect -> no device selected');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ChatPage(server: server);
        },
      ),
    );
  }
}

Widget _nombreObjeto() {
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/search.png'),
                    Center(
                      child: Text(
                          "Objetivo a buscar:  " + r.objeto_mascota.toString(),
                          style: TextStyle(
                              fontSize: 20, color: colores.textSecondaryColor)),
                    )
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

//conexion con wifi.

Widget _wifiConexion() {
  return Container(
    child: Center(
        child: Text("Conexión con wifi",
            style: TextStyle(fontSize: 20, color: colores.textSecondaryColor))),
  );
}

Widget _wifi() {
  return SafeArea(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Container(
          padding: const EdgeInsets.all(80),
          width: double.infinity,
          child: FittedBox(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //encender
              FloatingActionButton(
                onPressed: () async {
                  bool estado = true;
                  DatabaseReference ref = FirebaseDatabase.instance.reference();
                  await ref.update({
                    "Tl3LuaHhP3YjpLvoVrSs24XcTuS2/usuario1/Encender": estado
                  });
                },
                backgroundColor: colores.backgroundSecondaryColor,
                child: const Icon(
                  Icons.volume_up,
                  size: 25,
                ),
              ),
              //apagar
              FloatingActionButton(
                onPressed: () async {
                  bool estado = false;
                  DatabaseReference ref = FirebaseDatabase.instance.reference();
                  await ref.update({
                    "Tl3LuaHhP3YjpLvoVrSs24XcTuS2/usuario1/Encender": estado
                  });
                },
                backgroundColor: Colors.red,
                child: const Icon(
                  Icons.volume_off,
                  size: 25,
                ),
              ),
            ],
          ))),
    ],
  ));
}

Widget _bluetoothConexion() {
  return Container(
    child: Center(
        child: Text("Conexión con bluetooth",
            style: TextStyle(fontSize: 20, color: colores.textSecondaryColor))),
  );
}
