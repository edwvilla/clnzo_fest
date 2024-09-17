class Incident {
  final String id;
  final String description;
  final String url;
  final DateTime time;

  Incident({
    required this.id,
    required this.description,
    required this.url,
    required this.time,
  });

  factory Incident.fromMap(Map<String, dynamic> map) {
    return Incident(
      id: map['id'],
      description: map['description'],
      url: map['url'],
      time: DateTime.parse(map['when']),
    );
  }
}
