class Response {
  final String responseId;
  final String surveyId;
  final String userId;
  final List<Map<String, dynamic>> answers; // Dynamic for flexibility

  Response({
    required this.responseId,
    required this.surveyId,
    required this.userId,
    required this.answers,
  });

  factory Response.fromMap(Map<String, dynamic> map) {
    return Response(
      responseId: map['responseId'],
      surveyId: map['surveyId'],
      userId: map['userId'],
      answers: List<Map<String, dynamic>>.from(map['answers']),
    );
  }
}
