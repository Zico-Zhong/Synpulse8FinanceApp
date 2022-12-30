import 'package:flutter/material.dart';
import 'package:financer/utilities/constants.dart';

import '../components/buttons/corner_button.dart';
import '../components/rounded_logo_image.dart';
import '../utilities/news.dart';

class AllNewsPage extends StatefulWidget {
  final String instrumentName;
  final String instrumentCode;
  const AllNewsPage(
      {Key? key, required this.instrumentName, required this.instrumentCode})
      : super(key: key);

  @override
  State<AllNewsPage> createState() => _AllNewsPageState();
}

class _AllNewsPageState extends State<AllNewsPage> {
  late String name;
  late String code;
  List<News> newsList = [];

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

  @override
  void initState() {
    super.initState();
    name = widget.instrumentName;
    code = widget.instrumentCode;
    for (int i = 0; i < 8; ++i) {
      newsList.add(News(
          title: 'Here is the news ${i + 1} about the instrument Financer',
          profileAvatarPath: 'images/financer_logo.png',
          publisherName: 'Financer Developer',
          publishTime: DateTime.now().subtract(Duration(hours: i))));
    }
    sortNewsList();
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
                    'News',
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
            child: NewsList(
              newsList: newsList,
            ),
          )
        ],
      )),
    );
  }
}

class NewsList extends StatelessWidget {
  final List<News> newsList;
  const NewsList({Key? key, required this.newsList}) : super(key: key);

  String timeShowingFormatting(DateTime pubTime) {
    String ret = '';
    DateTime currTime = DateTime.now();
    var duration = currTime.difference(pubTime);
    if (duration.inSeconds < 60) {
      ret = '${duration.inSeconds + 29}s ago';
    } else if (duration.inMinutes < 60) {
      ret = '${duration.inMinutes}min(s) ago';
    } else if (duration.inHours < 24) {
      ret = '${duration.inHours}h ago';
    } else if (duration.inDays < 30) {
      ret = '${duration.inSeconds}d ago';
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: NewsItemBar1(
                data: NewsItemBarData(
                    logoPath: newsList[index].profileAvatarPath,
                    title: newsList[index].title,
                    publisher: newsList[index].publisherName,
                    timeInterval:
                        timeShowingFormatting(newsList[index].publishTime))),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: .5,
            indent: 75,
            color: Color(0xFFDDDDDD),
          );
        },
        itemCount: newsList.length);
  }
}

class NewsItemBar1 extends StatelessWidget {
  final NewsItemBarData data;

  const NewsItemBar1({required this.data, super.key});

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
              child: RoundedLogoImage(logoPath: data.logoPath),
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
                      data.title,
                      style: kItemTitleStyle.copyWith(fontSize: 14.0),
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Text(
                    '${data.publisher} · ${data.timeInterval}',
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

class NewsItemBarData {
  String logoPath;
  String title;
  String publisher;
  String timeInterval;

  NewsItemBarData(
      {this.logoPath = '',
      this.title = '',
      this.publisher = '',
      this.timeInterval = ''});
}
