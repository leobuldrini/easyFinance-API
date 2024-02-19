import 'package:server/core/middleware/json_type_content_response.dart';
import 'package:server/users/users_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_router/shelf_router.dart';

class Api {
  final UsersRouter usersRouter;

  Api({required this.usersRouter});

  Handler get router {
    final router = Router();
    final prefix = '/api/v1';

    router.mount(prefix, usersRouter.router);

    return Pipeline()
        .addMiddleware(jsonTypeContentResponse())
        .addMiddleware(corsHeaders(headers: {
          // Allows all origins
          'Access-Control-Allow-Origin': '*',
          // Specify actual headers your client might send
          'Access-Control-Allow-Headers': 'Origin, Content-Type, Accept, Authorization',
          // Specify methods you want to allow
          'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
          // Optional: if you want to allow credentials
          'Access-Control-Allow-Credentials': 'true',
        }))
        .addHandler(router);
  }
}
