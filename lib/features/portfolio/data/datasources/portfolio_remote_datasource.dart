import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/portfolio_model.dart';

// 5. Data Layer: Abstract class for data fetching.
abstract class PortfolioRemoteDataSource {
  Future<List<PortfolioModel>> getPortfolioList();
}

// 6. Data Layer: Implementation using Supabase.
class PortfolioRemoteDataSourceImpl implements PortfolioRemoteDataSource {
  final SupabaseClient client;
  final String _tableName = 'portfolio'; // اسم الجدول في Supabase

  PortfolioRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PortfolioModel>> getPortfolioList() async {
    try {
      // افترض أنك ستجلب كل المشاريع، مرتبة بالأحدث
      final data = await client
          .from(_tableName)
          .select()
          .order('created_at', ascending: false);
      
      // --- FIX ---
      // Add a null check. If RLS is misconfigured or the table is empty,
      // data might be null.
      if (data == null) {
        return []; // Return an empty list, not null
      }
      // --- END FIX ---

      final portfolios =
          data.map((item) => PortfolioModel.fromJson(item)).toList();
      return portfolios;
    } on PostgrestException catch (e) {
      print('Supabase Error (Portfolio): ${e.message}');
      rethrow;
    } catch (e) {
      print('PortfolioDataSource Error: $e');
      rethrow;
    }
  }
}
