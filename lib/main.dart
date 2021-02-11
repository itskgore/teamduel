import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winx/providers/cricketStates.dart';
import 'package:winx/providers/horse.dart';
import 'package:winx/providers/matchUps.dart';
import 'package:winx/providers/stateMangedHorseMegaLeague.dart';
import 'package:winx/providers/user.dart';
import 'package:winx/providers/auth.dart';
import 'package:winx/screens/changePassScreen.dart';
import 'package:winx/screens/cricket/megaLeague/cricketHomeScreen.dart';
import 'package:winx/screens/homeScreen.dart';
import 'package:winx/screens/loginScreen.dart';
import 'package:winx/screens/myProfile.dart';
import 'package:winx/screens/onBoardingScreen.dart';
import 'package:winx/screens/raceMeets.dart';
import 'package:winx/screens/splashScreen.dart';
import 'package:winx/screens/timer.dart';

import 'screens/cricket/matchups/matchUpsHome.dart';
import 'screens/cricket/matchups/myMatchUps.dart';
import 'screens/cricket/matchups/myPlayerInfo.dart';
import 'screens/cricket/megaLeague/playersLeaderBoard.dart';
import 'screens/cricket/megaLeague/teams.dart';
import 'screens/emailVeriScreen.dart';
import 'screens/getTransactionHistory.dart';
import 'screens/pickHorseScreen.dart';
import 'styles/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Future<void> _isLogin(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: CricketStates()),
        ChangeNotifierProvider.value(value: HorseMegaLeagueStates()),
        ChangeNotifierProxyProvider<Auth, User>(
          create: (_) => User(),
          update: (_, auth, products) => products..upate(auth),
        ),
        ChangeNotifierProxyProvider<Auth, HorseProvider>(
          create: (_) => HorseProvider(),
          update: (_, auth, horse) => horse..upate(auth),
        ),
        ChangeNotifierProxyProvider<HorseProvider, HorseMegaLeagueStates>(
          create: (_) => HorseMegaLeagueStates(),
          update: (_, horseprovider, horsestate) =>
              horsestate..upate(horseprovider),
        ),
        ChangeNotifierProxyProvider<Auth, MatchupsCrickets>(
          create: (_) => MatchupsCrickets(),
          update: (_, auth, cricketMatchups) => cricketMatchups..upate(auth),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TURF',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Consumer<Auth>(
            builder: (context, auth, _) => FutureBuilder(
                  future: auth.isLogin(),
                  builder: (ctx, snap) {
                    print(snap.data);
                    if (snap.connectionState == ConnectionState.waiting) {
                      return SplashScreen();
                    }
                    if (snap.connectionState == ConnectionState.done) {
                      if (snap.data) {
                        return MatchUpHome();
                      } else {
                        return OnboardingScreen();
                      }
                    }
                  },
                )),
      ),
    );
  }
}
