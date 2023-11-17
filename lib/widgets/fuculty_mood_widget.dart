import 'package:edu_pulse/services/local_storage_services.dart';
import 'package:edu_pulse/services/local_user_provider.dart';
import 'package:edu_pulse/services/mood_service.dart';
import 'package:edu_pulse/widgets/home_widgets_enclosure.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';

import '../models/local_user.dart';
import '../models/mood.dart';
import '../screens/MoodsDetails.dart';

class FacultyMoodWidget extends StatefulWidget {
  FacultyMoodWidget({Key? key}) : super(key: key);

  @override
  State<FacultyMoodWidget> createState() => _FacultyMoodWidgetState();
}

class _FacultyMoodWidgetState extends State<FacultyMoodWidget> {

  List<String> facultyOptions = [
   'Science',
    'Engineering',
    'Health Sciences',
    'Humanities',
    'Commerce, Law & Management',
    'Other'
  ];

  late String selectedFaculty = 'Science';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocalStorage.readUserFromLocalStorage().then((LocalUser? user) {
      Provider.of<UserProvider>(context, listen: false).setUser(user!);
      setState(() {
        selectedFaculty = user.faculty;
      });

    });
  }

  @override
  Widget build(BuildContext context) {

    return SliverToBoxAdapter(
      child: HomeWidgetsEnclosure(
        child: FutureBuilder(
          future:MoodService.getMoodsByFaculty(selectedFaculty),
          builder: (BuildContext context, AsyncSnapshot<List<Mood>> snapshot) {
            if(snapshot.hasData){
              double averageMood = Mood.getAverageMood(snapshot.data!);
              List<Mood> moods = snapshot.data!;
              if(moods.isEmpty){
                averageMood = 0.5;
              }
              else{
                averageMood = Mood.getAverageMood(moods);
              }

              //get percentage of the average moood rounded to the nearest 2 decimal places
              double perAverageMood = double.parse((averageMood*100).toStringAsFixed(2));


              return  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedFaculty,
                        style:  GoogleFonts.abel(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                      if(!Provider.of<UserProvider>(context).user!.isStudent)PopupMenuButton(
                        itemBuilder: (BuildContext context) {
                        return facultyOptions.map((String option) {
                          return PopupMenuItem(
                            onTap: (){
                              setState(() {
                                selectedFaculty = option;
                                // moods = MoodService.getMoodsByFaculty(option);
                              });
                            },
                            value: option,
                            child: Text(option),
                          );
                        }).toList();
                      }, child: const Icon(Icons.more_horiz, color: Colors.blueGrey,),)
                    ],
                  ),

                  Row(
                    children: [
                      Flexible(flex:1,child: Image.asset('lib/images/mood_sad.png')),
                      Flexible(
                        flex: 3,
                        child: LinearProgressIndicator(
                          semanticsLabel: 'Linear progress indicator',
                          minHeight: 20,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          backgroundColor: Colors.greenAccent,
                          valueColor: AlwaysStoppedAnimation(Colors.green),
                          value:averageMood,
                        ),

                      ),
                      Flexible(flex:1,child: Image.asset('lib/images/mood_happy.png')),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('This is the average satisfaction level faculty', style: GoogleFonts.abel(fontSize: 14, color: Colors.blueGrey),),
                      Text('$perAverageMood %', style: GoogleFonts.abel(fontSize: 14, color: Colors.blueGrey),),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: ()=>{}, child: Text('Log your mood', style: GoogleFonts.abel(fontSize: 14, color: Colors.blueGrey),),),
                      if(!Provider.of<UserProvider>(context).user!.isStudent)
                      TextButton(onPressed: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MoodsDetails(moods: snapshot.data!))),
                      }, child: Text('See why', style: GoogleFonts.abel(fontSize: 14, color: Colors.blueGrey),),)
                    ],
                  )



                ],
              );
            }
            else{
              return const Center(child: CircularProgressIndicator.adaptive());
            }
          },
        )

      ),
    );
  }
}