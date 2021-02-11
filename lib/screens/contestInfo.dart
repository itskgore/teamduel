import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/providers/stateMangedHorseMegaLeague.dart';
import 'package:winx/screens/infoDistribution.dart';
import 'package:winx/widgets/infoRaceList.dart';
import 'package:winx/widgets/infoRules.dart';

class ContestInfo extends StatelessWidget {
  var items1;
  var items2;
  ContestInfo({Key key, this.items1, this.items2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBarHome(context, 'Contest Info'),
        body: SafeArea(
          child: Container(
              child: Consumer<HorseMegaLeagueStates>(
            builder: (con, state, _) => Column(children: [
              buildSizedBox(buildHeight(context), 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => state.setPayment('distribution'),
                      child: AnimatedOpacity(
                        duration: Duration(seconds: 1),
                        opacity: state.info['type'] == 'distribution' ? 1 : 0.6,
                        child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(2),
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: state.info['type'] == 'distribution'
                                      ? Colors.green
                                      : Colors.grey,
                                  width: state.info['type'] == 'distribution'
                                      ? 2
                                      : 1),
                            ),
                            child: Text('Prize Distribution')),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => state.setPayment('race_list'),
                      child: AnimatedOpacity(
                        duration: Duration(seconds: 1),
                        opacity: state.info['type'] == 'race_list' ? 1 : 0.6,
                        child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(2),
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: state.info['type'] == 'race_list'
                                      ? Colors.green
                                      : Colors.grey,
                                  width: state.info['type'] == 'race_list'
                                      ? 2
                                      : 1),
                            ),
                            child: Text('Race List')),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => state.setPayment('rules'),
                      child: AnimatedOpacity(
                        duration: Duration(seconds: 1),
                        opacity: state.info['type'] == 'rules' ? 1 : 0.6,
                        child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(2),
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: state.info['type'] == 'rules'
                                      ? Colors.green
                                      : Colors.grey,
                                  width: state.info['type'] == 'rules' ? 2 : 1),
                            ),
                            child: Text('Contest Rules')),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: state.info['type'] == 'rules'
                    ? InfoRules()
                    : state.info['type'] == 'race_list'
                        ? InfoRaceList(
                            info: items2,
                          )
                        : state.info['type'] == 'distribution'
                            ? InfoDistribution(
                                prize: items1,
                              )
                            : Container(),
              )
            ]),
          )),
        ));
  }
}
