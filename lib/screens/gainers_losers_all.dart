import 'package:financer/components/cards/stats_item_card.dart';
import 'package:flutter/material.dart';
import '../components/buttons/corner_button.dart';
import '../utilities/constants.dart';
import '../utilities/instrument_overview.dart';

class GainersLosers extends StatefulWidget {
  static String route = '/home/dashboard/gl';
  const GainersLosers({Key? key}) : super(key: key);

  @override
  State<GainersLosers> createState() => _GainersLosersState();
}

class _GainersLosersState extends State<GainersLosers> {
  List<Instrument> instruments = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 3; ++i) {
      instruments.add(Instrument(
          'images/financer_logo.png', 'Financer$i', 'FNR',
          followed: true,
          price: 855.90,
          gain: true,
          percentage: 15.04,
          offsetPrice: 20.18,
          valuesData: [17.1, 12.8, 34.2, 31.3, 33.6, 11.7, 29.8]));
      instruments.add(Instrument(
          'images/financer_logo.png', 'Financer$i', 'FNR',
          followed: true,
          price: 153.50,
          gain: false,
          percentage: 42.11,
          offsetPrice: 38.91,
          valuesData: [23.2, 20.8, 9.2, 23.8, 19.6, 26.7, 16.8]));
      instruments.add(Instrument(
          'images/financer_logo.png', 'Financer$i', 'FNR',
          followed: true,
          price: 7.09,
          percentage: 0.86,
          offsetPrice: 0.07,
          valuesData: [17.1, 12.8, 34.2, 31.3, 33.6, 11.7, 29.8]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF3F8),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 130.0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gainers & Losers',
                    style: kTopTitleStyle,
                  ),
                  CornerButton(
                      icon: const Icon(
                        Icons.close,
                        color: Color(0xFF09173D),
                        size: 26.0,
                      ),
                      onTapFunc: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            height: 513.4,
            child: GridView.builder(
              itemCount: instruments.length,
              padding: EdgeInsets.zero,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: StatsItemCard(
                    logoPath: instruments[index].logoPath,
                    name: instruments[index].name,
                    currPrice: instruments[index].price,
                    gain: instruments[index].gain,
                    percentage: instruments[index].percentage,
                    offsetPrice: instruments[index].offsetPrice,
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 6.0),
            ),
          )
        ],
      )),
    );
  }
}
