import 'package:flutter/material.dart';

class FollowRectangleButton extends StatefulWidget {
  final Function onTap;
  final bool followed;
  final Color followedBackgroundColor;
  final Color unfollowBackgroundColor;
  final Color borderColor;
  final double fontSize;
  final Color followedTextColor;
  final Color unfollowTextColor;
  final Size size;

  const FollowRectangleButton(
      {super.key,
      required this.onTap,
      required this.followed,
      this.followedBackgroundColor = Colors.white,
      this.unfollowBackgroundColor = const Color(0xFF09173D),
      this.borderColor = const Color(0xFFD3D3D3),
      this.fontSize = 11.0,
      this.followedTextColor = Colors.black,
      this.unfollowTextColor = Colors.white,
      this.size = const Size(150.0, 26.0)});

  @override
  State<FollowRectangleButton> createState() => _FollowRectangleButtonState();
}

class _FollowRectangleButtonState extends State<FollowRectangleButton> {
  late bool followed;
  late Function onTap;
  late Color followedBackgroundColor;
  late Color unfollowBackgroundColor;
  late Color borderColor;
  late double fontSize;
  late Color followedTextColor;
  late Color unfollowTextColor;
  late Size size;

  @override
  void initState() {
    super.initState();
    followed = widget.followed;
    onTap = widget.onTap;
    followedBackgroundColor = widget.followedBackgroundColor;
    unfollowBackgroundColor = widget.unfollowBackgroundColor;
    borderColor = widget.borderColor;
    fontSize = widget.fontSize;
    followedTextColor = widget.followedTextColor;
    unfollowTextColor = widget.unfollowTextColor;
    size = widget.size;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        setState(() {
          followed = followed ? false : true;
        });
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: followed
              ? MaterialStateProperty.all(followedBackgroundColor)
              : MaterialStateProperty.all(unfollowBackgroundColor),
          minimumSize: MaterialStateProperty.all(size),
          fixedSize: MaterialStateProperty.all(size),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          side: MaterialStateProperty.all(
            BorderSide(color: borderColor),
          )),
      child: followed
          ? Text(
              'Followed',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w800,
                color: followedTextColor,
              ),
            )
          : Text(
              'Follow',
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w800,
                color: unfollowTextColor,
              ),
            ),
    );
  }
}
