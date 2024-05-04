import 'package:auth_todo_serverpod_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class TodoEndpoint extends Endpoint {
  Future<Todo> readTodoById(Session session, int todoId) async {
    final todo = await Todo.db.findById(session, todoId);
    if (todo == null) {
      throw Exception('user-not-found');
    }
    return todo;
  }

  Future<List<Todo>> readAllTodo(Session session) async {
    final todo = await Todo.db.find(session);
    return todo;
  }
}
