import 'package:edu_pulse/models/survey.dart';
import 'package:edu_pulse/services/survey_services.dart';
import 'package:edu_pulse/utilities/response_analytics.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/question.dart';
import '../widgets/question enclosure.dart';

class SurveyResponseScreen extends StatefulWidget {
  const SurveyResponseScreen({Key? key, required this.survey}) : super(key: key);

  final Survey survey;

  @override
  _SurveyResponseScreenState createState() => _SurveyResponseScreenState();
}

class _SurveyResponseScreenState extends State<SurveyResponseScreen> {

  late Future<List<Map<String,dynamic>>> responses;
  List <Question> questions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    responses = SurveyService.getResponse(widget.survey.surveyId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Summary"),
      ),
      body:
      FutureBuilder(
          future: SurveyService.getQuestions(widget.survey.surveyId!),
      builder:(BuildContext context, AsyncSnapshot<List<Question>> snapshot){
      if(snapshot.hasData){
      questions = snapshot.data!;
    return FutureBuilder(
    future: responses,
    builder: (BuildContext context, AsyncSnapshot<List<Map<String,dynamic>>> snapshot) {
    if(snapshot.hasData){
    return _buildSurveyResponseUI(snapshot.data!);
    }
    else{
    return const Center(child: CircularProgressIndicator.adaptive());
    }
    },
    );
    }
    else{
    return const Center(child: CircularProgressIndicator.adaptive());
    }
    },
      )
      ,);
  }

  _buildSurveyResponseUI(List<Map<String, dynamic>> responses) {
    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (BuildContext context, int index) {
        return buildQuestionUI(questions[index] , responses);
      },
    );

  }

  Widget buildQuestionUI(Question question, List<Map<String, dynamic>> responses) {
    switch (question.type) {
      case 'multipleChoice':
        return QuestionEnclosure(child:buildMultipleChoiceQuestion(question, responses));
      case 'range':
        return QuestionEnclosure(child:buildRangeQuestion(question, responses));
      case 'openEnded':
        return QuestionEnclosure(child:buildOpenEndedQuestion(question, responses));
      default:
        return Container(); // Handle other question types as needed
    }
  }

  TextStyle style = GoogleFonts.abel(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey);

  Widget buildMultipleChoiceQuestion(Question question,  List<Map<String, dynamic>> responses) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question.text, style: style,),
        const SizedBox(height: 10,),
         SizedBox(
          width: double.infinity,
          height: 200,
          child: PieChart(
            swapAnimationCurve: Curves.easeInOut,
            swapAnimationDuration: const Duration(milliseconds: 500),
            PieChartData(
              sections: ResponseAnalytics.toPieChartData(responses, question.questionId!)
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRangeQuestion(Question question, List<Map<String, dynamic>> responses) {

    double mean = ResponseAnalytics.getMean(responses, question.questionId!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question.text,style: style,),
        const SizedBox(height: 10,),
        LinearProgressIndicator(value: mean, borderRadius: BorderRadius.circular(15), color: Colors.amber, minHeight: 25, backgroundColor: Colors.amber.withOpacity(0.2) ),
        const SizedBox(height: 10,),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
           Text(question.options!.first, style: style,),
         Text(question.options!.last, style: style,),

        ],),
        const SizedBox(height: 10,),
      ],
    );
  }

  Widget buildOpenEndedQuestion(Question question, List<Map<String, dynamic>> responses) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question.text, style: style,),
        const SizedBox(height: 10,),
        Row( children: [
          Flexible(flex:1, child: Text("Positive: ", style: style,)),
         Flexible(flex: 4, child: LinearProgressIndicator(value: 0.75, borderRadius: BorderRadius.circular(15), color: Colors.green, minHeight: 25, backgroundColor: Colors.green.withOpacity(0.2) )),
        ],),
        const SizedBox(height: 10,),
        Row( children: [
          Flexible(flex:1, child: Text("Negative: ", style: style,)),
          Flexible(flex: 4, child: LinearProgressIndicator(value: 0.25, borderRadius: BorderRadius.circular(15), color: Colors.red, minHeight: 25, backgroundColor: Colors.red.withOpacity(0.2), ),),
        ],),
        const SizedBox(height: 10,),
        TextButton(onPressed: (){}, child: const Text("Details", style: TextStyle(color: Colors.blue),),),
      ],
    );
  }
}