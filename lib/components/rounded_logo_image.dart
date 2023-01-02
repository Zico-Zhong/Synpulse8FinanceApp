import 'package:flutter/material.dart';

class RoundedLogoImage extends StatelessWidget {
  const RoundedLogoImage({
    Key? key,
    required this.logoPath,
    required this.network,
  }) : super(key: key);

  final String logoPath;
  final bool network;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFF5F5F5), width: 1.0),
        image: network
            ? DecorationImage(image: NetworkImage(logoPath), fit: BoxFit.fill)
            : DecorationImage(image: AssetImage(logoPath), fit: BoxFit.fill),
      ),
    );
  }
}
