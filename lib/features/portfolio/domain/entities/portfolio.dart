// 1. Domain Layer: The pure business object.
class Portfolio {
  final String id;
  final String title;
  final String description;
  final String mainImage; // The image shown in the list
  final List<String> images; // All images for the detail page

  Portfolio({
    required this.id,
    required this.title,
    required this.description,
    required this.mainImage,
    required this.images,
  });
}
