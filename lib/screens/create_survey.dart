import 'package:edu_pulse/models/survey.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/question.dart';
import '../services/survey_services.dart';

class CreateSurveyScreen extends StatefulWidget {
  const CreateSurveyScreen({Key? key}) : super(key: key);

  @override
  _CreateSurveyScreenState createState() => _CreateSurveyScreenState();
}

class _CreateSurveyScreenState extends State<CreateSurveyScreen> {


  final TextEditingController _surveyTitleController = TextEditingController();
  final TextEditingController _surveyDescriptionController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _LowValueController = TextEditingController();
  final TextEditingController _HighValueController = TextEditingController();
  final TextEditingController _QuestionTextController = TextEditingController();

  //create controllers for the options as a list and fill with text editing controllers
  final List<TextEditingController> _optionControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  List<Question> _questions = [
  ];

  String questionType = '';

  bool isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a survey'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: !isLoading?SizedBox(height: 10,):LinearProgressIndicator(
            backgroundColor: Colors.white,
            color: Colors.amber,
            minHeight: 10,
            borderRadius: BorderRadius.circular(10),
          ),
        )
      ),
      body: Padding(padding: EdgeInsets.all(10), child:
      ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _surveyTitleController,
            decoration: _buildInputDecoration('Survey title')
          ),
          _buildGap(),
          TextField(
            minLines: 3,
            maxLines: 5,
            controller: _surveyDescriptionController,
            decoration: _buildInputDecoration('Survey description')
          ),
          const SizedBox(height: 10,),
          Text('Questions: ${_questions.length}', style: GoogleFonts.abel(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey
          ),),
          _buildGap(),
          // ElevatedButton(onPressed: _buildAddQuestionBottomModalSheet,
          //     child: const Text('Add question')),
          GestureDetector(
            onTap: _buildAddQuestionBottomModalSheet,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(child: Text('Add question', style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),)),
            ),
          ),

          const SizedBox(height: 10,),
          GestureDetector(
            onTap: handleSubmission,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(child: Text('Submit', style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),)),
            ),
          )
        ],
      ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildGap() {
    return const SizedBox(height: 10,);
  }

  _buildAddQuestionBottomModalSheet() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context, builder: (context) {
      return StatefulBuilder(builder: (context, setState) =>
          Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery
                .of(context)
                .size
                .height * 0.9,
            width: double.infinity,
            child: Column(
              children: [
                // const Padding(padding: EdgeInsets.all(10),child: Text('Add a question', style: TextStyle(
                //   fontSize: 20,
                //   fontWeight: FontWeight.bold,
                // ),),
                // ),

                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: const Text('Add a question'),
                  actions: [
                    IconButton(onPressed: () {
                      Navigator.pop(context);
                      reset();
                    }, icon: const Icon(Icons.close))
                  ],
                ),
                //input field to choose question type
                FormField(builder: (FormFieldState state) {

                  return DropdownButtonFormField(
                    decoration: _buildInputDecoration('Question type'),

                    items: const [
                      DropdownMenuItem(child: Text('Multiple choice'),
                        value: 'multipleChoice',),
                      DropdownMenuItem(child: Text('Open Ended'),
                        value: 'openEnded',),
                      DropdownMenuItem(child: Text('Linear scale'),
                        value: 'range',),
                    ],
                    onChanged: (value) {
                      setState(() {
                        questionType = value!;
                      });
                    },
                  );
                },),
                _buildGap(),

                TextField(
                  minLines: 3,
                  maxLines: 5,
                  controller: _questionController,
                  decoration: _buildInputDecoration('Question text'),
                ),

                _buildGap(),

                if(questionType == 'multipleChoice')...[

                  TextField(
                    controller: _optionControllers[0],
                    decoration: const InputDecoration(
                      hintText: 'Option 1',
                    )
                  ),
                  _buildGap(),
                  TextField(
                    controller: _optionControllers[1],
                    decoration: const InputDecoration(
                      hintText: 'Option 2',
                    )
                  ),
                  _buildGap(),
                  TextField(
                    controller: _optionControllers[2],
                    decoration: const InputDecoration(
                      hintText: 'Option 3',
                    )
                  ),
                  _buildGap(),
                  TextField(
                    controller: _optionControllers[3],
                    decoration: const InputDecoration(
                      hintText: 'Option 4',
                    ),
                  ),
                  _buildGap(),
                  TextField(
                    controller: _optionControllers[4],
                    decoration: const InputDecoration(
                      hintText: 'Option 5',
                    ),
                  ),
                  _buildGap(),
                  TextField(
                    controller: _optionControllers[5],
                    decoration: const InputDecoration(
                      hintText: 'Option 6',
                    ),
                  ),
                  _buildGap(),
                ],
                if(questionType == 'openEnded')...[

                ],
                if(questionType == 'range')...[

                  TextField(
                    controller: _LowValueController,
                    decoration: const InputDecoration(
                      hintText: 'Low value meaning',
                    )
                  ),
                  _buildGap(),
                  TextField(
                    controller: _HighValueController,
                    decoration: const InputDecoration(
                      hintText: 'High value meaning',
                    )
                  ),
                ],


                const Spacer(),
                const SizedBox(height: 10,),
                //ElevatedButton(onPressed: addQuestion, child: const Text('Add ')),
                GestureDetector(
                  onTap: addQuestion,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(child: Text('Add', style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),)),
                  ),
                )

              ],
            ),
          ),
      );
    });
  }

  void handleSubmission() async{

    setState(() {
      isLoading = true;
    });

    //create a survey object
    Survey survey = Survey(
      title: _surveyTitleController.text,
      description: _surveyDescriptionController.text,
    );

    //submit survey to firestore
    String surveyId = await SurveyService.createSurvey(survey);

    //submit questions to firestore
    await SurveyService.addQuestionsToSurvey(surveyId, _questions);

    setState(() {
      isLoading = false;
    });

    cleanUp();

    //show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Survey created successfully')));

  }

  void cleanUp() {
    _questions.clear();
    _surveyTitleController.clear();
    _surveyDescriptionController.clear();
    questionType = '';
    for (int i = 0; i < _optionControllers.length; i++) {
      _optionControllers[i].clear();
    }
  }

  void reset() {
    _questionController.clear();
    for (int i = 0; i < _optionControllers.length; i++) {
      _optionControllers[i].clear();
    }
    questionType = '';
  }

  void addQuestion() {
    if (questionType == 'multipleChoice') {

      List<String> options = _optionControllers.map((e) => e.text).toList();
      //remove empty options
      options.removeWhere((element) => element.isEmpty);

      _questions.add(Question(text: _questionController.text,
          type: questionType,
          options: options));
    }
    else if (questionType == 'openEnded') {
      _questions.add(
          Question(text: _questionController.text, type: questionType));
    }
    else if (questionType == 'range') {
      _questions.add(Question(text: _questionController.text,
          type: questionType,
          options: [_LowValueController.text, _HighValueController.text]));
    }
setState(() {

});
    reset();
    Navigator.pop(context);
  }




}