import 'package:supabase/supabase.dart';

class UsersService {
  final SupabaseClient supabaseClient;

  UsersService({required this.supabaseClient});

  Future<List<Map<String, dynamic>>> getUsers() async {
    final response = await supabaseClient.from('users').select();
    return response;
  }

  Future<void> insertUser(Map<String, dynamic> user) async {
    await supabaseClient.auth.signUp(email: user['email'], password: user['password']);
  }
}
