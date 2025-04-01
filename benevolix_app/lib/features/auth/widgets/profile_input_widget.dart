import 'package:flutter/material.dart';

import '../../../core/constants/color.dart';

class ProfileInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool error;

  const ProfileInput({
    super.key,
    required this.label,
    required this.controller,
    this.hintText = "",
    this.isPassword = false,
    this.error = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ColorConstant.black)),
        SizedBox(height: 5),
        SizedBox(
          height: 45,
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: error ? ColorConstant.red : ColorConstant.lightGrey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: error ? ColorConstant.red : ColorConstant.black,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: error ? ColorConstant.red : ColorConstant.lightGrey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              hintText: hintText,
            ),
          ),
        ),
      ],
    );
  }
}
