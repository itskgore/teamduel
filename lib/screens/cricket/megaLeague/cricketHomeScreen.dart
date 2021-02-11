import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/providers/cricketStates.dart';
import 'package:winx/widgets/cricket/megaLeague/completed.dart';
import 'package:winx/widgets/cricket/megaLeague/joined.dart';
import 'package:winx/widgets/cricket/megaLeague/lobby.dart';

class CricketHomeScreen extends StatefulWidget {
  CricketHomeScreen({Key key}) : super(key: key);

  @override
  _CricketHomeScreenState createState() => _CricketHomeScreenState();
}

class _CricketHomeScreenState extends State<CricketHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final states = Provider.of<CricketStates>(context);
    return Column(
      children: <Widget>[
        buildSizedBox(buildHeight(context), 0.03),
        Container(
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 50),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffbe3e3e3)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              sections("Lobby", states.section == Sections.lobby, context,
                  Sections.lobby),
              sections("Joined", states.section == Sections.joined, context,
                  Sections.joined),
              sections("Completed", states.section == Sections.completed,
                  context, Sections.completed),
            ],
          ),
        ),
        buildSizedBox(buildHeight(context), 0.02),
        states.section == Sections.lobby
            ? Lobby()
            : states.section == Sections.joined ? Joint() : Completed()
      ],
    );
  }

  Widget sections(
      String title, bool isActive, BuildContext context, Sections data) {
    return Consumer<CricketStates>(
      builder: (context, state, _) => Expanded(
        child: GestureDetector(
          onTap: () {
            state.changeSection(data);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeIn,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                color: isActive ? Colors.white : const Color(0xffbe3e3e3),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              "$title",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: isActive ? AppColors.mainColor : Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
