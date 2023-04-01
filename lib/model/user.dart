import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql/client.dart' hide JsonSerializable; //todo trap
import 'package:graphql_sample/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String? description,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

@riverpod
class UserQueries extends _$UserQueries {
  late final GraphQLClient client;
  bool isLoading = false;

  @override
  User build() {
    client = ref.read(graphQLClientProvider);
    return const User(id: 'null', name: 'null', description: 'null');
  }

  Future<void> addUser({required String name, String? description}) async {
    final addUserMutation =
        await rootBundle.loadString('lib/graphql/add_user.graphql');

    final MutationOptions options = MutationOptions(
      document: gql(addUserMutation),
      variables: <String, dynamic>{
        'user': {
          'name': name,
          'description': description,
        }
      },
    );

    final QueryResult result = await client.mutate(options);

    if (result.isLoading && result.data != null) {
      isLoading = true;
    }

    if (result.hasException) {
      debugPrint(result.exception.toString());
    }

    debugPrint('USER: ${result.data}');

    debugPrint('USER: ${result.data!['addUser']['user'][0]}');
    final userJson = result.data!['addUser']['user'][0];

    // retrieve the data
    final User user = User.fromJson(userJson);
    state = state.copyWith(
        id: user.id, name: user.name, description: user.description);
  }

  Future<void> deleteUser({required String id }) async {
    final deleteUserMutation =
        await rootBundle.loadString('lib/graphql/delete_user.graphql');

    final MutationOptions options = MutationOptions(
      document: gql(deleteUserMutation),
      variables: <String, dynamic>{
        'filter': {
          'id': id,
        }
      },
    );

    final QueryResult result = await client.mutate(options);

    if (result.isLoading && result.data != null) {
      isLoading = true;
    }

    if (result.hasException) {
      debugPrint(result.exception.toString());
    }

    debugPrint('DELETED USER: ${result.data}');
    debugPrint('DELETED USER TRIM DOWN: ${result.data!['deletedUser']['user'][0]}');
  }

  Future<void> updateUser({
    String id = '0x1d',
    String name = 'update John',
    String description = 'update Doe',
  }) async {
    final updateUserMutation =
        await rootBundle.loadString('lib/graphql/update_user.graphql');

    final MutationOptions options = MutationOptions(
      document: gql(updateUserMutation),
      variables: <String, dynamic>{
        'patch': {
          'filter': {
            'id': [id],
          },
          'set': {
            'name': name,
            'description': description,
          }
        }
      },
    );

    final QueryResult result = await client.mutate(options);

    if (result.isLoading && result.data != null) {
      isLoading = true;
    }

    if (result.hasException) {
      debugPrint(result.exception.toString());
    }

    debugPrint('UPDATED USER: ${result.data}');
    debugPrint('UPDATED USER TRIM DOWN: ${result.data!['updateUser']['user'][0]}');


    final userJson = result.data!['updateUser']['user'][0]; // todo error when null

     final User user = User.fromJson(userJson);
    state = state.copyWith(
        id: user.id, name: user.name, description: user.description);


  }

  // need to add a user before getting one the local server
  Future<void> getUser({required String id}) async {
    final getUserQuery =
        await rootBundle.loadString('lib/graphql/get_user.graphql');

    final QueryOptions options = QueryOptions(
      document: gql(getUserQuery),
      variables: <String, dynamic>{
        // the variable put here must match the query variable //todo trap
        'userID': id
      },
    );

    final QueryResult result = await client.query(options);

    if (result.isLoading && result.data != null) {
      isLoading = true;
    }

    if (result.hasException) {
      debugPrint(result.exception.toString());
    }

    debugPrint('FULL USER RESULT: ${result.data}');

    debugPrint('USER TRIM DOWN: ${result.data!['getUser']}');
    final userJson = result.data!['getUser']; // todo error when null

    // retrieve the data
    final User user = User.fromJson(userJson);
    state = state.copyWith(
        id: user.id, name: user.name, description: user.description);
  }
}
