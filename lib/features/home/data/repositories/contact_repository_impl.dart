import '../datasources/contact_remote_datasource.dart';
import '../../domain/repositories/contact_repository.dart';

// Implementation of the repository in the Data layer
class ContactRepositoryImpl implements ContactRepository {
  final ContactRemoteDataSource remoteDataSource;

  ContactRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> submitForm({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      await remoteDataSource.submitContactForm(
        name: name,
        email: email,
        message: message,
      );
    } catch (e) {
      print('ContactRepositoryImpl Error: $e');
      rethrow;
    }
  }
}
