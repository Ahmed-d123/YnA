import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/testimonial_model.dart';

abstract class TestimonialRemoteDataSource {
  Future<List<TestimonialModel>> getTestimonials();
}

class TestimonialRemoteDataSourceImpl implements TestimonialRemoteDataSource {
  final SupabaseClient client;
  final String _tableName = 'testimonials'; // اسم الجدول في Supabase

  TestimonialRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TestimonialModel>> getTestimonials() async {
    try {
      final data = await client
          .from(_tableName)
          .select()
          .order('created_at', ascending: false);

      // --- FIX ---
      // Add a null check. If RLS is misconfigured or the table is empty,
      // data might be null.
      if (data == null) {
        return []; // Return an empty list
      }
      // --- END FIX ---

      final testimonials =
          data.map((item) => TestimonialModel.fromJson(item)).toList();
      return testimonials;
    } on PostgrestException catch (e) {
      print('Supabase Error (Testimonials): ${e.message}');
      rethrow;
    } catch (e) {
      print('TestimonialDataSource Error: $e');
      rethrow;
    }
  }
}
