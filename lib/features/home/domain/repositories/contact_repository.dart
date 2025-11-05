// Abstract interface (the "contract") defined in the Domain layer
abstract class ContactRepository {
  Future<void> submitForm({
    required String name,
    required String email,
    required String message,
  });
}
