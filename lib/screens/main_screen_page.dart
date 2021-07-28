import 'package:book_track_app/model/book.dart';
import 'package:book_track_app/model/user.dart';
import 'package:book_track_app/widgets/create_profile.dart';
import 'package:book_track_app/widgets/input_decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'login_page.dart';

class MainScreenPage extends StatelessWidget {
  const MainScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final TextEditingController _displayNameTextController =
    //     TextEditingController();
    // final TextEditingController _professionTextController =
    //     TextEditingController();
    // final TextEditingController _quoteTextController = TextEditingController();
    // final TextEditingController _avatarTextController = TextEditingController();
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 77,
        backgroundColor: Colors.white24,
        elevation: 0.0,
        centerTitle: false,
        title: Row(
          children: [
            Text('A.Reader',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          StreamBuilder<QuerySnapshot>(
            stream: userCollection.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final usersListStream = snapshot.data!.docs.map((user) {
                return MUser.fromDocument(user);
              }).where((user) {
                return (user.uid == FirebaseAuth.instance.currentUser!.uid);
              }).toList();
              MUser curUser = usersListStream[0];
              return Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: InkWell(
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(curUser.avatarUrl != null
                            ? curUser.avatarUrl!
                            : 'https://picsum.photos/200'),
                        backgroundColor: Colors.white,
                        child: Text(''),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return createProfileDialog(context, curUser); 
                            });
                      },
                    ),
                  ),
                  Text('${curUser.displayName}',
                      style: TextStyle(color: Colors.black26)),
                ],
              );
            },
          ),
          TextButton.icon(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  return Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                });
              },
              icon: Icon(Icons.logout),
              label: Text(''))
        ],
      ),
    );
  }
}
