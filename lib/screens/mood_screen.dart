import 'package:edu_pulse/screens/home_screen.dart';
import 'package:edu_pulse/services/mood_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' as rive;
import '../models/color_palette.dart';
import '../models/mood.dart';
import '../services/local_user_provider.dart';
import '../utilities/mood_calculator.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  _MoodScreenState createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {


  rive.SMIInput<double>? _input;
  rive.StateMachineController? controller;
  double val = 0;

  void _onRiveInit(rive.Artboard artboard) {
  controller =
  rive.StateMachineController.fromArtboard(artboard, 'rate');
  artboard.addController(controller!);
  _input = controller?.findInput<double>('Rating') as rive.SMINumber;
  _input?.change(MoodCalculator.calculateMoodSize(value).toDouble());
  }

  double value = 0.5;
  String mood = 'Neutral';
  Color moodColor = Colors.blue;

  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
              ),
              child:rive.RiveAnimation.asset('lib/animations/mood_rate.riv',
                   fit: BoxFit.cover,
                    onInit: _onRiveInit,
              ),
    ),
            SafeArea(
              
              child:
            Padding( 
              padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tell us how you're feeling today?",
                  style: GoogleFonts.abel(fontSize: 26, color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.bold),),
                Container(
                  child: Column(
                    children: [
                      Text(mood, style: GoogleFonts.abel(color: Colors.white.withOpacity(0.3), fontWeight: FontWeight.bold, fontSize: 40),),
                      //put a slider and a submit button here

                      Slider(
                        value: value,
                        onChanged: (value){
                          String lastMood = mood;
                        setState(() {
                          this.value = value;
                          mood = MoodCalculator.calculateMood(value);
                          moodColor = MoodCalculator.calculateMoodColor(value);
                          _input?.change(MoodCalculator.calculateMoodSize(value).toDouble());
                        });
                        if(lastMood!=mood){
                          //play light vibration
                          HapticFeedback.lightImpact();
                        }
                      },
                      thumbColor: ColorPalette.primaryAccent,
                      activeColor: ColorPalette.primaryAccent,

                      ),
                          GestureDetector(
                            onTap: ()=>{

                             showDialog(
                                 context: context,
                                 builder: (context)=>
                                     AlertDialog(
                                        title: const Text('Why do you feel this way?'),
                                        content:  TextField(
                                          controller: _controller,
                                          decoration:const  InputDecoration(
                                            hintText: 'Enter your thoughts here',
                                            helperText: '*This is optional',
                                            border: OutlineInputBorder()
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed:handleSubmission,
                                              child: const Text('Submit'))
                                        ],
                                     )
                             )
                            },
                            child: AnimatedContainer(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: moodColor.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(20)
                              ),
                              duration: const Duration(milliseconds: 500),
                              child: Text('Submit', style: GoogleFonts.abel(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                            ),
                          )
                    ],
                  ),
                )
              ],
            ),) ,)

          ],
        ),
      ),

    );
  }

  void handleSubmission() async {
    Mood mood = Mood(mood: value, note: _controller.text.trim());
    await MoodService.addMood(mood, Provider.of<UserProvider>(context, listen: false).user!.email);
    //play heavy vibration
    HapticFeedback.heavyImpact();
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
}