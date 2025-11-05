import '../../domain/entities/testimonial.dart';

class TestimonialModel extends Testimonial {
  TestimonialModel({
    required super.id,
    required super.quote,
    required super.name,
    required super.title,
  });

  factory TestimonialModel.fromJson(Map<String, dynamic> json) {
    return TestimonialModel(
      id: json['id'] as String,
      quote: json['quote'] as String,
      name: json['name'] as String,
      title: json['title'] as String,
    );
  }
}
