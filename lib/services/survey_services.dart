import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_pulse/models/survey.dart';
import '../models/question.dart';

class SurveyService {
  static final CollectionReference surveysCollection =
  FirebaseFirestore.instance.collection('surveys');

  static Future<List<Question>> getQuestions(String surveyId) async {


    List<Question> questions = [];


    try{

      final querySnapshot = await FirebaseFirestore.instance.collection('surveys').doc(surveyId).collection('questions').get();
      for (var doc in querySnapshot.docs) {
        Question question = Question.fromMap(doc.data());
        question.questionId = doc.id;
        questions.add(question);
      }
    }
    on FirebaseException catch(e){
      print(e.message);
    }

    return questions;
  }

  static Future<List<Survey>> getSurveys()async{

    List<Survey> surveys = [];
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection(
          'surveys').get();

    for (var doc in querySnapshot.docs) {
      Survey survey = Survey.fromMap(doc.data());
      survey.surveyId = doc.id;
      surveys.add(survey);
    }

    }on FirebaseException catch(e){
      print(e.message);
    }
    return surveys;
  }

  static Future<void> submitSurvey(String surveyId, List<Map<String, dynamic>> userResponses, String userID) async {
    try{
      await FirebaseFirestore.instance.collection('surveys').doc(surveyId).collection('responses').doc(userID).set({
        'responses': userResponses,
        'timestamp': DateTime.now(),
      });
    }
    on FirebaseException catch(e){
      print(e.message);
    }
  }

  static Future<List<Map<String,dynamic>>> getResponse(String surveyId)async{
    List<Map<String, dynamic>> responses = [];

      final querySnapshot = await FirebaseFirestore.instance.collection('surveys').doc(surveyId).collection('responses').get();
      for(var doc in querySnapshot.docs){
        responses.add(doc.data());
      }

    return Future.value(responses);
  }

 static Future<String> createSurvey(Survey survey)async{
    try{
      final docRef = await surveysCollection.add(survey.toMap());
      return docRef.id;
    }
    on FirebaseException catch(e){
      print(e.message);
      throw Exception(e.message);
    }
 }

 static Future<void> addQuestionsToSurvey(String surveyId, List<Question> questions)async{
    try{
      for(Question question in questions){
        await FirebaseFirestore.instance.collection('surveys').doc(surveyId).collection('questions').add(question.toMap());
      }
    }
    on FirebaseException catch(e){
      print(e.message);
      throw Exception(e.message);
    }
 }

}
