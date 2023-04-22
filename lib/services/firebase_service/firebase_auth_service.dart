import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:news_app_flutter/services/firebase_service/abstract_auth_service.dart';
import 'package:news_app_flutter/services/firebase_service/firebase_auth_model.dart';

class FirebaseAuthService implements AuthService {
  FirebaseAuthService({
    required auth.FirebaseAuth authService,
  }) : _firebaseAuth = authService;

  final auth.FirebaseAuth _firebaseAuth;

  FirebaseUser? _mapFirebaseUser(auth.User? user) {
    if (user == null) {
      return FirebaseUser.empty();
    }

    var splittedName = ['Name ', 'LastName'];
    if (user.displayName != null) {
      splittedName = user.displayName!.split(' ');
    }

    final map = <String, dynamic>{
      'id': user.uid,
      'firstName': splittedName.first,
      'lastName': splittedName.last,
      'email': user.email ?? '',
      'emailVerified': user.emailVerified,
      'imageUrl': user.photoURL ?? '',
      'isAnonymous': user.isAnonymous,
      'age': 0,
      'phoneNumber': '',
      'address': '',
    };
    return FirebaseUser.fromJson(map);
  }

  @override
  Future<FirebaseUser?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _mapFirebaseUser(userCredential.user!);
    } on auth.FirebaseAuthException catch (e) {
      throw _determineError(e);
    }
  }

  @override
  Future<FirebaseUser?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return _mapFirebaseUser(_firebaseAuth.currentUser!);
    } on auth.FirebaseAuthException catch (e) {
      throw _determineError(e);
    }
  }

  String _determineError(auth.FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return 'Email is Invalid';
      case 'user-disabled':
        return 'User account is disabled';
      case 'user-not-found':
        return 'User account not found';
      case 'wrong-password':
        return 'Password you provided is wrong.';
      case 'email-already-in-use':
      case 'account-exists-with-different-credential':
        return 'This email is already in use';
      case 'invalid-credential':
        return 'The given credentials are invalid';
      case 'operation-not-allowed':
        return 'Operation not allowed';
      case 'weak-password':
        return 'Password is weak';
      case 'ERROR_MISSING_GOOGLE_AUTH_TOKEN':
      default:
        return 'Error while authenticating';
    }
  }
}