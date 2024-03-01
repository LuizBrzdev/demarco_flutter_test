import 'package:flutter/material.dart';

abstract class HexToColor {
  static Color convertHexToColor(String code) {
    code = code.replaceAll('#', '');
    return Color(int.parse(code, radix: 16) + 0xFF000000);
  }
}
