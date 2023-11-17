import 'package:edu_pulse/models/color_palette.dart';
import 'package:edu_pulse/screens/survey_ind_screen.dart';
import 'package:edu_pulse/services/survey_services.dart';
import 'package:edu_pulse/widgets/drawer.dart';
import 'package:flutter/material.dart';

import '../models/survey.dart';

class SurveyPage extends StatefulWidget{
  const SurveyPage({super.key});

  @override
  State<StatefulWidget> createState() => _SurveyPageState();

}

class _SurveyPageState extends State<SurveyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.secondary,
        title: const Text("Surveys"),
      ),
      body: FutureBuilder(
        future: SurveyService.getSurveys(),
        builder: (BuildContext context, AsyncSnapshot<List<Survey>> snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  style: ListTileStyle.drawer,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>IndivSurveyScreen(survey: snapshot.data![index],)));
                  },
                  title: Text(snapshot.data![index].title),
                  subtitle: Text(snapshot.data![index].description),
                );
              },
            );
          }
          else{
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }
}