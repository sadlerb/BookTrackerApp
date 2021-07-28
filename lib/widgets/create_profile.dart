import 'package:book_track_app/model/user.dart';
import 'package:book_track_app/widgets/input_decoration.dart';
import 'package:book_track_app/widgets/update_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget createProfileDialog(BuildContext context, MUser curUser) {
  final TextEditingController _displayNameTextController =
      TextEditingController(text: curUser.displayName);
  final TextEditingController _professionTextController =
      TextEditingController(text:curUser.profession);
  final TextEditingController _quoteTextController = TextEditingController(text: curUser.quote);
  final TextEditingController _avatarTextController = TextEditingController(text: curUser.avatarUrl);
  return AlertDialog(
      content: Container(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(curUser.avatarUrl == null
                  ? 'https://picsum.photos/200/300'
                  : curUser.avatarUrl!),
              radius: 50,
            ),
          ],
        ),
        Text(
          'Books Read',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.redAccent,
              ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(curUser.displayName.toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle1),
              TextButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return UpdateUserProfile(displayNameTextController: _displayNameTextController, professionTextController: _professionTextController, quoteTextController: _quoteTextController, avatarTextController: _avatarTextController,user:curUser);
                      },
                    );
                  },
                  icon: Icon(Icons.mode_edit, color: Colors.black12),
                  label: Text(''))
            ],
          ),
        ),
        Text(
          '${curUser.profession}',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          child: SizedBox(
            width: 100,
            height: 2,
            child: Container(
              color: Colors.red,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.blueGrey.shade100),
              color: HexColor('#f1f3f6'),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Text(
                  'Favorite Quote',
                  style: TextStyle(color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100,
                    height: 2,
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                          curUser.quote == null
                              ? 'Favourite book quote: Life is Great'
                              : '"${curUser.quote!}"',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontStyle: FontStyle.italic))),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  ));
}

