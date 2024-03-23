import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:game_21_ui/components/basic_button.dart';
import 'package:game_21_ui/components/basic_radio_buttons.dart';
import 'package:game_21_ui/components/neu_container.dart';
import 'package:game_21_ui/models/game.dart';
import 'package:game_21_ui/pages/two_player_page.dart';
import 'package:game_21_ui/pages/game_page.dart';
import 'package:game_21_ui/themes/dark_theme.dart';
import 'package:game_21_ui/themes/light_theme.dart';
import 'package:provider/provider.dart';

/*
  Displays the difficulty mode as well as title if there are no previous winners otherwise it displays the winner's name as well as the score history.
  
  Works like so:
    Changes the difficulty through gameEngine.robot and passes the ai function relating to the difficulty.
    When play is pressed it checks whether the difficulty is set to 2 players if so it will push the TwoPlayerGame page otherwise it will Push the GamePage and runs gameEngine.startGame().
    Lastly it keeps track of what difficulty was previously selected through the difficulty variable.
*/

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String difficulty = 'easy robot';

  @override
  Widget build(BuildContext context) {
    final Game21Engine gameEngine = Provider.of<Game21Engine>(context);
    final ColorScheme theme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: ThemeSwitcher.withTheme(
                      builder: (p0, switcher, theme) {
                        return IconButton(
                          onPressed: () {
                            switcher.changeTheme(
                              theme: theme.brightness == Brightness.light
                                  ? darkTheme
                                  : lightTheme,
                            );
                          },
                          icon: const Icon(Icons.brightness_3, size: 25),
                        );
                      },
                    ),
                  ),

                  // shows title if there are winners otherwise shows the scores
                  gameEngine.winnerName == null
                      ? Column(
                          // shows the title when no games have been played
                          children: [
                            Text(
                              '21',
                              style: TextStyle(
                                  color: theme.primary, fontSize: 100),
                            ),
                            Text(
                              'Game',
                              style: TextStyle(
                                  color: theme.primary, fontSize: 100),
                            ),
                            Text(
                              'Made by: Zappy',
                              style: TextStyle(color: theme.onBackground),
                            )
                          ],
                        )
                      : Column(
                          // Shows the winner and score history.
                          children: [
                            Text(
                              gameEngine.winnerName!,
                              style: TextStyle(
                                  color: theme.primary, fontSize: 100),
                            ),
                            Text(
                              'WON',
                              style: TextStyle(
                                  color: theme.primary, fontSize: 100),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Wins: ${gameEngine.scoreHistory['user']!.toString()}',
                                  style: TextStyle(
                                      color: theme.onBackground, fontSize: 30),
                                ),
                                Text(
                                  'Loses: ${gameEngine.scoreHistory['robot']!.toString()}',
                                  style: TextStyle(
                                      color: theme.onBackground, fontSize: 30),
                                )
                              ],
                            )
                          ],
                        ),
                ],
              ),
              Column(
                // Difficulty selector.
                children: [
                  NeumorphicContainer(
                    // To make the button seem less prominent.
                    highlightSize: 1,
                    shadowSize: 1,
                    blurRadius: 3,
                    child: BasicRadioButtons(
                      // Border radius set to 10 so that it looks like the outer radius and inner radius are the same distance throughout.
                      borderRadius: BorderRadius.circular(10),
                      innerButtonRadius: BorderRadius.circular(10),
                      selectedColor: theme.surfaceVariant,
                      selectedValue: difficulty,
                      buttons: [
                        RadioButtonData(
                            value: 'easy robot',
                            text: Text(
                              'Easy',
                              style:
                                  TextStyle(fontSize: 50, color: theme.primary),
                            ),
                            onPressed: () {
                              gameEngine.newRobot = Robots.randomBot;
                              difficulty = 'easy robot';
                            }),
                        RadioButtonData(
                            value: 'hard robot',
                            text: Text(
                              'Hard',
                              style:
                                  TextStyle(fontSize: 50, color: theme.primary),
                            ),
                            onPressed: () {
                              gameEngine.newRobot = Robots.impossibleBot;
                              difficulty = 'hard robot';
                            }),
                        RadioButtonData(
                            value: '2 player mode',
                            text: Text(
                              '2P',
                              style:
                                  TextStyle(fontSize: 50, color: theme.primary),
                            ),
                            onPressed: () {
                              difficulty = '2 player mode';
                            })
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                  // Play button.
                  NeumorphicContainer(
                    // Made to have the button seem more elevated than the rest.
                    highlightSize: 3,
                    shadowSize: 3,
                    color: theme.tertiary,
                    child: BasicButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  difficulty == '2 player mode'
                                      ? const TwoPlayerGame()
                                      : const GamePage()),
                        );
                        gameEngine.startGame();
                      },
                      child: Text(
                        'Play',
                        style: TextStyle(fontSize: 75, color: theme.onTertiary),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
