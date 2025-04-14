import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final pageControllerProvider = Provider(
  (ref) => PageController(initialPage: 0, keepPage: true),
);

final authRepository = Provider((ref) => AuthRepo());
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authStateProvider = StreamProvider<User?>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return firebaseAuth.authStateChanges();
});

final authFuture = FutureProvider((ref) async {
  final res = FirebaseAuth.instance.currentUser;
  if (res != null) {
    final user =
        await FirebaseFirestore.instance.collection("Users").doc(res.uid).get();
    if (user.data() != null) {
      UserModel userdata = UserModel.fromMap(user.data()!);
      ref.read(userProvider.notifier).state = userdata;
    }
  }
});

class AuthRepo {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> getCurrentuser() async {
    return auth.currentUser;
  }

  Stream<User?> ifAuthStateChange() {
    return auth.authStateChanges();
  }

  static Future<User?> _googleSignIn() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      await auth.signOut();

      await googleSignIn.signOut();

      final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleAccount!.authentication;

      final AuthCredential authCred = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      UserCredential creds = await auth.signInWithCredential(authCred);

      User? gUserData = creds.user;
      return gUserData;
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserModel?> signIn() async {
    try {
      User? gUserData = await _googleSignIn();
      UserModel? finalUser;

      if (gUserData == null) throw "User Null!";

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(gUserData.uid)
          .get()
          .then((user) async {
            final dbUser = user.data();

            if (dbUser != null) {
              finalUser = UserModel(
                uid: dbUser['uid'],
                name: gUserData.displayName ?? dbUser['name'],
                image: gUserData.photoURL ?? dbUser['imgUrl'],
                email: dbUser['email'],
                createdOn: dbUser['createdOn'],
              );
            } else {
              finalUser = UserModel(
                email: gUserData.email!,
                name: gUserData.displayName!,
                uid: gUserData.uid,
                image: gUserData.photoURL!,
                createdOn: "${DateTime.now().millisecondsSinceEpoch}",
              );

              if (finalUser == null) throw "User Null!";
              await addUser(uid: finalUser!.uid, data: finalUser!.toMap());
            }
          });
      return finalUser;
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await auth.signOut();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> addUser({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("Users").doc(uid).set(data);
    } catch (e) {
      rethrow;
    }
  }
}
