import 'package:flutter/material.dart';

class FinancerLogoImage extends StatelessWidget {
  const FinancerLogoImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      foregroundDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        image: DecorationImage(
          image: AssetImage('images/financer_logo.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: const Text(
        'something here to show the logo in a specific length...',
        style: TextStyle(color: Color(0xFFEBF3F8)),
      ),
    );
  }
}
