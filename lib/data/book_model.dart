class Book {
  const Book({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.authorEn,
    required this.authorAr,
    required this.price,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.color,
    this.image,
  });

  final String id;
  final String titleEn;
  final String titleAr;
  final String authorEn;
  final String authorAr;
  final int price;
  final String descriptionEn;
  final String descriptionAr;

  /// Fallback cover color (used when the image asset is missing).
  final int color;

  /// Optional asset path, e.g. assets/images/book_republic.jpg
  final String? image;

  bool _ar(String lang) => lang == 'ar';
  String title(String lang) => _ar(lang) ? titleAr : titleEn;
  String author(String lang) => _ar(lang) ? authorAr : authorEn;
  String description(String lang) => _ar(lang) ? descriptionAr : descriptionEn;
}