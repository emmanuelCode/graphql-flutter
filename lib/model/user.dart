import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql/client.dart' hide JsonSerializable;
import 'package:graphql_sample/main.dart';
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
  late final GraphQLClient client;

  @override
  User build() {
    client = ref.read(graphQLClientProvider);
    return const User(id: 'null', name: 'null', description: 'null');
  }

  void addUser({required String name, String? description}) async {
    final addUserQuery =
        await rootBundle.loadString('lib/graphql/add_user.graphql');

    final QueryOptions options = QueryOptions(
      document: gql(addUserQuery),
      variables: <String, dynamic>{
        'name': name,
        'description': description,
      },
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      debugPrint(result.exception.toString());
    }

    //retrieve the data
    final User user = result.data!['user'] as User;
    state = user;

    debugPrint('USER: ${user.toString()}');
  }

  void deleteUser() async {}

  void updateUser() async {}

  void getUser() async {}
}
