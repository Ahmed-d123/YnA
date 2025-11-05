import 'package:supabase_flutter/supabase_flutter.dart';

// Abstract interface for the data source
abstract class ContactRemoteDataSource {
  Future<void> submitContactForm({
    required String name,
    required String email,
    required String message,
  });
}

// Implementation using Supabase Edge Function
class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  final SupabaseClient client;
  final String _functionName = 'send-contact-email';

  ContactRemoteDataSourceImpl({required this.client});

  @override
  Future<void> submitContactForm({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final body = {
        'name': name,
        'email': email,
        'message': message,
      };
      
      // Call the edge function
      await client.functions.invoke(_functionName, body: body);

    } on FunctionException catch (e) {
      // Handle Supabase Function-specific errors
      print('Supabase Function Error: ${e.details}');
      rethrow;
    } catch (e) {
      // Handle other errors
      print('ContactRemoteDataSource Error: $e');
      rethrow;
    }
  }
}
