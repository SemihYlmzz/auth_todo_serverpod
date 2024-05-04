import 'package:auth_todo_serverpod_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class UserEndpoint extends Endpoint {
  Future<User> readUser(Session session, int userId) async {
    final user = await User.db.findById(session, userId);
    if (user == null) {
      throw Exception('user-not-found');
    }
    return user;
  }
}
