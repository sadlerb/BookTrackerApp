  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> createUser(String displayName, BuildContext context) async {
    final userCollectionReference =
        FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;

    Map<String, dynamic> user = {
      'display_name': displayName,
      'uid': uid,

    };
    await userCollectionReference.add(user).then((value) => print('UserAdded')).onError((error, stackTrace) => print(['Error',error]));
  }
