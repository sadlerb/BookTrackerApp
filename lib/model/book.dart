import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String title;
  final String author;
  final String? notes;
  final String categories;
  final String description;
  final String? id;
  final String? userID;
  final String photoUrl;
  final int pageCount;
  final String publishedDate;

  Book(
      {required this.photoUrl,
      required this.title,
      required this.author,
      this.notes,
      required this.categories,
      required this.description,
      this.id,
      this.userID,
      required this.pageCount,
      required this.publishedDate});
  factory Book.fromDocument(QueryDocumentSnapshot data) {
    

    return Book(
        id: data.id,
        title: data.get('title'),
        author: data.get('author'),
        notes: data.get('notes'),
        description: data.get('descripton'),
        categories: data.get('categories'),
        userID: data.get('user_id'),
        photoUrl: data.get('photo_url'),
        pageCount: data.get('page_count'),
        publishedDate: data.get('published_date'));
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'user_id': userID,
      'author': author,
      'notes': notes,
      'photo_url': photoUrl,
      'published_date': publishedDate,
      'descripton': description,
      'page_count': pageCount,
      'categories': categories
    };
  }
}
