import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './../mainTodoList.dart';


class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]) {
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/todos'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['todos'];
      state = data.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<void> addTodo(String todo) async {
    final newTodo = Todo(id: state.length + 1, todo: todo, completed: false);
    state = [...state, newTodo];
    
    await http.post(
      Uri.parse('https://dummyjson.com/todos/add'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'todo': todo, 'completed': false}),
    );
  }

   Future<void> updateTodo(int id, {String? newName, bool? completed}) async {
    state = state.map((todo) {
      if (todo.id == id) {
        return Todo(
          id: todo.id,
          todo: newName ?? todo.todo,
          completed: completed ?? todo.completed,
        );
      }
      return todo;
    }).toList();
    
    await http.put(
      Uri.parse('https://dummyjson.com/todos/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'todo': newName, 'completed': completed}),
    );
  }

  Future<void> deleteTodo(int id) async {
    state = state.where((todo) => todo.id != id).toList();
    
    await http.delete(Uri.parse('https://dummyjson.com/todos/$id'));
  }
}