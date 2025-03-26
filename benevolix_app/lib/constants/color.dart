import 'dart:ui';

class ColorConstant {
  static Color red = hexToColor("#FA3D37");
  static Color lightRed = hexToColor("#64FF7B74");
  static Color black = hexToColor("#1D1B20");
  static Color darkGrey = hexToColor("#353535");
  static Color grey = hexToColor("#595959");
  static Color lightGrey = hexToColor("#A8AAB6");
  static Color white = hexToColor("#fffefb");
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
