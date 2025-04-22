class Video {
  final String id;
  final String name;
  final String url;
  final String title;
  final String createdAt;

  Video({
    required this.id,
    required this.name,
    required this.url,
    required this.title,
    required this.createdAt,
  });

  // Método para convertir JSON a Video
  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      title: json['title'],
      createdAt: json['createdAt'],
    );
  }

  // Método para convertir Video a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'title': title,
      'createdAt': createdAt,
    };
  }
}
