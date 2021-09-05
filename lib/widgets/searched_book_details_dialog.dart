import 'package:book_track_app/model/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchBookDetailDialog extends StatelessWidget {
  const SearchBookDetailDialog({
    Key? key,
    required this.book,
    required CollectionReference<Map<String, dynamic>> bookCollectionReference,
  }) : _bookCollectionReference = bookCollectionReference, super(key: key);

  final Book book;
  final CollectionReference<Map<String, dynamic>> _bookCollectionReference;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: [
          Container(
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(book.photoUrl),
              radius: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${book.title}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Page Count:${book.pageCount}'),
          ),
          Text('Author: ${book.author}'),
          Text('Published : ${book.publishedDate}'),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.blueGrey.shade100, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${book.description}',
                    style: TextStyle(
                        wordSpacing: 0.9, letterSpacing: 1.5),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            _bookCollectionReference.add(Book(
                    photoUrl: book.photoUrl,
                    title: book.title,
                    author: book.author,
                    categories: book.categories,
                    description: book.description,
                    pageCount: book.pageCount,
                    publishedDate: book.publishedDate,
                    userID:
                        FirebaseAuth.instance.currentUser!.uid)
                .toMap());

                Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'))
      ],
    );
  }
}
