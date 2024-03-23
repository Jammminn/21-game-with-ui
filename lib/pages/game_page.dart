import 'package:flutter/material.dart';
import 'package:game_21_ui/components/basic_button.dart';
import 'package:game_21_ui/components/neu_container.dart';
import 'package:game_21_ui/models/game.dart';
import 'package:provider/provider.dart';

/*
  Runs the game with the selected bot.

  Works like so:
    Gets the engine from provider and uses it to do all the math and gets all the info from it.
    It gets its current total through gameEngine as well as the turn history.
    
    When a button is selected it runs gameEngine.startTurn() with the value that corresponds to the button as a argument.
    gameEngine then updates the widget and the widget displays the new values.
*/

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;

    final Game21Engine gameEngine = Provider.of<Game21Engine>(context);
    // Lets it finish building before popping.
    Future.delayed(Duration.zero, () {
      if (gameEngine.gameFinished) {
        Navigator.pop(context);
      }
    });
    return Scaffold(
      backgroundColor: theme.background,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Current total.
              Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text('Current total:',
                            style: TextStyle(
                                color: theme.onBackground, fontSize: 25)),
                        Text(
                          gameEngine.currentTotal.toString(),
                          style: TextStyle(fontSize: 225, color: theme.primary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Contains the turn info/
                  SizedBox(
                    height: 250,
                    child: NeumorphicContainer(
                      highlightSize: 1,
                      shadowSize: 1,
                      blurRadius: 4,
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    gameEngine.turnInfo.p1Name,
                                    style: TextStyle(
                                        fontSize: 50, color: theme.primary),
                                  ),
                                ),
                                Text(
                                  'Turn: ${gameEngine.turnInfo.p1Turn}',
                                  style: TextStyle(
                                      fontSize: 25, color: theme.onPrimary),
                                ),
                                Text(
                                  'Total: ${gameEngine.turnInfo.p1Total}',
                                  style: TextStyle(
                                      fontSize: 25, color: theme.onPrimary),
                                ),
                                Text(
                                  'Chose: ${gameEngine.turnInfo.p1InputNumber}',
                                  style: TextStyle(
                                      fontSize: 25, color: theme.onPrimary),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            color: theme.outline,
                            height: 240,
                            width: 1,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    gameEngine.turnInfo.p2Name,
                                    style: TextStyle(
                                        fontSize: 50, color: theme.primary),
                                  ),
                                ),
                                Text(
                                  'Turn: ${gameEngine.turnInfo.p2Turn}',
                                  style: TextStyle(
                                      fontSize: 25, color: theme.onPrimary),
                                ),
                                Text(
                                  'Total: ${gameEngine.turnInfo.p2Total}',
                                  style: TextStyle(
                                      fontSize: 25, color: theme.onPrimary),
                                ),
                                Text(
                                  'Chose: ${gameEngine.turnInfo.p2InputNumber}',
                                  style: TextStyle(
                                      fontSize: 25, color: theme.onPrimary),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Rows of buttons 1-3.
              NeumorphicContainer(
                  blurRadius: 4,
                  child: Row(
                    children: [
                      Expanded(
                        child: BasicButton(
                          onPressed: () => gameEngine.startTurn(1),
                          child: Text('1',
                              style: TextStyle(
                                  fontSize: 75, color: theme.primary)),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 100,
                        color: theme.outline,
                      ),
                      Expanded(
                        child: BasicButton(
                          onPressed: () => gameEngine.startTurn(2),
                          child: Text('2',
                              style: TextStyle(
                                  fontSize: 75, color: theme.primary)),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 100,
                        color: theme.outline,
                      ),
                      Expanded(
                        child: BasicButton(
                          onPressed: () => gameEngine.startTurn(3),
                          child: Text('3',
                              style: TextStyle(
                                  fontSize: 75, color: theme.primary)),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
