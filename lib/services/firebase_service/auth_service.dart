import 'package:news_app_flutter/services/firebase_service/firebase_auth_model.dart';

abstract class AuthService {
  Future<FirebaseUser?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<FirebaseUser?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });
}
