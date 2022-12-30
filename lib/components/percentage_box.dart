import 'package:flutter/material.dart';
import '../utilities/constants.dart';

class PercentageBox extends StatelessWidget {
  const PercentageBox({
    Key? key,
    required this.gain,
    required this.percentage,
  }) : super(key: key);

  final bool gain;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: gain ? const Color(0xFFE1FBEB) : const Color(0xFFFFE8EE),
      width: 66.0,
      height: 15.0,
      child: Center(
        child: gain
            ? Text(
                '+ $percentage%',
                style: kInfoItemPrecStyle,
              )
            : Text(
                '- $percentage%',
                style:
                    kInfoItemPrecStyle.copyWith(color: const Color(0xFFD24360)),
              ),
      ),
    );
  }
}
