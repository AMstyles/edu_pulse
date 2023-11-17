import 'package:edu_pulse/services/local_user_provider.dart';
import 'package:edu_pulse/widgets/home_widgets_enclosure.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';

class FacultyMoodWidget extends StatefulWidget {
  FacultyMoodWidget({Key? key}) : super(key: key);

  @override
  State<FacultyMoodWidget> createState() => _FacultyMoodWidgetState();
}

class _FacultyMoodWidgetState extends State<FacultyMoodWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: HomeWidgetsEnclosure(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  ' ${Provider.of<UserProvider>(context).user!.faculty}',
                  style:  GoogleFonts.abel(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),

            Row(
              children: [
               Flexible(flex:1,child: Image.asset('lib/images/mood_sad.png')),
                 const Flexible(
                  flex: 3,
                  child: LinearProgressIndicator(
                    semanticsLabel: 'Linear progress indicator',
                    minHeight: 20,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    backgroundColor: Colors.greenAccent,
                    valueColor: AlwaysStoppedAnimation(Colors.green),
                  value: 0.5,

                ),

                ),
                Flexible(flex:1,child: Image.asset('lib/images/mood_happy.png')),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Text('This is the average satisfaction level faculty', style: GoogleFonts.abel(fontSize: 14, color: Colors.blueGrey),),
                Text('50%', style: GoogleFonts.abel(fontSize: 14, color: Colors.blueGrey),),
              ],
            ),
            TextButton(onPressed: ()=>{}, child: Text('Log your mood', style: GoogleFonts.abel(fontSize: 14, color: Colors.blueGrey),),)

          ],
        ),
      ),
    );
  }
}