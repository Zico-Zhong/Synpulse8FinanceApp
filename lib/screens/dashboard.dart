import 'package:financer/components/buttons/corner_button.dart';
import 'package:financer/screens/gainers_losers_all.dart';
import 'package:financer/screens/main_page.dart';
import 'package:financer/screens/welcome_screen.dart';
import 'package:financer/utilities/instrument_overview.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../components/cards/stats_item_card.dart';
import '../components/stats_item_bar.dart';
import '../components/buttons/see_all_btn.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Instrument> instrumentsGL = [];
  List<Widget> instrumentCards = [];
  List<Widget> instrumentBars = [];
  bool refresh = true;

  List<Widget> getGL() {
    for (Instrument instrument in instrumentsGL) {
      if (instrumentCards.length < 7) {
        instrumentCards.add(Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: StatsItemCard(
            logoPath: instrument.logoPath,
            name: instrument.name,
            currPrice: instrument.price,
            gain: instrument.gain,
            percentage: instrument.percentage,
            offsetPrice: instrument.offsetPrice,
          ),
        ));
      }
    }
    return instrumentCards;
  }

  List<Widget> getWatchlist() {
    instrumentBars = [];
    for (int i = instrumentsGL.length - 1; i > 0; i--) {
      instrumentBars.add(Flexible(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StatsItemBar(
            id: instrumentsGL.length - i - 1,
            logoPath: instrumentsGL[i].logoPath,
            name: instrumentsGL[i].name,
            code: instrumentsGL[i].code,
            followed: instrumentsGL[i].followed,
            gain: instrumentsGL[i].gain,
            percentage: instrumentsGL[i].percentage,
            price: instrumentsGL[i].price,
            valuesData: instrumentsGL[i].valuesData,
            removeThis: removeBar,
          ),
        ),
      ));
    }
    return instrumentBars;
  }

  void removeBar(int index) {
    setState(() {
      instrumentsGL.removeAt(index);
      refresh = refresh ? false : true;
    });
  }

  @override
  void initState() {
    super.initState();
    instrumentsGL.add(Instrument('images/financer_logo.png', 'Financer', 'FNR',
        followed: true,
        price: 855.90,
        gain: true,
        percentage: 15.04,
        offsetPrice: 20.18,
        valuesData: [17.1, 12.8, 34.2, 31.3, 33.6, 11.7, 29.8]));
    instrumentsGL.add(Instrument('images/financer_logo.png', 'Financer', 'FNR',
        followed: true,
        price: 153.50,
        gain: false,
        percentage: 42.11,
        offsetPrice: 38.91,
        valuesData: [23.2, 20.8, 9.2, 23.8, 19.6, 26.7, 16.8]));
    instrumentsGL.add(Instrument('images/financer_logo.png', 'Financer', 'FNR',
        followed: true,
        price: 7.09,
        percentage: 0.86,
        offsetPrice: 0.07,
        valuesData: [17.1, 12.8, 34.2, 31.3, 33.6, 11.7, 29.8]));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
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
                    'Dashboard',
                    style: kTopTitleStyle,
                  ),
                  CornerButton(
                      icon: const Icon(
                        Icons.search,
                        color: Color(0xFF09173D),
                        size: 26.0,
                      ),
                      onTapFunc: () {
                        Navigator.pushNamed(context, Welcome.route);
                      }),
                ],
              ),
            ),
          ),
          Container(
            height: 220,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFFEBF3F8),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0, left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Gainers and Losers', style: kItemTitleStyle),
                      SeeAllButton(
                        onTap: () {
                          Navigator.pushNamed(context, GainersLosers.route);
                        },
                      )
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: getGL(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFEBF3F8),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0, left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Your watchlist', style: kItemTitleStyle),
                        SeeAllButton(onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MainPage(defaultIndex: 1)));
                        })
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: refresh ? getWatchlist() : getWatchlist(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
