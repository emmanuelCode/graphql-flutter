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

final class UserQueriesProvider extends $NotifierProvider<UserQueries, User> {
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(User value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<User>(value),
    );
  }
}

String _$userQueriesHash() => r'295b951d7002b44e2894ed9237a797ae602786c7';

abstract class _$UserQueries extends $Notifier<User> {
  User build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<User, User>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<User, User>,
              User,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
