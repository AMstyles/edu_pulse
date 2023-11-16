

import 'package:edu_pulse/models/color_palette.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/local_user.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key, required this.user}) : super(key: key);

  LocalUser user;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final ScrollController _scrollController = ScrollController();
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
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController.addListener(() {
      print(_scrollController.position.extentBefore);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        top: false,
        child:CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: ColorPalette.secondary,
            title: Text(
              'Account',
              style: GoogleFonts.abel(
                 ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Image.asset('lib/images/mood_happy.png', height: 150, width: 150, ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('feeling happy', style: GoogleFonts.abel( ),),
                ],
              ),

                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Name'),
                  subtitle: Text(
                      widget.user.name),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email'),
                  subtitle: Text(widget.user.email??''),
                ),

                //create contributions section

                Padding(padding: const EdgeInsets.all(10), child: Text('Mood Log', style: GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 28, color: ColorPalette.primary),),),
                 SizedBox(
                  height: 400,

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

                const SizedBox(height: 20,
                )
              ],
            ),
          ),
        ],
      ),
      )
    );
  }

}
