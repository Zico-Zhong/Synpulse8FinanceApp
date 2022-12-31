import 'package:financer/components/rounded_logo_image.dart';
import 'package:flutter/material.dart';
import 'package:financer/utilities/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsItemBar extends StatelessWidget {
  final String logoPath;
  final String title;
  final String publisher;
  final String timeInterval;
  final String url;

  const NewsItemBar(
      {required this.logoPath,
      required this.title,
      required this.publisher,
      required this.timeInterval,
      required this.url,
      super.key});

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchUrl,
      child: Container(
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
      ),
    );
  }
}
