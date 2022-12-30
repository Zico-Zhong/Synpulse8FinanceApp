import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key,
      required this.color,
      required this.btnTxt,
      required this.onTapFunc,
      this.txtSize = 22.0})
      : super(key: key);

  final Color color;
  final String btnTxt;
  final Function onTapFunc;
  final double txtSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            onTapFunc();
          },
          minWidth: 300.0,
          height: 42.0,
          child: Text(
            btnTxt,
            style: TextStyle(
              fontSize: txtSize,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
