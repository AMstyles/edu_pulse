import 'package:edu_pulse/utilities/mood_calculator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Mood{
  DateTime date = DateTime.now();
  String? note;
  double mood;

  Mood({required this.mood, this.note});

  factory Mood.fromMap(Map<String, dynamic> map) {
    return Mood(
      mood: map['mood'].toDouble(),
      note: map['note'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'mood': mood,
      'note': note,
    };
  }

  static List<PieChartSectionData>  toPieChartData ( var moods ){

    List<PieChartSectionData> sections = [];

    int unplasantCount = 0;
    int neutralCount = 0;
    int nleasantCount = 0;

    for (var mood in moods) {
      switch (MoodCalculator.getMoodPieChartName(mood.mood)) {
        case 'Unpleasant':
          unplasantCount++;
          break;
        case 'Neutral':
          neutralCount++;
          break;
        case 'Pleasant':
          nleasantCount++;
          break;
        default:
      }
    }

    sections.add(
      PieChartSectionData(
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black.withOpacity(0.5),
        ),
        color: Colors.deepPurple,
        value: unplasantCount.toDouble(),
        title: 'Unpleasant',
        radius: 50,
      ),

    );

    sections.add(
      PieChartSectionData(
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black.withOpacity(0.5),
        ),
        color: Colors.blue,
        value: neutralCount.toDouble(),
        title: 'Neutral',
        radius: 50,
      ),
    );

    sections.add(
      PieChartSectionData(
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black.withOpacity(0.5),
        ),
        color: Colors.orange,
        value: nleasantCount.toDouble(),
        title: 'Pleasant',
        radius: 50,
      ),
    );


    return sections;

  }

  static double getAverageMood(List<Mood> moods){
    double sum = 0;
    for (var mood in moods) {
      sum += mood.mood;
    }
    return sum/moods.length;
  }

}