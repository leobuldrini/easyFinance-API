import 'package:supabase/supabase.dart';

class AsyncStorageInterface extends GotrueAsyncStorage {
  @override
  Future<void> removeItem({required String key}) async {
    if (key == '') throw UnimplementedError();
    return;
  }

  @override
  Future<String?> getItem({required String key}) async {
    if (key == '') throw UnimplementedError();
    return null;
  }

  @override
  Future<void> setItem({required String key, required String value}) async {
    if (key == '') throw UnimplementedError();
  }
}
