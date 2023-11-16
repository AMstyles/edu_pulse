import 'package:flutter/material.dart';

class MoodCalculator {
  //write a function that takes in a double from 0 to 1 and returns string [very unpleasant, slightly unpleasant, unpleasant, neutral, pleasant, slightly pleasant, very pleasant]
  static String calculateMood(double value) {
    if (value < 0.1) {
      return 'Very Unpleasant';
    } else if (value < 0.3) {
      return 'Unpleasant';
    } else if (value < 0.4) {
      return 'Slightly Unpleasant';
    } else if (value < 0.6) {
      return 'Neutral';
    } else if (value < 0.7) {
      return 'Slightly Pleasant';
    } else if (value < 0.9) {
      return 'Pleasant';
    } else {
      return 'Very Pleasant';
    }
  }

  static String getMoodPieChartName(double value) {
    // map to Unpleasant, Neutral, Pleasant
    if (value < 0.3) {
      return 'Unpleasant';
    } else if (value < 0.6) {
      return 'Neutral';
    } else {
      return 'Pleasant';
    }
  }

  static String getMoodImage(double value) {
    // map to Unpleasant, Neutral, Pleasant
    if (value < 0.3) {
      return 'mood_sad';
    } else if (value < 0.6) {
      return 'mood_neutral';
    } else {
      return 'mood_happy';
    }
  }

  //write a method that takes a double [0,1] and returns an double mapped to [10,50] rounded to the nearest integer
  static int calculateMoodSize(double value) {
    return (value * 40 + 10).round();
  }

  //write a method that takes a double [0,1] and returns a color mapped to [purple, blue, green, orange]
  static Color calculateMoodColor(double value) {
    if (value < 0.3) {
      return Colors.deepPurple;
    } else if (value < 0.6) {
      return Colors.blue;
    } else if (value < 0.8) {
      return Colors.green[900]!;
    } else {
      return Colors.orange;
    }
  }

  static Color getPieMoodColor(double value) {
   //map to [purple, blue, orange]
    if (value < 0.3) {
      return Colors.deepPurple;
    } else if (value < 0.6) {
      return Colors.blue;
    } else {
      return Colors.orange;
    }
  }
}
