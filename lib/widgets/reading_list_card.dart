import 'package:book_track_app/constants/constants.dart';
import 'package:book_track_app/model/book.dart';
import 'package:book_track_app/widgets/book_rating.dart';
import 'package:book_track_app/widgets/two_sided_rounded_button.dart';
import 'package:flutter/material.dart';

class ReadingListCard extends StatelessWidget {
  const ReadingListCard(
      {Key? key,
       this.image,
      this.title,
      this.author,
      this.rating,
      this.buttonText,
      this.book,
      this.isBookRead,
      this.pressDetails,
      this.pressRead})
      : super(key: key);
  final String? image;
  final String? title;
  final String? author;
  final double? rating;
  final String? buttonText;
  final Book? book;
  final bool? isBookRead;
  final Function? pressDetails;
  final Function? pressRead;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 202,
      margin: EdgeInsets.only(left: 24, bottom: 0),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              height: 244,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(29),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 33,
                        color: kShadowColor)
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(image!,width: 100,),
          ),
          Positioned(
            top: 35,
            right: 10,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border),
                ),
                BookRating(score: (rating!))
              ],
            ),
          ),
          Positioned(
            top: 160,
            height: 85,
            width: 202,
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6,left: 24),
                    child: RichText(
                      maxLines: 2,
                      text: TextSpan(
                          style: TextStyle(color: kBlackColor),
                          children: [
                            TextSpan(
                                text: '$title\n',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: author,
                                style: TextStyle(color: kLightBlackColor)),
                          ]),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        alignment: Alignment.center,
                        child: Text('Details'),
                      ),
                      Expanded(child: TwoSidedRoundedButton(
                        text: buttonText!,
                        press: pressRead,
                        color: kLightPurple,
                      ))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
