import 'package:edu_pulse/services/mood_service.dart';
import 'package:edu_pulse/utilities/mood_calculator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/mood.dart';

class MoodWidget extends StatefulWidget {
  const MoodWidget({Key? key}) : super(key: key);

  @override
  _MoodWidgetState createState() => _MoodWidgetState();
}

class _MoodWidgetState extends State<MoodWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: FutureBuilder(
          future: MoodService.getAllMoods(),
          builder: (BuildContext context, AsyncSnapshot<List<Mood>> snapshot) {
            if(snapshot.hasData) {
              return Container(
              padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 10,
                      offset: const Offset(0, 3),
                    )
                  ]
                ),

                child:  Stack(
                  alignment: Alignment.center,
                  children: [
                   Container(
                       color: Colors.white,
                     child: PieChart(
                        PieChartData(
                          sections: Mood.toPieChartData(snapshot.data!),
                        ),
                     ),
                   ),
                    Image.asset('lib/images/${MoodCalculator.getMoodImage(Mood.getAverageMood(snapshot.data!))}.png', width: 100, height: 100,),

                  ],
                )
              );
            }
            else{
              return const Center(child: CircularProgressIndicator.adaptive());
            }
          }
        )
    );

  }
}


