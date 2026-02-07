// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserQueries)
final userQueriesProvider = UserQueriesProvider._();

final class UserQueriesProvider
    extends $AsyncNotifierProvider<UserQueries, ({String status, User user})> {
  UserQueriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userQueriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userQueriesHash();

  @$internal
  @override
  UserQueries create() => UserQueries();
}

String _$userQueriesHash() => r'e9053ace1b5690783b807bfeb978c99cdd4dc1fd';

abstract class _$UserQueries
    extends $AsyncNotifier<({String status, User user})> {
  FutureOr<({String status, User user})> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<({String status, User user})>,
              ({String status, User user})
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<({String status, User user})>,
                ({String status, User user})
              >,
              AsyncValue<({String status, User user})>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
