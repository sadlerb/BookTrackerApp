import 'package:cloud_firestore/cloud_firestore.dart';

class Book{
  final String title;
  final String author;
  final String notes;
  final String categories;
  final String description;
  final String id;

  Book({required this.title, required this.author, required this.notes, required this.categories, required this.description,required this.id});
  factory Book.fromDocument(QueryDocumentSnapshot data){
    return Book(id: data.id,
    title: data.get('title'),
    author: data.get('author'),
    notes: data.get('notes'),
    description: data.get('description'),
    categories: data.get('categories')
    );
  }
}
