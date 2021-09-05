import 'package:book_track_app/constants/constants.dart';
import 'package:book_track_app/model/book.dart';
import 'package:book_track_app/model/user.dart';
import 'package:book_track_app/widgets/book_search_page.dart';
import 'package:book_track_app/widgets/create_profile.dart';
import 'package:book_track_app/widgets/reading_list_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    CollectionReference bookCollectionReference =
        FirebaseFirestore.instance.collection('books');
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
                  Text(curUser.displayName.toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black)),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => BookSearchPage()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12, left: 12),
            width: double.infinity,
            child: RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.headline5,
                    children: [
                  TextSpan(text: "Your reading\n activity "),
                  TextSpan(
                      text: "right now ...",
                      style: TextStyle(fontWeight: FontWeight.bold))
                ])),
          ),
          SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: bookCollectionReference.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              var userBookFilteredReadListStream =
                  snapshot.data!.docs.map((book) {
                return Book.fromDocument(book);
              }).where((book) {
                return (book.userID == FirebaseAuth.instance.currentUser!.uid);
              })
              .toList();

              return Expanded(
                flex: 1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: userBookFilteredReadListStream.length,
                  itemBuilder: (context, index) {
                    Book book = userBookFilteredReadListStream[index];
                    return ReadingListCard(
                      rating: 5.0,
                      title: book.title,
                      author: book.author,
                      image: book.photoUrl,
                      buttonText: 'Reading',
                    );
                  },
                ),
              );
            },
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Reading List',
                          style: TextStyle(
                            color: kBlackColor ,
                              fontSize: 24, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: bookCollectionReference.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              var readingListBook = snapshot.data!.docs.map((book) {
                return Book.fromDocument(book);
              }).where((book) {
                return (book.userID == FirebaseAuth.instance.currentUser!.uid);
              })
              .toList();
              return Expanded(
                flex: 1,
                child: (readingListBook.length > 0
                    ? ListView.builder(
                        itemCount: readingListBook.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          Book book = readingListBook[index];
                          return ReadingListCard(
                            buttonText: 'Not Started',
                            rating: 5.0,
                            author: book.author,
                            image: book.photoUrl,
                            title: book.title,
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'No Books found.',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )),
              );
            },
          )
        ],
      ),
    );
  }
}
