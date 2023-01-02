import 'package:financer/components/buttons/corner_button.dart';
import 'package:financer/components/percentage_box.dart';
import 'package:financer/components/rounded_logo_image.dart';
import 'package:financer/screens/item_details_page.dart';
import 'package:financer/utilities/stats_item_bar_actions.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../utilities/path_painter.dart';

class StatsItemBar extends StatefulWidget {
  final int id;
  final bool followed;
  final String logoPath;
  final String name;
  final bool gain;
  final double percentage;
  final double price;
  final List<double> valuesData;
  final Function(int) removeThis;
  final String code;

  const StatsItemBar(
      {required this.id,
      required this.logoPath,
      required this.code,
      required this.name,
      required this.followed,
      required this.percentage,
      required this.price,
      required this.gain,
      required this.valuesData,
      required this.removeThis,
      super.key});
  // const StatsItemBar(
  //     this.logoPath, this.name, this.followed, this.percentage, this.price,
  //     {super.key});
  // :assert(removeThis != null), super(Key : key);

  // static dynamic _dummyFunc(int id) {}

  @override
  State<StatsItemBar> createState() => _StatsItemBarState();
}

class _StatsItemBarState extends State<StatsItemBar> {
  late bool followStatus;
  late String logoPath;
  late String name;
  late bool gain;
  late double percentage;
  late double price;
  late List<double> valuesData;
  final double curveWidth = 42.0;
  final double curveHeight = 20.0;

  List<double> dataNormalization(List<double> data) {
    List<double> normalizedDataList = [];
    final double maxValue =
        data.reduce((value, element) => value > element ? value : element);
    for (double value in data) {
      normalizedDataList.add(maxValue == 0 ? 0 : value / maxValue);
    }
    return normalizedDataList;
  }

  Path drawPath(List<double> normalizedData) {
    final segmentWidth = curveWidth / (normalizedData.length - 1);
    final path = Path();
    path.moveTo(0, curveHeight - normalizedData[0] * curveHeight);
    for (int i = 1; i < normalizedData.length; ++i) {
      final x = i * segmentWidth;
      final y = curveHeight - (normalizedData[i] * curveHeight);
      path.lineTo(x, y);
    }
    return path;
  }

  void takeAction(StatsItemBarAction action) {
    switch (action) {
      case StatsItemBarAction.details:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetailsPage(
                code: widget.code,
                name: name,
              ),
            ));
        break;

      case StatsItemBarAction.remove:
        widget.removeThis(widget.id);
        break;

      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    followStatus = widget.followed;
    logoPath = widget.logoPath;
    name = widget.name;
    gain = widget.gain;
    percentage = widget.percentage;
    price = widget.price;
    valuesData = widget.valuesData;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetailsPage(
                code: widget.code,
                name: name,
              ),
            ));
      },
      child: Container(
          width: 374.0,
          height: 66.0,
          decoration: kItemCardDecoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CornerButton(
                  icon: followStatus
                      ? const Icon(
                          Icons.star,
                          color: Color(0xFFFF7200),
                          size: 28.0,
                        )
                      : const Icon(
                          Icons.star_border,
                          color: Colors.yellow,
                          size: 28.0,
                        ),
                  onTapFunc: () {
                    setState(() {
                      followStatus = followStatus ? false : true;
                    });
                  }),
              RoundedLogoImage(
                logoPath: logoPath,
                network: false,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: kInfoItemTitleStyle,
                  ),
                  const SizedBox(height: 6.0),
                  PercentageBox(gain: gain, percentage: percentage)
                ],
              ),
              const SizedBox(width: 19.0), // 19; 32
              CustomPaint(
                size: Size(curveWidth, curveHeight),
                painter: PathPainter(
                    path: drawPath(dataNormalization(valuesData)),
                    color: gain
                        ? const Color(0xFF2DBB80)
                        : const Color(0xFFD24360)),
              ),
              const SizedBox(width: 19.0), // 19; 32
              Text('\$$price', style: kInfoItemNumStyle),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: StatsItemBarAction.details,
                    height: 32.0,
                    child: Row(
                      children: const [
                        Icon(Icons.info),
                        SizedBox(width: 6.0),
                        Text('Details')
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: StatsItemBarAction.remove,
                    height: 32.0,
                    child: Row(
                      children: const [
                        Icon(Icons.remove_circle),
                        SizedBox(width: 6.0),
                        Text('Remove')
                      ],
                    ),
                  )
                ],
                onSelected: (item) => takeAction(item),
              ),
            ],
          )),
    );
  }
}
