import 'package:flutter/material.dart';

import 'color.dart';

//decoration des zone d'input
getInputDecoration(String text) {
  return InputDecoration(
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      contentPadding: EdgeInsets.all(18.0),
      labelStyle: TextStyle(
          color: ColorConstant.darkGrey,
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins"),
      labelText: text);
}
