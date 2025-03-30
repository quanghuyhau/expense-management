import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required String uid, required String email})
    : super(uid: uid, email: email);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(uid: json['uid'], email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email};
  }
}
