import 'package:flutter/material.dart';

const kLabelTxtStyle = TextStyle(
  color: Colors.grey,
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
);

const kInputTxtStyle = TextStyle(
  color: Colors.black,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);

const kTitleTxtStyle = TextStyle(
  color: Colors.white,
  fontSize: 42.0,
  fontWeight: FontWeight.bold,
);

const kLinkTxtStyle = TextStyle(
  color: Colors.black54,
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.underline,
);

const kInputBoxDecoration = InputDecoration(
  hintText: 'Enter your Email here...',
  labelText: 'Email',
  alignLabelWithHint: true,
  labelStyle: TextStyle(
    color: Colors.grey,
    fontSize: 18.0,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlue, width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
  ),
);

const kTopTitleStyle = TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 32.0,
  color: Color(0xFF09173D),
);

const kItemTitleStyle = TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 20.0,
  color: Color(0xFF09173D),
);

const kItemCardDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(
    Radius.circular(12.0),
  ),
);

const kInfoItemTitleStyle = TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 13.0,
  color: Color(0xFF09173D),
);

const kInfoItemNumStyle = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 14.0,
  color: Color(0xFF09173D),
);

const kInfoItemPrecStyle = TextStyle(
  color: Color(0xFF2DBB80),
  fontWeight: FontWeight.w900,
  fontSize: 13.0,
);

const kInfoItemOffsetStyle = TextStyle(
  color: Colors.grey,
  fontWeight: FontWeight.w900,
  fontSize: 12.0,
);

const kCodeTxtStyle = TextStyle(
  color: Colors.grey,
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
);
