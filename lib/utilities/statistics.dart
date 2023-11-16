class Statistics{

  static double mean(List<double> values){
    double sum = 0;
    for (double value in values){
      sum += value;
    }
    return sum / values.length;
  }

  static double variance(List<double> values){
    double mean = Statistics.mean(values);
    double sum = 0;
    for (double value in values){
      sum += (value - mean) * (value - mean);
    }
    return sum / values.length;
  }

  double min(List<double> values){
    double min = values[0];
    for (double value in values){
      if (value < min){
        min = value;
      }
    }
    return min;
  }

  double max(List<double> values){
    double max = values[0];
    for (double value in values){
      if (value > max){
        max = value;
      }
    }
    return max;
  }

  double median(List<double> values){
    values.sort();
    if (values.length % 2 == 0){
      return (values[values.length ~/ 2] + values[values.length ~/ 2 - 1]) / 2;
    }
    else{
      return values[values.length ~/ 2];
    }
  }

  double mode(List<double> values){
    Map<double, int> counts = {};
    for (double value in values){
      if (counts.containsKey(value)){
        counts[value] = counts[value]! + 1;
      }
      else{
        counts[value] = 1;
      }
    }
    double mode = values[0];
    int maxCount = 0;
    for (double value in counts.keys){
      if (counts[value]! > maxCount){
        mode = value;
        maxCount = counts[value]!;
      }
    }
    return mode;
  }
}