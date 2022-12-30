import 'package:flutter/material.dart';

class RectangleButton extends StatelessWidget {
  final String btnTxt;
  final double txtSize;
  final FontWeight fontWeight;
  final Function onTap;
  const RectangleButton(
      {Key? key,
      required this.btnTxt,
      required this.onTap,
      this.txtSize = 18.0,
      this.fontWeight = FontWeight.w900})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFF0063F7),
        foregroundColor: Colors.white,
        fixedSize: const Size(10.0, 60.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        onTap();
      },
      child: Text(
        btnTxt,
        style: TextStyle(
          fontSize: txtSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
