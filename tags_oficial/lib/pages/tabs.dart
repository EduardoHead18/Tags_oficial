import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tags_oficial/colores/colores.dart';
import 'package:tags_oficial/pages/ajustes.dart';
import 'package:tags_oficial/pages/home.dart';
import 'package:tags_oficial/pages/tags.dart';

import 'bluetooth.dart';

class Tabs extends StatefulWidget {
  //Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _index = 0;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: colores.iconSecondaryColor));
    return Scaffold(
      body: PageView(
        /*onPageChanged: (index) {
          setState(() => _index = index);
        },*/
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: [Homepage(), /*Ubicacion(),*/ MainPage(), Tags(), Ajustes()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() => _index = index);
          _controller.animateToPage(_index,
              duration: Duration(microseconds: 240), curve: Curves.easeInOut);
        },
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        //selectedItemColor: appStore.backgroundSecondaryColor,
        unselectedItemColor: colores.iconColor,
        backgroundColor: colores.appBarColor,
        //selectedItemColor: Theme.of(context).primaryColor,

        items: [
          BottomNavigationBarItem(
              icon:
                  Icon(Icons.home, color: colores.iconSecondaryColor, size: 30),
              backgroundColor: colores.appBarColor,
              label: "",
              activeIcon: Icon(
                Icons.home,
                color: colores.iconColor,
                size: 30,
              )),

          //2
          /*
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on,
                  color: colores.iconSecondaryColor, size: 30),
              backgroundColor: colores.appBarColor,
              label: "",
              activeIcon: Icon(
                Icons.location_on,
                color: colores.iconColor,
                size: 30,
              )),

              */

          //3
          BottomNavigationBarItem(
              icon: Icon(Icons.bluetooth,
                  color: colores.iconSecondaryColor, size: 30),
              backgroundColor: colores.appBarColor,
              label: "",
              activeIcon: Icon(
                Icons.bluetooth,
                color: colores.iconColor,
                size: 30,
              )),

          //4
          BottomNavigationBarItem(
              icon: Icon(Icons.add_chart_rounded,
                  color: colores.iconSecondaryColor, size: 30),
              backgroundColor: colores.appBarColor,
              label: "",
              activeIcon: Icon(
                Icons.add_chart_rounded,
                color: colores.iconColor,
                size: 30,
              )),

          //5
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: colores.iconSecondaryColor,
                size: 30,
              ),
              backgroundColor: colores.appBarColor,
              label: "",
              activeIcon: Icon(
                Icons.settings,
                color: colores.iconColor,
                size: 30,
              )),
        ],
      ),
    );
  }
}
