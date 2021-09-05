import 'package:book_track_app/constants/constants.dart';
import 'package:flutter/material.dart';

class BookRating extends StatelessWidget {
  const BookRating({Key? key, this.score = 0}) : super(key: key);
  final double score;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              offset: Offset(3, 7),
              blurRadius: 20,
              color: Color(0xFD3D3D3).withOpacity(0.5),
            )
          ]),
      child: Column(
        children: [
          Icon(
            Icons.star,
            color: kIconColor,
            size: 15,
          ),
          SizedBox(
            height: 5,
          ),
          Text('$score',style:TextStyle(fontSize: 12,fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
