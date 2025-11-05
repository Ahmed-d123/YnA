import '../entities/testimonial.dart';

abstract class TestimonialRepository {
  Future<List<Testimonial>> getTestimonials();
}
