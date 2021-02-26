import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String displayName;
  final String username;
  final String bio;
  final String photoUrl;
  final String email;
  final String id;

  User({
    this.displayName,
    this.username,
    this.bio,
    this.photoUrl,
    this.email,
    this.id,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      displayName: doc['displayName'],
      username: doc['username'],
      email: doc['email'],
      photoUrl: doc['photoUrl'],
      bio: doc['bio'],
    );
  }
}
