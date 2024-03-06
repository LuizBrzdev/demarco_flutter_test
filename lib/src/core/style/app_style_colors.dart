import 'package:demarco_flutter_test/src/shared/utils/color/hex_to_color.dart';
import 'package:flutter/material.dart';

///[AppStyleColors] Classe que contém as cores da aplicação
class AppStyleColors {
  static final primary = HexToColor.convertHexToColor('#272727');
  static const white = Colors.white;
  static const grey = Colors.grey;
  static const black = Colors.black;
  static final Color errorPrimary = HexToColor.convertHexToColor('#DC2626');
}
