import 'dart:io';

import 'package:algolia/algolia.dart';
import 'package:financer/screens/main_page.dart';
import 'package:financer/services/algolia_application.dart';
import 'package:financer/services/data_retriever.dart';
import 'package:financer/utilities/constants.dart';
import 'package:financer/utilities/instrument_overview.dart';
import 'package:flutter/material.dart';
import '../components/search_bar.dart';
import '../components/buttons/rectangle_button.dart';
import '../components/cards/follow_item_card.dart';
import '../components/buttons/corner_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Welcome extends StatefulWidget {
  static String route = '/welcome';
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List<Instrument> instruments = [];
  List<Widget> instrumentCards = [];
  Map<String, String> instrumentsLogoPath = {
    'IBM':
        'https://th.bing.com/th/id/R.81291be958924bf66c64a1a16171302d?rik=enr1crFGlhP%2f5Q&riu=http%3a%2f%2f1000logos.net%2fwp-content%2fuploads%2f2017%2f02%2fColor-IBM-Logo.jpg&ehk=3lMuaJI%2bEiYjzvaK6prs4mryZgluY0pQG5WhtYQVWKU%3d&risl=&pid=ImgRaw&r=0',
    'AAPL':
        'https://th.bing.com/th/id/R.a691dfa22635c11791f78e215d69bbc3?rik=Ms2XMlun2W9tTw&riu=http%3a%2f%2fincitrio.com%2fwp-content%2fuploads%2f2015%2f01%2fApple_gray_logo.png&ehk=7LassJNwds3BTEqitrfk8bUlGqmX01%2b5UMUCH1ixbBk%3d&risl=&pid=ImgRaw&r=0',
    'GOOG':
        'https://th.bing.com/th/id/OIP.FtqqM5mWlVO54JPjFlS1GwHaFj?pid=ImgDet&rs=1',
    'MSFT':
        'https://th.bing.com/th/id/OIP.PWoq1WvDQDxc_MPv4Jt0GwHaHa?pid=ImgDet&rs=1',
    'AMZN':
        'https://tse3-mm.cn.bing.net/th/id/OIP-C.Kq00N0XXUmDFNiXoeGG4FAHaE8?w=267&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7'
  };
  final searchBarController = TextEditingController();

  void fetchAndSaveInstrumentData() async {
    DataRetriever retriever = DataRetriever(url: '');
    var algolia = AlgoliaApplication.algolia;

    var batch = algolia.instance.index('dev_FINANCER_INSTRUMENT').batch();
    batch.clearIndex();
    List<String> stockCompanies = ['IBM', 'AAPL', 'GOOG', 'MSFT', 'AMZN'];

    for (String stock in stockCompanies) {
      retriever.serUrl(
          'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=$stock&interval=60min&apikey=PRBX043CES5E7HW0');
      var receivedPriceData = await retriever.getData();
      retriever.serUrl(
          'https://www.alphavantage.co/query?function=OVERVIEW&symbol=$stock&apikey=PRBX043CES5E7HW0');
      var receivedOverviewData = await retriever.getData();

      var addData = <String, dynamic>{
        'code': receivedPriceData['Meta Data']['2. Symbol'],
        'name': receivedOverviewData['Name'],
        'price': receivedPriceData['Time Series (60min)']['2023-01-03 20:00:00']
            ['4. close']
      };
      batch.addObject(addData);
      print('waiting for 30 seconds...');
      sleep(const Duration(seconds: 30));
    }

    await batch.commit();
    print('done');
  }

  Future<List<Map<String, dynamic>>> fetchInstrumentData() async {
    List<Map<String, dynamic>> dataList = [];
    DataRetriever retriever = DataRetriever(
        url:
            'https://www.alphavantage.co/query?function=OVERVIEW&symbol=IBM&apikey=PRBX043CES5E7HW0');
    var receivedDataIBM = await retriever.getData();
    var addDataIBM = <String, dynamic>{
      'symbol': receivedDataIBM['Symbol'],
      'name': receivedDataIBM['Name']
    };
    retriever.serUrl(
        'https://www.alphavantage.co/query?function=OVERVIEW&symbol=AAPL&apikey=PRBX043CES5E7HW0');
    var receivedDataAPPL = await retriever.getData();
    var addDataAPPL = <String, dynamic>{
      'symbol': receivedDataAPPL['Symbol'],
      'name': receivedDataAPPL['Name']
    };
    retriever.serUrl(
        'https://www.alphavantage.co/query?function=OVERVIEW&symbol=GOOG&apikey=PRBX043CES5E7HW0');
    var receivedDataGOOG = await retriever.getData();
    var addDataGOOG = <String, dynamic>{
      'symbol': receivedDataGOOG['Symbol'],
      'name': receivedDataGOOG['Name']
    };
    retriever.serUrl(
        'https://www.alphavantage.co/query?function=OVERVIEW&symbol=MSFT&apikey=PRBX043CES5E7HW0');
    var receivedDataMSFT = await retriever.getData();
    var addDataMSFT = <String, dynamic>{
      'symbol': receivedDataMSFT['Symbol'],
      'name': receivedDataMSFT['Name']
    };
    retriever.serUrl(
        'https://www.alphavantage.co/query?function=OVERVIEW&symbol=AMZN&apikey=PRBX043CES5E7HW0');
    var receivedDataAMZN = await retriever.getData();
    var addDataAMZN = <String, dynamic>{
      'symbol': receivedDataAMZN['Symbol'],
      'name': receivedDataAMZN['Name']
    };
    dataList.add(addDataIBM);
    dataList.add(addDataAPPL);
    dataList.add(addDataGOOG);
    dataList.add(addDataMSFT);
    dataList.add(addDataAMZN);

    List<String> logoPaths = [
      'https://th.bing.com/th/id/R.81291be958924bf66c64a1a16171302d?rik=enr1crFGlhP%2f5Q&riu=http%3a%2f%2f1000logos.net%2fwp-content%2fuploads%2f2017%2f02%2fColor-IBM-Logo.jpg&ehk=3lMuaJI%2bEiYjzvaK6prs4mryZgluY0pQG5WhtYQVWKU%3d&risl=&pid=ImgRaw&r=0',
      'https://th.bing.com/th/id/R.a691dfa22635c11791f78e215d69bbc3?rik=Ms2XMlun2W9tTw&riu=http%3a%2f%2fincitrio.com%2fwp-content%2fuploads%2f2015%2f01%2fApple_gray_logo.png&ehk=7LassJNwds3BTEqitrfk8bUlGqmX01%2b5UMUCH1ixbBk%3d&risl=&pid=ImgRaw&r=0',
      'https://th.bing.com/th/id/OIP.FtqqM5mWlVO54JPjFlS1GwHaFj?pid=ImgDet&rs=1',
      'https://th.bing.com/th/id/OIP.PWoq1WvDQDxc_MPv4Jt0GwHaHa?pid=ImgDet&rs=1',
      'https://tse3-mm.cn.bing.net/th/id/OIP-C.Kq00N0XXUmDFNiXoeGG4FAHaE8?w=267&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7'
    ];

    setState(() {
      for (int i = 0; i < dataList.length; i++) {
        instruments = [
          ...instruments,
          Instrument(logoPaths[i], dataList[i]['name'], dataList[i]['symbol'],
              followed: false),
        ];
      }
    });

    return dataList;
  }

  @override
  void initState() {
    super.initState();
    // fetchAndSaveInstrumentData();
    fetchInstrumentData();
    searchBarController.addListener(() async {
      var algolia = AlgoliaApplication.algolia;
      var query = algolia.instance
          .index('dev_FINANCER_INSTRUMENT')
          .query(searchBarController.text);
      setState(() {
        instruments = [];
      });
      var snap = await query.getObjects();
      List<Map<String, dynamic>> searchResults = [];
      for (int i = 0; i < snap.hits.length; i++) {
        var searchResult = snap.hits.elementAt(i).data;
        searchResults.add(searchResult);
      }
      List<Instrument> toShowInstruments = [];
      for (Map<String, dynamic> result in searchResults) {
        toShowInstruments.add(Instrument(instrumentsLogoPath[result['code']]!,
            result['name'], result['code'],
            price: double.parse(result['price']), followed: false));
      }
      setState(() {
        instruments = toShowInstruments;
      });
    });
  }

  @override
  void dispose() {
    searchBarController.dispose();
    super.dispose();
  }

  List<Widget> getInstrumentsCards() {
    int numOfInstruments = instruments.length;
    instrumentCards = [];
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
                local: false,
                logoPath: instruments[i].logoPath,
                followed: instruments[i].followed,
                price: instruments[i].price,
              ),
              FollowItemCard(
                name: instruments[i + 1].name,
                code: instruments[i + 1].code,
                local: false,
                logoPath: instruments[i + 1].logoPath,
                followed: instruments[i + 1].followed,
                price: instruments[i + 1].price,
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
                local: false,
                logoPath: instruments[i].logoPath,
                followed: instruments[i].followed,
                price: instruments[i].price,
              ),
              FollowItemCard(
                name: instruments[i + 1].name,
                code: instruments[i + 1].code,
                local: false,
                logoPath: instruments[i + 1].logoPath,
                followed: instruments[i + 1].followed,
                price: instruments[i + 1].price,
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
              name: instruments[instruments.length - 1].name,
              code: instruments[instruments.length - 1].code,
              local: false,
              logoPath: instruments[instruments.length - 1].logoPath,
              followed: instruments[instruments.length - 1].followed,
              price: instruments[instruments.length - 1].price,
            ),
            Container(
              width: 175,
              height: 175,
              color: const Color(0xFFEBF3F8),
            )
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
                          children: instruments.isNotEmpty
                              ? getInstrumentsCards()
                              : [
                                  const SpinKitDualRing(
                                    color: Colors.lightGreenAccent,
                                    size: 50.0,
                                  )
                                ],
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
