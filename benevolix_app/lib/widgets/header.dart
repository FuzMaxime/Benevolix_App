import 'package:benevolix_app/constants/color.dart';
import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  final String title;

  const MainHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorConstant.black),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(width: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              'assets/images/Benevolix.png',
              // TODO : use constant image size
              width: 50,
            ),
          ),
          const SizedBox(width: 16),
          Text("Nom de l'utilisateur",
              style: TextStyle(
                  color: ColorConstant.white,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                  fontSize: 20))
        ],
      ),
    );
  }
}
