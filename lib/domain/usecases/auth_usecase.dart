import '../entities/user_entity.dart';
import '../../data/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository authRepository;

  AuthUseCase(this.authRepository);

  Future<UserEntity?> signIn(String email, String password) {
    return authRepository.signIn(email, password);
  }

  Future<UserEntity?> signUp(String email, String password) {
    return authRepository.signUp(email, password);
  }

  Future<void> signOut() {
    return authRepository.signOut();
  }
}
