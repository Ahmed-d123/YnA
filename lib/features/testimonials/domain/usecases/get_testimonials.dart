import '../entities/testimonial.dart';
import '../repositories/testimonial_repository.dart';

class GetTestimonials {
  final TestimonialRepository repository;

  GetTestimonials(this.repository);

  Future<List<Testimonial>> call() async {
    return await repository.getTestimonials();
  }
}
