import 'dart:convert';

import 'package:book_track_app/model/book.dart';
import 'package:book_track_app/widgets/searched_book_details_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import 'input_decoration.dart';

class BookSearchPage extends StatefulWidget {
  @override
  _BookSearchPageState createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  TextEditingController _searchTextController = TextEditingController();
  String _noBooksReceived = '';

  List<Book>? listOfBooks = [];
  final _bookCollectionReference =
      FirebaseFirestore.instance.collection('books');

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Search'),
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
      ),
      body: Material(
        elevation: 2.0,
        child: Center(
          child: SizedBox(
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                        child: TextField(
                      onSubmitted: (value) {
                        _search();
                        
                      },
                      controller: _searchTextController,
                      decoration: formInputDecoraton(
                          label: 'Search', hintText: 'Flutter'),
                    )),
                  ),
                ),
                SizedBox(height: 12),
                (listOfBooks != null && listOfBooks!.isNotEmpty)
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 200,
                              width: 300,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children:
                                    createBookCards(listOfBooks!, context),
                              ),
                            ),
                          )
                        ],
                      )
                    : Center(
                        child: Text('$_noBooksReceived'),
                      )
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.9,
          ),
        ),
      ),
    );
  }

  void _search() async {
    await fetchBooks(_searchTextController.text).then((value) {
      setState(() {
        listOfBooks = value;
      });
    }, onError: (val) {
      throw Exception('Failed to load books ${val.toString()}');
    });
  }

  Future<List<Book>> fetchBooks(String query) async {
    List<Book> books = [];
    http.Response response = await http
        .get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query'));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      final Iterable list = body['items'];
      for (var item in list) {
        String title = item['volumeInfo']['title'] == null
            ? 'N/A'
            : item['volumeInfo']['title'];

        String author;
        if (item?['volumeInfo']?['authors']?[0] == null) {
          author = 'N/A';
        } else {
          author = item!['volumeInfo']!['authors']![0];
        }

        String description = item['volumeInfo']['description'] == null
            ? 'N/A'
            : item['volumeInfo']['description'];
        String publishedDate = item['volumeInfo']['publishedDate'] == null
            ? 'N/A'
            : item['volumeInfo']['publishedDate'];
        int pageCount = item['volumeInfo']['pageCount'] == null
            ? 0
            : item['volumeInfo']['pageCount'];
        String categories;
        if (item?['volumeInfo']?['categories']?[0] == null) {
          categories = 'N/A';
        } else {
          categories = item['volumeInfo']!['categories']![0];
        }
        String thumbnail =
            item?['volumeInfo']?['imageLinks']?['thumbnail'] == null
                ? ''
                : item!['volumeInfo']!['imageLinks']!['thumbnail'];

        Book searchedBook = Book(
            title: title,
            author: author,
            description: description,
            publishedDate: publishedDate,
            pageCount: pageCount,
            categories: categories,
            photoUrl: thumbnail);

        books.add(searchedBook);
      }
    } else {
      throw ('error ${response.reasonPhrase}');
    }
    return books;
  }

  List<Widget> createBookCards(List<Book> listOfBooks, BuildContext context) {
    List<Widget> children = [];
    for (var book in listOfBooks) {
      children.add(
        Container(
          width: 160,
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return SearchBookDetailDialog(
                      book: book,
                      bookCollectionReference: _bookCollectionReference);
                },
              );
            },
            child: Card(
              elevation: 5,
              color: HexColor('f6f4ff'),
              child: Wrap(
                children: [
                  Center(
                    child: Image.network(
                      // ignore: unnecessary_null_comparison
                      book.photoUrl == null || book.photoUrl.isEmpty
                          ? 'https://images.unsplash.com/photo-1546521343-4eb2c01aa44b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Ym9va3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'
                          : book.photoUrl,
                      width: 160,
                      height: 100,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      book.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: HexColor('#5d48b6')),
                    ),
                    subtitle: Text(
                      book.author,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return children;
  }
}
