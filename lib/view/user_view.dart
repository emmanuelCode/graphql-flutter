import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_sample/view/user_form_fields.dart';

import '../model/user.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> queryNames = ['ADD', 'GET', 'DELETE', 'UPDATE'];
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GraphQL Sample'),
          bottom: TabBar(
            tabs: queryNames
                .map((name) => Tab(
                      text: name,
                    ))
                .toList(),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: TabBarView(
                    children: [
                      UserFormField(
                        index: 0,
                        name: queryNames[0],
                      ),
                      UserFormField(
                        index: 1,
                        name: queryNames[1],
                      ),
                      UserFormField(
                        index: 2,
                        name: queryNames[2],
                      ),
                      UserFormField(
                        index: 3,
                        name: queryNames[3],
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
      ),
    );
  }
}

class ResultWidget extends ConsumerWidget {
  const ResultWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userQueriesProvider);
    final String? status = ref.read(userQueriesProvider.notifier).status;

    return Column(
      children: [
        Text('Status: ${status ?? 'null'}',style: Theme.of(context).textTheme.titleLarge,),
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
