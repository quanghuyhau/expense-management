import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserEntity?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        return UserModel(uid: user.uid, email: user.email ?? "");
      }
    } catch (e) {
      throw Exception("Đăng nhập thất bại: ${e.toString()}");
    }
    return null;
  }

  Future<UserEntity?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        return UserModel(uid: user.uid, email: user.email ?? "");
      }
    } catch (e) {
      throw Exception("Đăng ký thất bại: ${e.toString()}");
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
