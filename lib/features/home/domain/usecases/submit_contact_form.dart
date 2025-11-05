import '../repositories/contact_repository.dart';

// Usecase: Connects Presentation (Provider) to Domain (Repository)
class SubmitContactForm {
  final ContactRepository repository;

  SubmitContactForm({required this.repository});

  // Call method to execute the use case
  Future<bool> call(ContactFormParams params) async {
    try {
      await repository.submitForm(
        name: params.name,
        email: params.email,
        message: params.message,
      );
      return true;
    } catch (e) {
      // In a real app, return a Failure object
      print('SubmitContactForm Usecase Error: $e');
      return false;
    }
  }
}

// Parameters object for the use case
class ContactFormParams {
  final String name;
  final String email;
  final String message;

  ContactFormParams({
    required this.name,
    required this.email,
    required this.message,
  });
}
