  import 'package:book_track_app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> createUser(String displayName, BuildContext context) async{
    final userCollectionReference =
        FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;
    MUser user = MUser(displayName: displayName,uid: uid,profession: 'Placeholder',quote: 'Quote Here',avatarUrl: 'https://picsum.photos/200');

    userCollectionReference.add(user.toMap()).then((value) => print('UserAdded')).onError((error, stackTrace) => print(['Error',error]));
    return;
  }
