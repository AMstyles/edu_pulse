import 'package:edu_pulse/widgets/home_widgets_enclosure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/color_palette.dart';

class MoodLogWidget extends StatefulWidget {
  MoodLogWidget({Key? key}) : super(key: key);

  @override
  State<MoodLogWidget> createState() => _MoodLogWidgetState();
}

class _MoodLogWidgetState extends State<MoodLogWidget> {
  var data = {
    DateTime(2023, 11, 6): 3,
    DateTime(2023, 11, 7): 7,
    DateTime(2023, 11, 8): 5,
    DateTime(2023, 11, 9): 3,
    DateTime(2023, 11, 13): 6,
    DateTime(2023, 11, 14): 7,
    DateTime(2023, 11, 15): 5,
    DateTime(2023, 11, 16): 3,
    DateTime(2023, 11, 17): 6,
    DateTime(2023, 11, 18): 7,
    DateTime(2023, 11, 19): 5,
  };
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: HomeWidgetsEnclosure(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recent Mood Journal', style: GoogleFonts.abel(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey),),
            SizedBox(
              height: 340,
              child: HeatMapCalendar(
                colorTipHelper: [
                  Text('sad', style: GoogleFonts.abel(color: Colors.black),),
                  Text('happy', style: GoogleFonts.abel(color: Colors.black),),
                ],
                datasets: data,
                colorMode: ColorMode.opacity,
                colorsets: {
                  0: ColorPalette.primary.withOpacity(0.1),
                  1: ColorPalette.primary.withOpacity(0.2),
                  2: ColorPalette.primary.withOpacity(0.3),
                  3: ColorPalette.primary.withOpacity(0.4),
                  4: ColorPalette.primary.withOpacity(0.5),
                  5: ColorPalette.primary.withOpacity(0.6),
                  6: ColorPalette.primary.withOpacity(0.7),
                  7: ColorPalette.primary.withOpacity(0.8),
                  8: ColorPalette.primary.withOpacity(0.9),
                  9: ColorPalette.primary.withOpacity(1),
                },
                onClick: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
                },
              ),
            ),
          ],

        ),
      )
    );
  }
}