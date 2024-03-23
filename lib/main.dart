import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_21_ui/pages/home_page.dart';
import 'package:game_21_ui/themes/dark_theme.dart';
import 'package:provider/provider.dart';
import 'models/game.dart';

/* 
  This app was made to practice flutter (this is my first flutter app before i just followed tutorials to get a sense of how things are supposed to be done and a few tips and tricks)
  I didnt plan this ahead of time because i assumed it would be quick and easy but that has ended up horribly i will never make that mistake again.

  The project is organized like so:
  gameEngine stores all the functions and variables needed for everything except the theme which is provided through ThemeProvider. 
  HomePage stores settings and if play is pressed it takes you to GamePage or TwoPlayerGame if the 2 player mode is selected.
  GamePage just has buttons and pressing them will run a command to gameEngine which then updates the ui.
  TwoPlayerGame is similar to GamePage except it doesnt use gameEngine except to override the winnerName variable since the two player game's names are different. 
  
  Also the TwoPlayerGame was originally planned to be added otherwise i wouldve made GamePage less hard coded so that i would be able to use the same page for both game modes.
  Once again the project was horribly planned and everything is a mess after some point i just wanted to finish the app soon because i didnt want this to take a week and that has probably led to even worse code.
*/
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(ChangeNotifierProvider(
      create: (_) => Game21Engine(), child: const Game21()));
}

class Game21 extends StatelessWidget {
  const Game21({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
        // For theme switch animation.
        initTheme: darkTheme,
        builder: (_, myTheme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(),
            theme: myTheme,
          );
        });
  }
}
