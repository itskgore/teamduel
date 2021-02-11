// // HOME SCREEN
// //  Row(
// //                                       children: [
// //                                         Column(
// //                                           children: [
// //                                             Row(
// //                                               children: <Widget>[
// //                                                 Text(
// //                                                   'Prize Money :',
// //                                                   textAlign: TextAlign.left,
// //                                                 ),
// //                                                 buildSizedBoxWidth(
// //                                                     buildWidth(context), 0.01),
// //                                                 Container(
// //                                                   padding: EdgeInsets.all(5),
// //                                                   decoration: BoxDecoration(
// //                                                       color: Theme.of(context)
// //                                                           .accentColor),
// //                                                   child: Text(
// //                                                     '${items.prizeBreakUp[0].prize} R to 1st',
// //                                                     textAlign: TextAlign.left,
// //                                                     style: TextStyle(
// //                                                         color: Colors.white),
// //                                                   ),
// //                                                 ),
// //                                               ],
// //                                             ),
// //                                             buildSizedBox(
// //                                                 buildHeight(context), 0.01),
// //                                             Row(
// //                                               children: <Widget>[
// //                                                 items.totalWinningChips !=
// //                                                         'null'
// //                                                     ? Row(
// //                                                         children: <Widget>[
// //                                                           Text(
// //                                                             '${items.totalWinningChips}',
// //                                                             textAlign:
// //                                                                 TextAlign.left,
// //                                                           ),
// //                                                           SizedBox(
// //                                                             width: 5,
// //                                                           ),
// //                                                           Icon(
// //                                                             FontAwesomeIcons
// //                                                                 .cashRegister,
// //                                                             size: 10,
// //                                                           )
// //                                                         ],
// //                                                       )
// //                                                     : Container(),
// //                                                 SizedBox(
// //                                                   width: 15,
// //                                                 ),
// //                                                 items.totalWinningCoins !=
// //                                                         'null'
// //                                                     ? Row(
// //                                                         children: <Widget>[
// //                                                           Text(
// //                                                             '${items.totalWinningCoins}',
// //                                                             textAlign:
// //                                                                 TextAlign.left,
// //                                                           ),
// //                                                           SizedBox(
// //                                                             width: 5,
// //                                                           ),
// //                                                           Icon(
// //                                                               FontAwesomeIcons
// //                                                                   .cashRegister,
// //                                                               size: 10)
// //                                                         ],
// //                                                       )
// //                                                     : Container(),
// //                                               ],
// //                                             ),
// //                                           ],
// //                                         ),
// //                                         Spacer(),
// //                                         Column(
// //                                           children: [
// //                                             Text(
// //                                               'Winner',
// //                                               textAlign: TextAlign.center,
// //                                             ),
// //                                             buildSizedBox(
// //                                                 buildHeight(context), 0.01),
// //                                             Text(
// //                                               'Top ${items.noWinning}',
// //                                               textAlign: TextAlign.center,
// //                                             ),
// //                                           ],
// //                                         ),
// //                                       ],
// //                                     ),
// Expanded(
//                                       child: Row(
//                                         children: [
//                                           Expanded(
//                                               child: FlatButton(
//                                                   onPressed: () {
//                                                     Navigator.push(
//                                                         context,
//                                                         FadeNavigation(
//                                                             widget:
//                                                                 LeaderBoradMegaContest(
//                                                           appBarTitle:
//                                                               'Racing Contest From 20-June to 25-July',
//                                                         )));
//                                                   },
//                                                   child: Text('LeaderBoard'))),
//                                           Expanded(
//                                               child: FlatButton(
//                                                   onPressed: () {
//                                                     _joinContest(items.id);
//                                                   },
//                                                   child: Text('Join Contest'))),
//                                         ],
//                                       ),
//                                     )
