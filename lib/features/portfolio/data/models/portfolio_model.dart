import '../../domain/entities/portfolio.dart';

// 4. Data Layer: Extends Entity, adds fromJson for parsing.
class PortfolioModel extends Portfolio {
  PortfolioModel({
    required super.id,
    required super.title,
    required super.description,
    required super.mainImage,
    required super.images,
  });

  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    // Supabase stores string arrays as List<dynamic>
    final imageList = (json['images'] as List<dynamic>? ?? []).cast<String>();

    return PortfolioModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      mainImage: json['main_image'] as String,
      images: imageList,
    );
  }
}
