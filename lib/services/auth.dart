import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _firebase = FirebaseAuth.instance;

  AuthService._();

  static FirebaseAuth get _authInstance => _firebase;

  static Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) {
    return _authInstance.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  static Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) {
    return _authInstance.signInWithEmailAndPassword(
        email: email, password: password);
  }

  static Future<void> signOut() {
    return _authInstance.signOut();
  }

  static String? getCurrentUserId() {
    return _authInstance.currentUser?.uid;
  }

  static Stream<User?> authStateChanges() {
    return _authInstance.authStateChanges();
  }
}
