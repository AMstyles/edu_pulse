class Question {
  String? questionId;
  final String text;
  final String type; // 'multipleChoice', 'range', 'openEnded'
  final List<String>? options; // Only for 'multipleChoice' questions
  final List<String>? premises; // Only for 'range' questionsn e.g ['sad', 'happy']

  Question({
    required this.text,
    required this.type,
    this.options,
    this.premises,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      text: map['text'],
      type: map['type'],
      options: List<String>.from(map['options'] ?? []),
      premises: List<String>.from(map['premises'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'type': type,
      'options': options,
      'premises': premises,
    };
  }

  @override
  String toString() {
    return 'Question{questionId: $questionId, text: $text, type: $type, options: $options, premises: $premises}';
  }
}
