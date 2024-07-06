import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_todolist/model/todo.dart';

final todoViewModelProvider =
    StateNotifierProvider<TodoViewModel, List<Todo>>((ref) => TodoViewModel());

class TodoViewModel extends StateNotifier<List<Todo>> {
  TodoViewModel() : super([]);

  // TodoリストにTodoを追加するメソッド
  void addTodo(String title) {
    state = [...state, Todo(id: state.length + 1, title: title, isDone: false)];
  }

  // TodoリストからTodoを削除するメソッド
  void removeTodo(int id) {
    // 指定されたidを持たないTodoオブジェクトだけが含まれる新しいリストをstateに代入することで、指定されたidのTodoオブジェクトを削除する
    // state = state.where((todo) => todo.id != id).toList(); と等価
    state = state.where((Todo todo) {
      return todo.id != id;
    }).toList();
  }

  // TodoのisDoneをトグルするメソッド
  void toggleTodo(int id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            title: todo.title,
            isDone: !todo.isDone,
          )
        else
          todo,
    ];
  }
}
