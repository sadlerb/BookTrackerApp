import 'package:book_track_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'input_decoration.dart';

class UpdateUserProfile extends StatelessWidget {
  const UpdateUserProfile({
    Key? key,
    required TextEditingController displayNameTextController,
    required TextEditingController professionTextController,
    required TextEditingController quoteTextController,
    required TextEditingController avatarTextController,
    required this.user,
  })  : _displayNameTextController = displayNameTextController,
        _professionTextController = professionTextController,
        _quoteTextController = quoteTextController,
        _avatarTextController = avatarTextController,
        super(key: key);

  final TextEditingController _displayNameTextController;
  final TextEditingController _professionTextController;
  final TextEditingController _quoteTextController;
  final TextEditingController _avatarTextController;
  final MUser user;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Edit ${user.displayName}'),
      ),
      content: Form(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(user.avatarUrl == null
                    ? 'https://picsum.photos/200/300'
                    : user.avatarUrl!),
                radius: 50,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _displayNameTextController,
                decoration:
                    formInputDecoraton(label: 'Your Name', hintText: ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _professionTextController,
                decoration:
                    formInputDecoraton(label: 'Profession', hintText: ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _quoteTextController,
                decoration:
                    formInputDecoraton(label: 'Favorite Quote', hintText: ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _avatarTextController,
                decoration:
                    formInputDecoraton(label: 'Avatar Url', hintText: ''),
              ),
            ),
          ],
        ),
      )),
      actions: [
        TextButton(
            onPressed: () {
              print('Updating...');
              final userChangedName =
                  user.displayName != _displayNameTextController.text;
              final userChangedAvatar =
                  user.avatarUrl != _avatarTextController.text;
              final userChangedProfession =
                  user.profession != _professionTextController.text;
              final userChangedQuote = user.quote != _quoteTextController.text;
              final userNeedUpdate = userChangedQuote ||
                  userChangedProfession ||
                  userChangedAvatar ||
                  userChangedName;
              if (userNeedUpdate) {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.id)
                    .update(MUser(
                            displayName: _displayNameTextController.text,
                            profession: _professionTextController.text,
                            quote: _quoteTextController.text,
                            avatarUrl: _avatarTextController.text,
                            uid: user.uid)
                        .toMap());
              }
              Navigator.of(context).pop();
            },
            child: Text('Update')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'))
      ],
    );
  }
}
