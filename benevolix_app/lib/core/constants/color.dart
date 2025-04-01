import 'dart:ui';

//Gestion centralisé des couleurs
class ColorConstant {
  static Color darkRed = hexToColor("#FA3D3745");
  static Color red = hexToColor("#FA3D37");
  static Color lightRed = hexToColor("#64FF7B74");
  static Color black = hexToColor("#1D1B20");
  static Color darkGrey = hexToColor("#353535");
  static Color grey = hexToColor("#595959");
  static Color lightGrey = hexToColor("#A8AAB6");
  static Color white = hexToColor("#fffefb");
  static Color cardBg = hexToColor("#F3F3F7");
}

//transformation de l'hexadécimal en coleur utilisable
Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
