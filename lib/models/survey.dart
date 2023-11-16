class Survey {
  String? surveyId;
  final String title;
  final String description;

  Survey({
    required this.title,
    required this.description,
  });

  factory Survey.fromMap(Map<String, dynamic> map) {
    return Survey(
      title: map['title'],
      description: map['description'],
    );
  }
}
