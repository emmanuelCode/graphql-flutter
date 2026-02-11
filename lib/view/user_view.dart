import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_sample/view/user_form_fields.dart';

import '../model/user.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> queryNames = ['ADD', 'GET', 'DELETE', 'UPDATE'];
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GraphQL Sample'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: TabBar(
            tabs: queryNames
                .map((name) => Tab(
                      text: name,
                    ))
                .toList(),
          ),
        ),
        body: SafeArea(
          child: ListView(
            physics: NeverScrollableScrollPhysics(
            ),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: TabBarView(
                  children: [
                    for (final (int index, String name) in queryNames.indexed)
                      UserFormField(
                        index: index,
                        name: name,
                      ),
                  ],
                ),
              ),
              const Divider(),
              const ResultWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultWidget extends ConsumerWidget {
  const ResultWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userQueriesProvider);

    // this will return the status of our model method results
    final String status = userAsync.when(
      data: (data) => data.status,
      error: (e, _) => 'Error (See Logs)',
      loading: () => 'Loading',
    );

    final user = userAsync.value?.user ??
        const User(id: 'null', name: 'null', description: 'null');

    return Column(
      children: [
        Text(
          'Status: $status',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Card(
          shape: const OutlineInputBorder(),
          elevation: 0,
          margin: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text('Name: ${user.name}'),
                subtitle: Text('Id: ${user.id}'),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(user.description ?? 'null'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
