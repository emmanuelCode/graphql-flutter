import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String description,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

@riverpod
class UserQueries extends _$UserQueries {
  @override
  List<User> build() => [];

  void addUser() async {}

  void deleteUser() async {}

  void updateUser() async {}

  void getUser() async {}
}
