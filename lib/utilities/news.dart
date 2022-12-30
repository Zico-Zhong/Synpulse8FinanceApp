class News {
  String profileAvatarPath;
  String title;
  String publisherName;
  DateTime publishTime;

  News(
      {required this.title,
      required this.profileAvatarPath,
      required this.publisherName,
      required this.publishTime});
}
