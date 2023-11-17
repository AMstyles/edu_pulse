import 'dart:ffi';

import 'package:edu_pulse/utilities/mood_calculator.dart';
import 'package:edu_pulse/widgets/home_widgets_enclosure.dart';
import 'package:flutter/material.dart';

import '../models/mood.dart';

class MoodsDetails extends StatefulWidget {
 MoodsDetails({Key? key, required this.moods}) : super(key: key);

  final List<Mood> moods;

  @override
  _MoodsDetailsState createState() => _MoodsDetailsState();
}

class _MoodsDetailsState extends State<MoodsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moods Details'),
      ),
      body: widget.moods.isEmpty?const Center(
        child: Text('No moods to display'),
      ):ListView.builder(
        itemCount: widget.moods.length,
        itemBuilder: (BuildContext context, int index) {
          double fmood = widget.moods[index].mood * 100;
          return HomeWidgetsEnclosure(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mood: ${fmood.toStringAsFixed(2)}%', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
              Text('Note: ${widget.moods[index].note??'No note'}'),
              Text('Date: ${widget.moods[index].date.toString().substring(0, 16)}'),
              const SizedBox(height: 10,),
             SizedBox(
               width: double.infinity,
               child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(flex: 1,
                      child: Text('🥲', style: TextStyle( fontSize: 24),)),
                  Expanded(
                    flex: 6,
                    child:  LinearProgressIndicator(
                      value: widget.moods[index].mood,
                      backgroundColor: Colors.grey,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(10),
                      valueColor: AlwaysStoppedAnimation<Color>(MoodCalculator.calculateMoodColor(widget.moods[index].mood))),),
                  const Flexible(flex: 1,
                      child: Text('😃', style: TextStyle( fontSize: 24))),
                ],
              ),
             ),

            ],
          ));
        },
      )
    );
  }
}