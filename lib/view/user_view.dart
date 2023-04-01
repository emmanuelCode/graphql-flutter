
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_sample/view/user_form_fields.dart';

import '../model/user.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, WidgetRef ref, __) {
      var user = ref.watch(userQueriesProvider);
      return Scaffold(
        body: Column(
          children: [
            ListView(shrinkWrap: true, children: [
              ListTile(
                leading: Text(user.id),
                title: Text(user.name),
                subtitle: Text(user.description ?? 'null'),
              ),
            ]),
            const ButtonsRow(),
          ],
        ),
      );
    });
  }
}

class ButtonsRow extends ConsumerWidget {
  const ButtonsRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userQueries = ref.read(userQueriesProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // add
        OutlinedButton(
          onPressed: () async {
            await userQueries.addUser(name: 'John', description: 'Doe'); // todo
          },
          child: const Text('add'),
        ),
        // delete
        OutlinedButton(
          onPressed: () async {
            await userQueries.deleteUser(id:'0x15'); //todo
          },
          child: const Text('delete'),
        ),
        // update
        OutlinedButton(
          onPressed: () async {
            await userQueries.updateUser();
          },
          child: const Text('update'),
        ),
        // get
        OutlinedButton(
          onPressed: () async {
            await userQueries.getUser(id:'0x1d'); //todo
          },
          child: const Text('get'),
        ),
      ],
    );
  }
}

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
      ),
    );
  }
}
