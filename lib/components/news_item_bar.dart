import 'package:financer/components/rounded_logo_image.dart';
import 'package:flutter/material.dart';
import 'package:financer/utilities/constants.dart';

class NewsItemBar extends StatelessWidget {
  final String logoPath;
  final String title;
  final String publisher;
  final String timeInterval;

  const NewsItemBar(
      {required this.logoPath,
      required this.title,
      required this.publisher,
      required this.timeInterval,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 376.0,
      height: 66.0,
      decoration: kItemCardDecoration.copyWith(
          border: Border.all(color: const Color(0xFFD3D3D3))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: RoundedLogoImage(logoPath: logoPath),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: kItemTitleStyle.copyWith(fontSize: 14.0),
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Text(
                    '$publisher · $timeInterval',
                    style: kInfoItemOffsetStyle,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
