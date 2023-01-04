import 'package:financer/components/search_bar.dart';
import 'package:flutter/material.dart';
import '../components/buttons/corner_button.dart';
import '../components/stats_item_bar.dart';
import '../utilities/constants.dart';
import '../utilities/instrument_overview.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({Key? key}) : super(key: key);

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  bool _searchBarVisible = false;
  List<Instrument> instruments = [];
  List<Widget> instrumentBars = [];
  String userInput = '';
  final searchBarController = TextEditingController();
  bool refresh = true;

  List<Widget> getPortfolio() {
    instrumentBars = [];
    int i = 0;
    for (Instrument instrument in instruments) {
      if (instrument.name.contains(userInput)) {
        instrumentBars.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: StatsItemBar(
            id: i++,
            logoPath: instrument.logoPath,
            name: instrument.name,
            code: instrument.code,
            followed: instrument.followed,
            gain: instrument.gain,
            percentage: instrument.percentage,
            price: instrument.price,
            valuesData: instrument.valuesData,
            removeThis: removeBar,
          ),
        ));
      }
    }
    return instrumentBars;
  }

  void removeBar(int index) {
    setState(() {
      instruments.removeAt(index);
      refresh = refresh ? false : true;
    });
  }

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
  void dispose() {
    searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 130.0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Portfolio',
                      style: kTopTitleStyle,
                    ),
                    CornerButton(
                        icon: const Icon(
                          Icons.search,
                          color: Color(0xFF09173D),
                          size: 26.0,
                        ),
                        onTapFunc: () {
                          setState(() {
                            _searchBarVisible =
                                _searchBarVisible ? false : true;
                          });
                        }),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                    visible: _searchBarVisible,
                    child: SearchBar(
                      searchBarController,
                      (value) {
                        setState(() {
                          if (searchBarController.text == value) {
                            userInput = value;
                          }
                        });
                      },
                      hintTxt:
                          'Search for any instrument in your watchlist with its name',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: refresh ? getPortfolio() : getPortfolio(),
            ),
          ),
        )
      ],
    ));
  }
}
