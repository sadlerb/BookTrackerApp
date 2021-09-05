import 'package:book_track_app/constants/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TwoSidedRoundedButton extends StatelessWidget {
  const TwoSidedRoundedButton(
      {Key? key,
      this.text = 'Default',
      this.radius = 30,
      this.press = print,
      this.color = kBlackColor})
      : super(key: key);
  final String text;
  final double radius;
  final Function? press;
  final Color color;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press!(''),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            bottomRight: Radius.circular(radius)
          ),
        ),
        child: Text(text,style:TextStyle(color: Colors.white)),
      ),
    );
  }
}
