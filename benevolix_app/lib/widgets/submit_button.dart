import 'package:benevolix_app/constants/color.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatefulWidget {
  final String text;
  final Function onPressed;
  final bool isLoading;

  const SubmitButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.isLoading});

  @override
  State<StatefulWidget> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => widget.onPressed.call(),
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstant.red,
        fixedSize: Size(400, 50),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: widget.isLoading
          ? CircularProgressIndicator(color: ColorConstant.white)
          : Text(widget.text,
              style: TextStyle(
                  fontSize: 18,
                  color: ColorConstant.white,
                  fontFamily: "Poppins")),
    );
  }
}
