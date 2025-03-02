class Quote {
  final String id;
  final String text;
  final String author;
  final String category;
  final String details;
  final String meaning;
  final String imagePath;

  Quote({
    required this.id,
    required this.text,
    required this.author,
    required this.category,
    required this.details,
    required this.meaning,
    this.imagePath = '',
  });
}
