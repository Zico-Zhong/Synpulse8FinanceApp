import 'package:flutter/material.dart';

class SeeAllButton extends StatelessWidget {
  final Function onTap;
  const SeeAllButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onTap();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'See all',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 6.0,
          ),
          Icon(
            Icons.arrow_forward_sharp,
            color: Colors.blue,
            size: 16.0,
          )
        ],
      ),
    );
  }
}
