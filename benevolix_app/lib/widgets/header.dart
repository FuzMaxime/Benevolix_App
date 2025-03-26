import 'package:flutter/material.dart';

class HeaderAuth extends StatelessWidget {
  final String title;

  const HeaderAuth({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Image.asset('assets/images/Benevolix.png'),
        ),
      ],
    );
  }
}
