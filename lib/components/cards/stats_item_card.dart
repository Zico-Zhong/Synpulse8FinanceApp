import 'package:flutter/material.dart';
import '../../utilities/constants.dart';
import '../rounded_logo_image.dart';
import '../percentage_box.dart';

class StatsItemCard extends StatelessWidget {
  final String logoPath;
  final String name;
  final double currPrice;
  final double percentage;
  final double offsetPrice;
  final bool gain;
  const StatsItemCard(
      {Key? key,
      required this.logoPath,
      required this.name,
      required this.currPrice,
      required this.gain,
      required this.percentage,
      required this.offsetPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      height: 150.0,
      decoration: kItemCardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: RoundedLogoImage(logoPath: logoPath),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                name,
                style: kInfoItemTitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                '\$$currPrice',
                style: kInfoItemNumStyle,
              ),
            ),
            Row(
              children: [
                PercentageBox(gain: gain, percentage: percentage),
                const SizedBox(
                  width: 4.0,
                ),
                gain
                    ? Text('+ \$$offsetPrice', style: kInfoItemOffsetStyle)
                    : Text('- \$$offsetPrice', style: kInfoItemOffsetStyle),
              ],
            )
          ],
        ),
      ),
    );
  }
}
