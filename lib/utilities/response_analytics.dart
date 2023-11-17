import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ResponseAnalytics{

  //methods to analyze per question responses
  static List<Map<String, dynamic>> getQuestionResponse(List<Map<String, dynamic>> responses, String questionId){

    List<Map<String, dynamic>> questionResponses = [];


    for(var response in responses){
      for(var questionResponse in response['responses']){
        if(questionResponse['questionId'] == questionId){
          questionResponses.add(questionResponse);
        }
      }
    }

    return questionResponses;

  }

  static List<MaterialColor> colors= [
    //put six contrasting colors here
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
  ];


 static List<PieChartSectionData> toPieChartData(List<Map<String, dynamic>> responses, String questionId){
   List<PieChartSectionData> sections = [];

   List< Map<String, dynamic>> questionResponse = getQuestionResponse(responses, questionId);
    //set for name all the picked options
    Set<String> sectionNames = {};

    //populate the sectionNames set
    for (var response in questionResponse) {
      sectionNames.add(response['selectedOption']);
    }

    //key value pair to store the section name and the count
  Map<String, int> sectionCount = {};

    //populate the sectionCount map
    for (var element in sectionNames) {
      sectionCount[element] = 0;
    }

    //count the number of times each section name appears
    for (var response in questionResponse) {
      sectionCount[response['selectedOption']] = sectionCount[response['selectedOption']]! + 1;
    }

    //add the sections to the sections list
    for (var element in sectionCount.keys) {
      sections.add(
        PieChartSectionData(
          titleStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.5),
          ),
          color: colors[sectionNames.toList().indexOf(element)%6],
          value: sectionCount[element]!.toDouble(),
          title: element,
          radius: (200 - 20)/2,
        ),
      );
    }


   return sections;
 }

  static double getMean(List<Map<String, dynamic>> responses, String questionId){
    double mean = 0;

    List<double> values = [];

    List< Map<String, dynamic>> questionResponse = getQuestionResponse(responses, questionId);
    //set for name all the picked options


    //populate the sectionNames set
    for (var response in questionResponse) {
      values.add(response['rangeResponse']);
    }

  mean = values.reduce((value, element) => value + element)/values.length;

    print('mean is $mean');

    return mean/5.0;
  }

}