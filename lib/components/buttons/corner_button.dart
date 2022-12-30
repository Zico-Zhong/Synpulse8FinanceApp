import 'package:flutter/material.dart';

class CornerButton extends StatelessWidget {
  final Icon icon;
  final Function onTapFunc;
  const CornerButton({Key? key, required this.icon, required this.onTapFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onTapFunc();
      },
      padding: const EdgeInsets.all(0.0),
      minWidth: 0.0,
      height: 10.0,
      child: icon,
    );
  }
}
