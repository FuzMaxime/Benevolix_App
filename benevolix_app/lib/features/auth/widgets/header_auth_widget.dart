import 'package:flutter/material.dart';

import '../../../core/constants/color.dart';


class HeaderAuth extends StatelessWidget {
  final String title;

  const HeaderAuth({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 60.0,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Image.asset('assets/images/Benevolix.png', width: 250),
        ),
        Column(
          spacing: 25.0,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    color: ColorConstant.red,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                )),
            Text(
              "Bienvenue sur l'application de bénévolat entre gaulois",
              style: TextStyle(
                color: ColorConstant.grey,
                fontWeight: FontWeight.w400,
                fontSize: 15.0,
              ),
            )
          ],
        ),
      ],
    );
  }
}
