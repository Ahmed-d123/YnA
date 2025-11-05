import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/usecases/submit_contact_form.dart';
import '../../data/datasources/contact_remote_datasource.dart';
import '../../data/repositories/contact_repository_impl.dart';

class HomeProvider extends ChangeNotifier {
  late final SubmitContactForm _submitContactForm;

  HomeProvider({required SupabaseClient supabaseClient}) {
    // --- Dependency Injection (Manual) ---
    final remoteDataSource = ContactRemoteDataSourceImpl(client: supabaseClient);
    final repository = ContactRepositoryImpl(remoteDataSource: remoteDataSource);
    _submitContactForm = SubmitContactForm(repository: repository);
    // -------------------------------------
  }
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> submitContactForm({
    required String name,
    required String email,
    required String message,
  }) async {
    _setLoading(true);
    
    final result = await _submitContactForm(
      ContactFormParams(name: name, email: email, message: message),
    );

    _setLoading(false);
    return result; 
  }
}
