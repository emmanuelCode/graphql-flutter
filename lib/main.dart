import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';
import 'package:graphql_sample/graphql_client.dart';
import 'package:graphql_sample/view/user_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.g.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

@riverpod
GraphQLClient graphQLClient(GraphQLClientRef ref) {
  return graphQLClientInit();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter GraphQL Demo',
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomeView(),
    );
  }
}

