import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/user.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, WidgetRef ref, __) {
      var user = ref.watch(userQueriesProvider);
      return 
      
      
      Scaffold(

        body: Column(
          children: [
          ListView(
            shrinkWrap: true,
              children: [ListTile(
                leading: Text(user.id),
                title: Text(user.name),
                subtitle: Text(user.description ?? 'null'),
              ),]
            ),
            //const Spacer(),
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
           await userQueries.addUser(name: 'John', description: 'Doe');
          },
          child: const Text('add'),
        ),
        // delete
        OutlinedButton(
          onPressed: () {},
          child: const Text('delete'),
        ),
        // update
        OutlinedButton(
          onPressed: () {},
          child: const Text('update'),
        ),
        // get
        OutlinedButton(
          onPressed: () async {
            await userQueries.getUser('0x15');
          },
          child: const Text('get'),
        ),
      ],
    );
  }
}
