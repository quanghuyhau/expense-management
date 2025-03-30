import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qlct/domain/entities/user_entity.dart';
import 'package:qlct/domain/usecases/auth_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCase authUseCase;

  AuthCubit(this.authUseCase) : super(AuthInitial());

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      UserEntity? user = await authUseCase.signIn(email, password);
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure("Đăng nhập thất bại"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());
    try {
      UserEntity? user = await authUseCase.signUp(email, password);
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure("Đăng ký thất bại"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signOut() async {
    await authUseCase.signOut();
    emit(AuthInitial());
  }
}
