import 'package:financer/screens/main_page.dart';
import 'package:financer/utilities/constants.dart';
import 'package:financer/utilities/instrument_overview.dart';
import 'package:flutter/material.dart';
import '../components/search_bar.dart';
import '../components/buttons/rectangle_button.dart';
import '../components/cards/follow_item_card.dart';
import '../components/buttons/corner_button.dart';

class Welcome extends StatefulWidget {
  static String route = '/welcome';
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List<Instrument> instruments = [];
  List<Widget> instrumentCards = [];
  final searchBarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 5; ++i) {
      instruments.add(Instrument('images/financer_logo.png', 'Financer', 'FNR',
          followed: false));
    }
  }

  @override
  void dispose() {
    searchBarController.dispose();
    super.dispose();
  }

  List<Widget> getInstrumentsCards() {
    int numOfInstruments = instruments.length;
    if (numOfInstruments % 2 == 0) {
      for (int i = 0; i < numOfInstruments; i += 2) {
        instrumentCards.add(Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FollowItemCard(
                name: instruments[i].name,
                code: instruments[i].code,
                logoPath: instruments[i].logoPath,
                followed: instruments[i].followed,
              ),
              FollowItemCard(
                name: instruments[i + 1].name,
                code: instruments[i + 1].code,
                logoPath: instruments[i + 1].logoPath,
                followed: instruments[i + 1].followed,
              ),
            ],
          ),
        ));
      }
    } else {
      for (int i = 0; i < numOfInstruments - 1; i += 2) {
        instrumentCards.add(Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FollowItemCard(
                name: instruments[i].name,
                code: instruments[i].code,
                logoPath: instruments[i].logoPath,
                followed: instruments[i].followed,
              ),
              FollowItemCard(
                name: instruments[i + 1].name,
                code: instruments[i + 1].code,
                logoPath: instruments[i + 1].logoPath,
                followed: instruments[i + 1].followed,
              ),
            ],
          ),
        ));
      }
      instrumentCards.add(Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FollowItemCard(
              name: instruments[numOfInstruments - 1].name,
              code: instruments[numOfInstruments - 1].code,
              logoPath: instruments[numOfInstruments - 1].logoPath,
              followed: instruments[numOfInstruments - 1].followed,
            ),
            Container(
              width: 175,
              height: 175,
              color: const Color(0xFFEBF3F8),
            ),
          ],
        ),
      ));
    }
    return instrumentCards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF3F8),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 175.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 2.0),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Welcome!',
                                  style: kTopTitleStyle,
                                ),
                                CornerButton(
                                  icon: const Icon(
                                    Icons.close,
                                    color: Color(0xFF09173D),
                                    size: 26.0,
                                  ),
                                  onTapFunc: () {
                                    Navigator.pushNamed(
                                        context, MainPage.route);
                                  },
                                )
                              ],
                            ),
                            const SizedBox(height: 6.0),
                            const SizedBox(
                              width: 300.0,
                              child: Text(
                                'Choose your interest to follow and trade on your terms.',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, right: 8.0),
                              child: SearchBar(searchBarController, (value) {},
                                  hintTxt: 'Search interests to follow.'),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: getInstrumentsCards(),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    top: 520,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: RectangleButton(
                        btnTxt: 'Add to watchlist',
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Row(
                                    children: const [
                                      Icon(
                                        Icons.info,
                                        color: Color(0xFF09173D),
                                      ),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      Text(
                                        'Reminder',
                                        style: kInfoItemTitleStyle,
                                      )
                                    ],
                                  ),
                                  content: Row(
                                    children: const [
                                      Icon(Icons.save),
                                      SizedBox(width: 12.0),
                                      Expanded(
                                        child: Text(
                                            'The instruments you selected have been added to your watchlist.'),
                                      )
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(
                                              context, MainPage.route);
                                        },
                                        child: const Text('Close')),
                                  ],
                                );
                              });
                        },
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
