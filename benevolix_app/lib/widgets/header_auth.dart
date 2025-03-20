import 'package:flutter/material.dart';

import '../constants/color.dart';

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
          child: Image.asset('assets/images/Benevolix.png'),
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
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                )),
            Text(
              "Ti brudet prenañ doñv c’hoari poull mat paeañ Brasparz kribañ e daouarn  goleiñ zo",
              style: TextStyle(
                  color: ColorConstant.grey, fontWeight: FontWeight.w400),
            )
          ],
        ),
      ],
    );
  }
}
