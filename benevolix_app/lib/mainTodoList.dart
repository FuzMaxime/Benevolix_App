import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'page_add_item.dart';
import './services/api.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class Todo {
  final int id;
  final String todo;
  final bool completed;

  Todo({required this.id, required this.todo, required this.completed});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as int,
      todo: json['todo'] as String,
      completed: json['completed'] as bool,
    );
  }
}

final todosProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) => TodoNotifier());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Our Todos List')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(todo.todo),
            onTap: () => _showEditDialog(context, ref, todo),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(todo.completed ? Icons.check : Icons.close, color: todo.completed ? Colors.green : Colors.red),
                  onPressed: () => ref.read(todosProvider.notifier).updateTodo(todo.id, completed: !todo.completed),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => ref.read(todosProvider.notifier).deleteTodo(todo.id),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTodoScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref, Todo todo) {
    final TextEditingController controller = TextEditingController(text: todo.todo);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Todo'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Todo Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  ref.read(todosProvider.notifier).updateTodo(todo.id, newName: controller.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}