import 'package:financer/components/buttons/corner_button.dart';
import 'package:financer/components/percentage_box.dart';
import 'package:financer/components/buttons/rectangle_button.dart';
import 'package:financer/components/rounded_logo_image.dart';
import 'package:financer/components/buttons/see_all_btn.dart';
import 'package:financer/screens/news_page.dart';
import 'package:financer/utilities/constants.dart';
import 'package:financer/utilities/instrument_overview.dart';
import 'package:flutter/material.dart';
import '../components/buttons/follow_rectangle_button.dart';
import '../components/news_item_bar.dart';
import '../components/slide_selector.dart';
import '../services/data_retriever.dart';
import '../utilities/news.dart';
import '../utilities/path_painter.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ItemDetailsPage extends StatefulWidget {
  final String code;
  final String name;
  final double price; // should not be fetched here but just for demo now

  const ItemDetailsPage({
    super.key,
    required this.code,
    required this.name,
    this.price = 0.0,
  });

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  late Instrument instrument;
  late List<double> valuesData1D;
  List<double> valuesData5Ds = [];
  List<double> valuesData30Ds = [];
  List<double> valuesData90Ds = [];
  List<double> valuesData6Ms = [];
  List<double> valuesData1Y = [];
  late List<double> valuesDataAll;
  List<double> drawingDataList = [];
  double currDataMaxValue = 0.0;
  double currDataMinValue = 0.0;
  List<News> newsList = [];
  final double curveWidth = 320.0;
  final double curveHeight = 160.0;
  late bool followed;
  late double price;

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Instrument Info Sharing',
        text:
            "${instrument.name} : ${instrument.code} : current price: \$${instrument.price}",
        // linkUrl: 'com.synpulse8.zz.front_end_challenge',
        chooserTitle: 'Choose an external tool to share the info.');
  }

  List<double> dataNormalization(List<double> data) {
    List<double> normalizedDataList = [];
    final double maxValue =
        data.reduce((value, element) => value > element ? value : element);
    currDataMaxValue = maxValue;
    currDataMinValue =
        data.reduce((value, element) => value < element ? value : element);
    for (double value in data) {
      normalizedDataList.add(maxValue == 0 ? 0 : value / maxValue);
    }
    return normalizedDataList;
  }

  Path drawPath(List<double> normalizedDataList) {
    final segmentWidth = curveWidth / (normalizedDataList.length - 1);
    final path = Path();
    path.moveTo(0, curveHeight - normalizedDataList[0] * curveHeight);
    for (int i = 1; i < normalizedDataList.length; ++i) {
      final x = i * segmentWidth;
      final y = curveHeight - (normalizedDataList[i] * curveHeight);
      path.lineTo(x, y);
    }
    return path;
  }

  // With bubble sort
  void sortNewsList() {
    for (int i = 0; i < newsList.length - 1; i++) {
      for (int j = 0; j < newsList.length - i - 1; j++) {
        News temp = newsList[0];
        if (newsList[j].publishTime.isBefore(newsList[j + 1].publishTime)) {
          temp = newsList[j];
          newsList[j] = newsList[j + 1];
          newsList[j + 1] = temp;
        }
      }
    }
  }

  String timeShowingFormatting(DateTime pubTime) {
    String ret = '';
    DateTime currTime = DateTime.now();
    var duration = currTime.difference(pubTime);
    if (duration.inSeconds < 60) {
      ret = '${duration.inSeconds}s ago';
    } else if (duration.inMinutes < 60) {
      ret = '${duration.inMinutes}mins ago';
    } else if (duration.inHours < 24) {
      ret = '${duration.inHours}h ago';
    } else if (duration.inDays < 30) {
      ret = '${duration.inDays}d ago';
    }
    return ret;
  }

  List<Widget> getLabels() {
    List<Widget> labels = [];
    List<int> currLabels = [];
    double currDataMinMaxOffset = currDataMaxValue - currDataMinValue;
    double gap = currDataMinMaxOffset / 4;
    double max = currDataMaxValue;
    for (int i = 0; i < 4; ++i) {
      currLabels.add(max.ceilToDouble().toInt());
      max -= gap;
    }
    for (int singleLabel in currLabels) {
      labels.add(Text(
        '\$$singleLabel',
        style: kInfoItemOffsetStyle,
      ));
    }
    return labels;
  }

  void fetchNews() async {
    DataRetriever retriever = DataRetriever(
        url:
            'https://www.alphavantage.co/query?function=NEWS_SENTIMENT&tickers=${widget.code}&apikey=PRBX043CES5E7HW0');
    var receivedData = await retriever.getData();

    if (int.parse(receivedData['items']) > 2) {
      for (int i = 0; i < 2; i++) {
        setState(() {
          newsList = [
            ...newsList,
            News(
                title: receivedData['feed'][i]['title'],
                profileAvatarPath: receivedData['feed'][i]['banner_image'],
                publisherName: receivedData['feed'][i]['source'],
                publishTime:
                    DateTime.parse(receivedData['feed'][i]['time_published']),
                url: receivedData['feed'][i]['url'])
          ];
        });
      }
    }
    sortNewsList();
  }

  @override
  void initState() {
    super.initState();
    final obj = Instrument('images/financer_logo.png', 'Financer', 'FNR',
        followed: true,
        price: 855.90,
        gain: true,
        percentage: 15.04,
        offsetPrice: 20.18,
        valuesData: [17.1, 12.8, 34.2, 31.3, 33.6, 11.7, 29.8]);
    instrument = obj;
    valuesData1D = [];
    for (int i = 0; i < 3; ++i) {
      for (double value in instrument.valuesData) {
        valuesData1D.add(value);
      }
    }
    followed = instrument.followed;
    drawingDataList = valuesData1D;
    currDataMaxValue = drawingDataList
        .reduce((value, element) => value > element ? value : element);
    valuesDataAll = instrument.valuesData;
    price = widget.price;

    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF3F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CornerButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Color(0xFF09173D),
                              size: 28.0,
                            ),
                            onTapFunc: () {
                              Navigator.pop(context);
                            }),
                        Row(
                          children: [
                            CornerButton(
                                icon: followed
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
                                    followed = followed ? false : true;
                                  });
                                }),
                            CornerButton(
                                icon: const Icon(
                                  Icons.file_upload_outlined,
                                  color: Color(0xFF09173D),
                                  size: 28.0,
                                ),
                                onTapFunc: () {
                                  share();
                                })
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                      child: Text(
                        widget.code,
                        style: kCodeTxtStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 16.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.name,
                              style: kTopTitleStyle,
                            ),
                          ),
                          RoundedLogoImage(
                            logoPath: instrument.logoPath,
                            network: false,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
                      child: Row(
                        children: [
                          Text(
                            '\$$price',
                            style: kInfoItemNumStyle.copyWith(fontSize: 22.0),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: PercentageBox(
                                gain: instrument.gain,
                                percentage: instrument.percentage),
                          ),
                          instrument.gain
                              ? Text(
                                  '+\$${instrument.offsetPrice}',
                                  style: kInfoItemOffsetStyle,
                                )
                              : Text(
                                  '- \$${instrument.offsetPrice}',
                                  style: kInfoItemOffsetStyle,
                                )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SlideSelector(
                        items: [
                          SlideSelectorItem(
                            text: '1d',
                            onTap: () {
                              setState(() {
                                drawingDataList = valuesData1D;
                              });
                            },
                          ),
                          SlideSelectorItem(
                            text: '5d',
                            onTap: () {},
                          ),
                          SlideSelectorItem(
                            text: '30d',
                            onTap: () {},
                          ),
                          SlideSelectorItem(
                            text: '90d',
                            onTap: () {},
                          ),
                          SlideSelectorItem(
                            text: '6m',
                            onTap: () {},
                          ),
                          SlideSelectorItem(
                            text: '1y',
                            onTap: () {},
                          ),
                          SlideSelectorItem(
                            text: 'All',
                            onTap: () {
                              setState(() {
                                drawingDataList = valuesDataAll;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: curveHeight,
                              width: 42.0,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: getLabels(),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          left: 50.0,
                          top: 20.0,
                          child: CustomPaint(
                            size: Size(curveWidth, curveHeight),
                            painter: PathPainter(
                                path: drawPath(
                                    dataNormalization(drawingDataList)),
                                color: instrument.gain
                                    ? const Color(0xFF2DBB80)
                                    : const Color(0xFFD24360)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  // unexpected bug here, if use both FollowRectangleButton, won't refresh and render with new button
                  child: followed
                      ? FollowRectangleButton(
                          onTap: () {
                            if (followed) {
                              setState(() {
                                followed = false;
                              });
                            } else {
                              setState(() {
                                followed = true;
                              });
                            }
                          },
                          followed: followed,
                          size: const Size(10.0, 60.0),
                          unfollowBackgroundColor: Colors.blue,
                          followedBackgroundColor: const Color(0xFF09173D),
                          followedTextColor: Colors.white,
                          fontSize: 26.0,
                        )
                      : RectangleButton(
                          btnTxt: 'Follow',
                          onTap: () {
                            setState(() {
                              if (followed) {
                                followed = false;
                              } else {
                                followed = true;
                              }
                            });
                          },
                          txtSize: 26.0,
                          fontWeight: FontWeight.w700,
                        )),
              Expanded(
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'News',
                              style: kItemTitleStyle,
                            ),
                            SeeAllButton(onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllNewsPage(
                                          instrumentName: instrument.name,
                                          instrumentCode: instrument.code)));
                            })
                          ],
                        ),
                        SizedBox(
                            height: 102.0,
                            child: newsList.isNotEmpty
                                ? ListView.builder(
                                    itemCount: newsList.length,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: NewsItemBar(
                                          logoPath:
                                              newsList[index].profileAvatarPath,
                                          title: newsList[index].title,
                                          publisher:
                                              newsList[index].publisherName,
                                          timeInterval: timeShowingFormatting(
                                              newsList[index].publishTime),
                                          url: newsList[index].url,
                                        ),
                                      );
                                    })
                                : const SpinKitDualRing(
                                    color: Colors.lightGreenAccent,
                                    size: 50.0,
                                  ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
