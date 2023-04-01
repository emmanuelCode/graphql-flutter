import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_sample/model/user.dart';

class UserFormField extends ConsumerStatefulWidget {
  final int index;
  final String name;
  const UserFormField({
    required this.index,
    required this.name,
    super.key,
  });

  @override
  UserFormFieldState createState() => UserFormFieldState();
}

class UserFormFieldState extends ConsumerState<UserFormField> {
  final idTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final descriptionTextController = TextEditingController();

  InputDecoration namedOutlineInputBorder(String hint) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      hintText: hint,
    );
  }

  @override
  void dispose() {
    idTextController.dispose();
    nameTextController.dispose();
    descriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if (widget.index != 0)
            TextField(
              controller: idTextController,
              decoration: namedOutlineInputBorder('id (required)'),
            ),
          const SizedBox(height: 16),
          if (widget.index == 0 || widget.index == 3) ...[
            TextField(
              controller: nameTextController,
              decoration: namedOutlineInputBorder('name (required)'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionTextController,
              decoration: namedOutlineInputBorder('description (not required)'),
            ),
            const SizedBox(height: 16),
          ],
          OutlinedButton(
            onPressed: () async {
              FocusScope.of(context).unfocus(); // remove the keyboard
              final queries = ref.read(userQueriesProvider.notifier);

              switch (widget.name) {
                case 'ADD':
                  await queries.addUser(
                      name: nameTextController.text,
                      description: descriptionTextController.text);
                  break;
                case 'GET':
                  await queries.getUser(id: idTextController.text);
                  break;
                case 'DELETE':
                  await queries.deleteUser(id: idTextController.text);
                  break;
                case 'UPDATE':
                  await queries.updateUser(
                    id: idTextController.text,
                    name: nameTextController.text,
                    description: descriptionTextController.text,
                  );
                  break;
                default:
                  throw ('ERROR: widget name is ${widget.name}');
              }
            },
            child: Text(
              widget.name,
            ),
          )
        ],
      ),
    );
  }
}
