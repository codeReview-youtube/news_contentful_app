class News {
  final String id;
  final String title;
  late String? description;
  final String date;
  late String? sourceUrl;
  late String? source;
  final String image;
  late String? content;

  News(
    this.id,
    this.title,
    this.date,
    this.image, {
    this.description,
    this.sourceUrl,
    this.source,
    this.content,
  });
}
