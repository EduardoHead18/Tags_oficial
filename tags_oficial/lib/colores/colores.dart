//CLASE DE ESTILOS
import 'package:flutter/material.dart';

Colores colores = Colores();

class Colores {
  Color? backgroundSecondaryColor;
  Color? appColorPrimaryLightColor;
  Color? textSecondaryColor;
  Color? appBarColor;
  Color? iconColor;
  Color? iconSecondaryColor;
  Color? tap;

  Colores() {
    backgroundSecondaryColor = Color(0xFF8BC34A);
    appColorPrimaryLightColor = Color(0xFFF9FAFF);
    textSecondaryColor = Color(0xFF5A5C5E);
    appBarColor = Color(0xFFA5D6A7);
    iconColor = Color(0xFFFFFFFF);
    iconSecondaryColor = Color(0xFFCFD8DC);
    tap = Color.fromARGB(255, 0, 151, 215);
  }
}
