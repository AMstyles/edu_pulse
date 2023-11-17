import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:edu_pulse/models/color_palette.dart';
import 'package:edu_pulse/screens/create_survey.dart';
import 'package:edu_pulse/services/local_storage_services.dart';
import 'package:edu_pulse/services/local_user_provider.dart';
import 'package:edu_pulse/widgets/drawer.dart';
import 'package:edu_pulse/widgets/home_widgets_enclosure.dart';
import 'package:edu_pulse/widgets/mood_log_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/fuculty_mood_widget.dart';
import '../widgets/homeUserWidget.dart';
import '../widgets/mood_widget.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  final ScrollController _scrollController = ScrollController();
  double _blur = 0;
  bool isFabExpanded = true;
  List<String> messages = [
    'Welcome back to Edu Pulse',
    'Share your thoughts',
    'Share your experiences',
    'Help us help you',
    'We\'re stronger together😊',
  ];

  late Color color = Theme.of(context).scaffoldBackgroundColor;

  void handleScroll(double position) {
    if (position > 90) {
      setState(() {
        _blur = 10;
        color = Colors.white;
        isFabExpanded = false;

      });
    } else {
      setState(() {
        _blur = 0;
        color = Theme.of(context).scaffoldBackgroundColor;
        isFabExpanded = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      handleScroll(_scrollController.position.extentBefore);
    });

    LocalStorage.readUserFromLocalStorage().then((value) {
      if(value!=null) {
        Provider.of<UserProvider>(context, listen: false).setUser(value!);
      }
    });
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      floatingActionButton: Provider.of<UserProvider>(context, listen: false).user!.isStudent?null:
      FloatingActionButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const CreateSurveyScreen())),child: const FaIcon(FontAwesomeIcons.plus),),
        body:CustomScrollView(
            controller: _scrollController,
            slivers: [
        SliverAppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
      pinned: true,
      title:AnimatedTextKit(
        repeatForever: true,
        pause: const Duration(seconds: 5),
        animatedTexts: messages.map((e) => TypewriterAnimatedText(
          e,
          textStyle: GoogleFonts.roboto(
              fontSize: 14, color: Colors.blueGrey),
          speed: const Duration(milliseconds: 100),
        )).toList(
        ),
      ),
      leading: Builder(
        builder: (context) => IconButton(
          icon:
         const  FaIcon(
            FontAwesomeIcons.bars,
            color: ColorPalette.secondary,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),),
      actions: [
        IconButton(
          onPressed: () {
            //showSearch(context: context, delegate: QuestionSearchDelegate());
          },
          icon: const Icon(
            FontAwesomeIcons.magnifyingGlass,
            color: Colors.blueGrey,
          ),
        ),
      ],
      centerTitle: true,
      expandedHeight: 80 + 60,
      flexibleSpace: SizedBox(
        height: 200,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: _blur, sigmaY: _blur),
            child: FlexibleSpaceBar(

              background: HomeUserWidget(),
            ),
          ),
        ),
      ),
    ),

              //todo: add mood widget
              const MoodWidget(),
              FacultyMoodWidget(),
              MoodLogWidget(),
              const SliverToBoxAdapter(child:SizedBox(height: 300,)),
      ],
        ),



      drawer: DrawerWidget(),
    );
  }
}