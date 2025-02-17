import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mainTodoList.dart';

class AddTodoScreen extends ConsumerWidget {
  const AddTodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController todoController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Add Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: todoController,
              decoration: const InputDecoration(labelText: 'Enter new todo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (todoController.text.isNotEmpty) {
                  ref.read(todosProvider.notifier).addTodo(todoController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
