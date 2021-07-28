import 'package:cloud_firestore/cloud_firestore.dart';

class MUser {
  final String uid;
  final String id;
  final String? quote;
  final String? profession;
  final String? avatarUrl;
  final String displayName;
  MUser(
      {required this.uid,
      required this.id,
      this.quote,
      this.profession,
      this.avatarUrl,
      required this.displayName});

  factory MUser.fromDocument(QueryDocumentSnapshot data) {
    return MUser(
        uid: data['uid'],
        id: data.id,
        quote: data['quote'],
        profession: data['profession'],
        avatarUrl: data['avatar_url'],
        displayName: data['display_name']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'id': id,
      'display_name': displayName,
      'avatar_url': avatarUrl
    };
  }
}
