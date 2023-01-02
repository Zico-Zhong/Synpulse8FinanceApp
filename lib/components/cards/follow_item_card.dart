import 'package:financer/utilities/constants.dart';
import 'package:flutter/material.dart';
import '../../screens/item_details_page.dart';
import '../buttons/follow_rectangle_button.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FollowItemCard extends StatefulWidget {
  final String logoPath;
  final String name;
  final String code;
  final bool followed;
  final bool local;
  const FollowItemCard(
      {super.key,
      required this.name,
      required this.logoPath,
      required this.local,
      required this.followed,
      required this.code});

  @override
  State<FollowItemCard> createState() => _FollowItemCardState();
}

class _FollowItemCardState extends State<FollowItemCard> {
  late String logoPath;
  late String name;
  late bool followed;
  late bool local;

  @override
  void initState() {
    super.initState();
    logoPath = widget.logoPath;
    local = widget.local;
    name = widget.name;
    followed = widget.followed;
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
        width: 175.0,
        height: 175.0,
        decoration: kItemCardDecoration,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: const Color(0xFFF5F5F5), width: 1.0),
                  image: local
                      ? DecorationImage(
                          image: AssetImage(logoPath), fit: BoxFit.fill)
                      : DecorationImage(
                          image: NetworkImage(logoPath), fit: BoxFit.fill),
                ),
              ),
              const SizedBox(height: 12.0),
              AutoSizeText(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20.0,
                  color: Color(0xFF09173D),
                ),
              ),
              const SizedBox(height: 8.0),
              FollowRectangleButton(
                onTap: () {},
                followed: followed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
