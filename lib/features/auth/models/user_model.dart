import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String photoUrl;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  /// From Map
  /// Convert a JSON object to a Dart object => UserModel object

  // factory UserModel.fromMap(Map<String, dynamic> map) {
  //   return UserModel(
  //     uid: map['uid'],
  //     name: map['name'],
  //     email: map['email'],
  //     photoUrl: map['photoUrl'],
  //   );
  // }

  factory UserModel.fromFirestore(User user) {
    return UserModel(
      uid: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      photoUrl: user.photoURL ?? '',
    );
  }

  /// To Map
  /// Convert a Dart object => UserModel object to a Map object

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'name': name, 'email': email, 'photoUrl': photoUrl};
  }
}
