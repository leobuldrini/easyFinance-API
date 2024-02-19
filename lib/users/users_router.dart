import 'dart:convert';

import 'package:server/users/users_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class UsersRouter {
  final UsersService userService;

  Future<Response> _insertUser(Request request) async {
    final requestBody = await request.readAsString();
    final requestData = jsonDecode(requestBody);
    await userService.insertUser(requestData);
    return Response.ok('Hello, World!\n');
  }

  Handler get router {
    final router = Router();

    router.post('/users/insert', _insertUser);

    return router.call;
  }

  UsersRouter({required this.userService});
}
