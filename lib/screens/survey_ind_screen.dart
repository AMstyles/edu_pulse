import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_pulse/models/color_palette.dart';
import 'package:edu_pulse/models/survey.dart';
import 'package:edu_pulse/screens/survey%20responses.dart';
import 'package:edu_pulse/services/local_user_provider.dart';
import 'package:edu_pulse/services/survey_services.dart';
import 'package:edu_pulse/widgets/question%20enclosure.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/question.dart';

class IndivSurveyScreen extends StatefulWidget {
  const IndivSurveyScreen({Key? key, required this.survey}) : super(key: key);

  final Survey survey;

  @override
  _IndivSurveyScreenState createState() => _IndivSurveyScreenState();
}

class _IndivSurveyScreenState extends State<IndivSurveyScreen> {

  int _currentPart = 0;
  List<Map<String, dynamic>> userResponses = [];
  late final Future<List<Question>> questions ;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    questions = SurveyService.getQuestions(widget.survey.surveyId!);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: _currentPart==1?FloatingActionButton(
        onPressed: submitSurvey,
        child: const Icon(Icons.send),
      ):null,

      appBar: AppBar(
        title: Text(widget.survey.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child:
            _isLoading?const LinearProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(ColorPalette.primaryAccent),

            ):const SizedBox(height: 10,),


        )
      ),
      body:_currentPart==0? _buildOverview():_buildRespond(),
    bottomNavigationBar: BottomAppBar(
      child: Column(
        children: [
          SizedBox(
            height: 3,
        width: double.infinity,
          child: Stack(
            children: [
              AnimatedAlign(
                  alignment: _currentPart==0?Alignment.centerLeft:Alignment.centerRight,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    height: 5,
                    width: MediaQuery.of(context).size.width/3.5,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: Color.fromARGB(180, 255, 250, 250),
                        //add box shadow to make it glow
                        boxShadow: [
                          BoxShadow(
                            color: ColorPalette.primaryAccent,
                            blurRadius: 5,
                            spreadRadius: 2,
                            offset: Offset(0, 2),
                          )
                        ]
                    ),

                  ),
                ),

      BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 200, sigmaY: 1000),
      ),


            ],
          ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: (){
                  setState(() {
                    _currentPart = 0;
                  });
                },
                child: const Text("Overview"),
              ),
              TextButton(
                onPressed: (){
                  setState(() {
                    _currentPart = 1;
                  });
                },
                child: const Text("Respond"),
              ),
            ],
          ),
        ],
      )
    )
    );
  }

  //TODO: build overview page
  Widget _buildOverview(){
    return ListView(
      padding: const EdgeInsets.all(10),
      //write decorated description here
      children: [
        Text(
          widget.survey.description,
          style: GoogleFonts.abel(
            color: Colors.blueGrey,
            fontSize: 20,
            fontWeight: FontWeight.normal
          ),
        ),

        //do estimated time here
        const SizedBox(height: 10,),
        Text(
          'Estimated time: 10 minutes',
          style: GoogleFonts.abel(
            color: Colors.blueGrey,
            fontSize: 20,
            fontWeight: FontWeight.normal
          ),

         ),

        //put disclaimers and policies here
        const SizedBox(height: 10,),
        Text(
          'Disclaimer: This survey is for research purposes only. Your responses will be kept confidential and will not be shared with anyone. Your participation is voluntary and you may choose not to participate.',
          style: GoogleFonts.abel(
            color: Colors.blueGrey,
            fontSize: 20,
            fontWeight: FontWeight.normal
          ),
        ),

        const SizedBox(height: 10,),
        Text(
          'If you\'ve previously completed this survey, only your latest response is kept. You can complete the survey at any time you have different opinions.' ,
          style: GoogleFonts.abel(
              color: Colors.redAccent,
              fontSize: 20,
              fontWeight: FontWeight.normal
          ),
        ),

        //create a button to start the survey using a gesture detector and a container with a gradient
        const SizedBox(height: 10,),
        GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SurveyResponseScreen(survey: widget.survey,)));
          },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [
                  ColorPalette.primary,
                  ColorPalette.primaryAccent,
       ]
    ),
    ),
                  child: Center(
    child: Text(
    'View Responses',
    style:
    GoogleFonts.abel(fontSize: 26,color: Colors.white, fontWeight: FontWeight.bold),
    ),
    )
    )),
        const SizedBox(height: 10,),
        GestureDetector(
            onTap: (){
              setState(() {
                _currentPart = 1;
              });
            },
            child: Container(
              height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                      colors: [
                        ColorPalette.secondary,
                        ColorPalette.secondaryAccent,
                      ]
                  ),
                ),
              child: Center(
                child: Text(
                  'Start Survey',
                  style:
                  GoogleFonts.abel(fontSize: 26,color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            )),
      ],
    );
  }

  //TODO: build respond page
  Widget _buildRespond(){
    return FutureBuilder(
        future: questions,
        builder: (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
          if(snapshot.hasData){
            return buildSurveyUI(snapshot.data!);
          }
          else{
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
    );
  }

  Widget buildSurveyUI(List<Question> questions) {
    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (context, index) {
        return buildQuestionUI(questions[index]);
      },
    );
  }

  Widget buildQuestionUI(Question question) {
    switch (question.type) {
      case 'multipleChoice':
        return QuestionEnclosure(child: buildMultipleChoiceQuestion(question));
      case 'range':
        return QuestionEnclosure(child:buildRangeQuestion(question));
      case 'openEnded':
        return QuestionEnclosure(child:buildOpenEndedQuestion(question));
      default:
        return Container(); // Handle other question types as needed
    }
  }

  Widget buildMultipleChoiceQuestion(Question question) {
    return StatefulBuilder(builder: (context, setState)=>Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question.text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Column(
          children: question.options!.map((option) {
            return RadioListTile(
              title: Text(option),
              value: option,
              groupValue: userResponses
                  .firstWhere((response) => response['questionId'] == question.questionId,
                  orElse: () => {'selectedOption': ''})
              ['selectedOption'],
              onChanged: (value) {
                setState(() {
                  userResponses.removeWhere((response) => response['questionId'] == question.questionId);
                  userResponses.add({'questionId': question.questionId,'text':question.text, 'selectedOption': value, 'type': 'multipleChoice'});
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    ),
    );
  }

  Widget buildRangeQuestion(Question question) {
    double sliderValue = 2.5; // Default value or midpoint of the range

    return StatefulBuilder(builder: (context, setState)=>Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question.text, style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('0'),
            Expanded(
              child: Slider(
                value: sliderValue,
                min: 0,
                max: 5,
                divisions: 5,
                onChanged: (value) {
                  setState(() {
                    sliderValue = value;
                    userResponses.removeWhere((response) => response['questionId'] == question.questionId);
                    userResponses.add({'questionId': question.questionId, 'rangeResponse': value, 'type': 'range'});
                  });

                },
              ),
            ),
            const Text('5'),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(question.options!.first),
            Text(question.options!.last),
          ],
        ),
      ],
    ),
    );
  }

  Widget buildOpenEndedQuestion(Question question) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question.text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        TextField(
          onChanged: (value) {
              userResponses.removeWhere((response) => response['questionId'] == question.questionId);
              userResponses.add({'questionId': question.questionId, 'textResponse': value, 'type': 'openEnded'});
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void submitSurvey() async {
    setState(() {
      _isLoading = true;
    });

      await SurveyService.submitSurvey(
          widget.survey.surveyId!, userResponses, Provider
          .of<UserProvider>(context, listen: false)
          .user!
          .email);

    //TODO: show success message as a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         showCloseIcon: true,
          onVisible: ()=>{
            HapticFeedback.lightImpact(),
          },
           elevation: 10,
          backgroundColor: ColorPalette.primary,
            content:const Text('Survey submitted successfully', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
        )
    );

    setState(() {
      _isLoading = false;
    });
  }
}

/*
 response to a question:
 {
  'questionId': '1234',
  'text': 'some question text',
  'selectedOption': 'option1', //for multiple choice
  'textResponse': 'some text', //for open ended
  'rangeResponse': 3.5, //for range
  'type': 'multipleChoice' // or 'range' or 'openEnded'
 }

 */