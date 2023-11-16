import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_pulse/models/survey.dart';
import '../models/question.dart';

class SurveyService {
  static final CollectionReference surveysCollection =
  FirebaseFirestore.instance.collection('surveys');

  static Future<List<Question>> getQuestions(String surveyId) async {
    QuerySnapshot querySnapshot =
    await surveysCollection.doc(surveyId).collection('questions').get();
    return querySnapshot.docs
        .map((doc) => Question.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  static Future<List<Survey>> getSurveys()async{

    List<Survey> surveys = [];
    try {
    print("step 1");

    print("step 2");

      final querySnapshot = await FirebaseFirestore.instance.collection(
          'surveys').get();


    print("step 3");
    for (var doc in querySnapshot.docs) {
      print(doc.data());
      Survey survey = Survey.fromMap(doc.data());
      survey.surveyId = doc.id;
      surveys.add(survey);
    }
    print("step 4");
    }on FirebaseException catch(e){
      print(e.message);
    }
    return surveys;
  }

}
