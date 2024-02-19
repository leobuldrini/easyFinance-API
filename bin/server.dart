import 'dart:io';

import 'package:server/core/api.dart';
import 'package:server/core/models/local_storage_interface.dart';
import 'package:server/users/users_router.dart';
import 'package:server/users/users_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:supabase/supabase.dart';

// Configure routes.

void main(List<String> args) async {
  final SupabaseClient supabaseClient = SupabaseClient(
    const String.fromEnvironment('SUPABASE_URL'),
    const String.fromEnvironment('SUPABASE_KEY'),
    authOptions: AuthClientOptions(
      authFlowType: AuthFlowType.pkce,
      pkceAsyncStorage: AsyncStorageInterface(),
    ),
    realtimeClientOptions: const RealtimeClientOptions(
      logLevel: RealtimeLogLevel.info,
    ),
    storageOptions: const StorageClientOptions(
      retryAttempts: 10,
    ),
  );
  final UsersService userService = UsersService(supabaseClient: supabaseClient);
  final UsersRouter usersRouter = UsersRouter(userService: userService);
  final apiRouter = Api(usersRouter: usersRouter).router;

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(apiRouter);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
