import 'package:flutter/material.dart';
import 'package:financer/utilities/constants.dart';

class MobileInputCard extends StatelessWidget {
  const MobileInputCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Text(
          'Enter Mobile Number',
          style: kLabelTxtStyle,
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 32.0,
            right: 32.0,
          ),
          child: TextField(
            keyboardType: TextInputType.phone,
            textAlign: TextAlign.center,
            style: kInputTxtStyle,
          ),
        )
      ],
    );
  }
}
