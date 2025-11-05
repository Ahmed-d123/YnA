import '../../domain/entities/testimonial.dart';
import '../../domain/repositories/testimonial_repository.dart';
import '../datasources/testimonial_remote_datasource.dart';

class TestimonialRepositoryImpl implements TestimonialRepository {
  final TestimonialRemoteDataSource remoteDataSource;

  TestimonialRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Testimonial>> getTestimonials() async {
    try {
      return await remoteDataSource.getTestimonials();
    } catch (e) {
      rethrow;
    }
  }
}
