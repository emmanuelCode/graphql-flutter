// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// ignore: non_constant_identifier_names
_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );

// ignore: non_constant_identifier_names
Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userQueriesHash() => r'496e46a72ce5f16be9e59e71d8511370244c625c';

/// See also [UserQueries].
@ProviderFor(UserQueries)
final userQueriesProvider =
    AutoDisposeNotifierProvider<UserQueries, List<User>>.internal(
  UserQueries.new,
  name: r'userQueriesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userQueriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserQueries = AutoDisposeNotifier<List<User>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
