import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// hide the JsonSerializable as there is a library conflict with json_annotation
import 'package:graphql/client.dart' hide JsonSerializable; 
import 'package:graphql_sample/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
abstract class User with _$User {
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
  
  // this uses dart record syntax to return multiple values
  // see: https://dart.dev/language/records
  @override
  Future<({User user, String status})> build() async {
    client = ref.read(graphQLClientProvider);
    return (
      user: const User(id: 'null', name: 'null', description: 'null'),
      status: 'Initial'
    );
  }

  Future<void> addUser({required String name, String? description}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final addUserMutation =
          await rootBundle.loadString('lib/graphql/add_user.graphql');

      final MutationOptions options = MutationOptions(
        document: gql(addUserMutation),
        variables: <String, dynamic>{
          // the variable put here must match the query variable ($user)
          'user': {
            'name': name,
            'description': description,
          }
        },
      );

      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        debugPrint(result.exception.toString());
        throw result.exception!;
      }

      debugPrint('ADD USER: ${result.data}');

      final userJson = result.data?['addUser']['user'][0];

      debugPrint('ADD USER TRIM DOWN: $userJson');

      final user = User.fromJson(userJson);
      return (user: user, status: 'Added User');
    });
  }

  Future<void> deleteUser({required String id}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final deleteUserMutation =
          await rootBundle.loadString('lib/graphql/delete_user.graphql');

      final MutationOptions options = MutationOptions(
        document: gql(deleteUserMutation),
        variables: <String, dynamic>{
          // the variable put here must match the query variable ($filter)
          'filter': {
            'id': [id],
          }
        },
      );

      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        debugPrint(result.exception.toString());
        throw result.exception!;
      }

      debugPrint('DELETE USER: ${result.data}');

      final userJson = result.data?['deleteUser']['user'][0];

      debugPrint('DELETE USER TRIM DOWN: $userJson');

      final user = User.fromJson(userJson);
      return (user: user, status: 'Deleted User');
    });
  }

  Future<void> updateUser({
    required String id,
    required String name,
    String? description,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final updateUserMutation =
          await rootBundle.loadString('lib/graphql/update_user.graphql');

      final MutationOptions options = MutationOptions(
        document: gql(updateUserMutation),
        variables: <String, dynamic>{
          // the variable put here must match the query variable ($patch)
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

      if (result.hasException) {
        debugPrint(result.exception.toString());
        throw result.exception!;
      }

      debugPrint('UPDATED USER: ${result.data}');

      final userJson = result.data?['updateUser']['user'][0];

      debugPrint('UPDATED USER TRIM DOWN: $userJson');

      final user = User.fromJson(userJson);
      return (user: user, status: 'Updated User');      
    });
  }

  Future<void> getUser({required String id}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final getUserQuery =
          await rootBundle.loadString('lib/graphql/get_user.graphql');

      final QueryOptions options = QueryOptions(
        document: gql(getUserQuery),
        // this will ensure we do not use cached data
        fetchPolicy: FetchPolicy.networkOnly,
        variables: <String, dynamic>{
          // the variable put here must match the query variable ($userID)
          'userID': id
        },
      );

      final QueryResult result = await client.query(options);

      if (result.hasException) {
        debugPrint(result.exception.toString());
        throw result.exception!;
      }

      debugPrint('GET USER: ${result.data}');

      final userJson = result.data?['getUser'];

      debugPrint('GET USER TRIM DOWN: $userJson');

      final user = User.fromJson(userJson);
      return (user: user, status: 'Got User');
    });
  }
}
