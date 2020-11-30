import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoodUi extends StatelessWidget {
  final int imageNumber;
  final String imageAsset;

  MoodUi({this.imageNumber, this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: imageNumber == null
              ? Image.asset(imageAsset)
              : Image.asset('images/image$imageNumber.png'),
        ),
        margin: EdgeInsets.all(4),
        width: 35,
        height: 35,
        constraints: BoxConstraints(
            maxWidth: 40, maxHeight: 40, minHeight: 20, minWidth: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              end: Alignment.topLeft,
              begin: Alignment.topRight,
              colors: [Color(0xFFfe9b83), Color(0xFFfe9b83).withOpacity(.1)]),
          shape: BoxShape.circle,
          // border: Border.all(
          //   color: Color(0xFFFF7F61),
          // ),
        ),
      ),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xFFFFF2F2),
        shape: BoxShape.circle,
        border: Border.all(
          style: BorderStyle.values[1],
          color: Colors.red[100],
        ),
      ),
    );
  }
}
