import 'news.dart';

class Instrument {
  String logoPath;
  String name;
  String code;
  bool followed;
  double price;
  bool gain;
  double percentage;
  double offsetPrice;
  List<double> valuesData = [];
  List<News> newsList = [];

  Instrument(this.logoPath, this.name, this.code,
      {this.followed = false,
      this.price = 0.0,
      this.gain = true,
      this.percentage = 0.0,
      this.offsetPrice = 0.0,
      this.valuesData = const [],
      this.newsList = const []});
}
