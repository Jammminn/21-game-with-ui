import 'package:flutter/material.dart';
import 'package:game_21_ui/components/basic_button.dart';
import 'package:game_21_ui/components/neu_container.dart';
import 'package:game_21_ui/models/game.dart';
import 'package:provider/provider.dart';

/*
 Wasnt originally planning to add this which is why it looks horrible.

  Works like so:
    Displays the current total with the currentTotal variable.
    The turn info section shows what the last player picked with the previouslyPicked variable as well as what turn that was with the turnNum variable lastly it shows which player's turn it is in a larger font.

    Everytime a number is pressed it rebuilds the widget with the new information.
    Once the score is over 21 it will save the the player to winnerName and pop the page, this is done in a Future.delayed so that it doesnt pop during a rebuild and only after the rebuild is finished. 
*/

class TwoPlayerGame extends StatefulWidget {
  const TwoPlayerGame({super.key});

  @override
  State<TwoPlayerGame> createState() => _TwoPlayerGameState();
}

class _TwoPlayerGameState extends State<TwoPlayerGame> {
  String turn = 'p1';
  int currentTotal = 0;
  int previouslyPicked = 0;
  int turnNum = 0;

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;

    // Lets it finish building before popping.
    Future.delayed(Duration.zero, () {
      if (currentTotal >= 21) {
        Provider.of<Game21Engine>(context, listen: false).winnerName =
            turn == 'p1' ? 'P2' : 'P1';
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
                          currentTotal.toString(),
                          style: TextStyle(fontSize: 225, color: theme.primary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Contains the turn info.
                  SizedBox(
                    height: 225,
                    child: NeumorphicContainer(
                      highlightSize: 1,
                      shadowSize: 1,
                      blurRadius: 4,
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Player 1 info.
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    'P1',
                                    style: TextStyle(
                                        fontSize: turn == 'p1' ? 125 : 75,
                                        color: theme.primary),
                                  ),
                                ),
                                if (turn != 'p1')
                                  Center(
                                      child: Column(
                                    children: [
                                      Text(
                                        'Turn: $turnNum',
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: theme.onPrimary),
                                      ),
                                      Text(
                                        'Chose: $previouslyPicked',
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: theme.onPrimary),
                                      ),
                                    ],
                                  ))
                              ],
                            ),
                          ),
                          // Seperator.
                          Container(
                            margin: const EdgeInsets.all(10),
                            color: theme.outline,
                            height: 240,
                            width: 1,
                          ),
                          // Player 2 info.
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    'P2',
                                    style: TextStyle(
                                        fontSize: turn == 'p2' ? 125 : 75,
                                        color: theme.primary),
                                  ),
                                ),
                                if (turn != 'p2')
                                  Center(
                                      child: Column(
                                    children: [
                                      Text(
                                        'Turn: $turnNum',
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: theme.onPrimary),
                                      ),
                                      Text(
                                        'Chose: $previouslyPicked',
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: theme.onPrimary),
                                      ),
                                    ],
                                  ))
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
                  child: Row(
                children: [
                  Expanded(
                    child: BasicButton(
                      onPressed: () {
                        setState(() {
                          turn = turn == 'p1' ? 'p2' : 'p1';
                          turnNum++;
                          previouslyPicked = 1;
                          currentTotal += 1;
                        });
                      },
                      child: Text('1',
                          style: TextStyle(fontSize: 75, color: theme.primary)),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 100,
                    color: theme.outline,
                  ),
                  Expanded(
                    child: BasicButton(
                      onPressed: () {
                        setState(() {
                          turn = turn == 'p1' ? 'p2' : 'p1';

                          turnNum++;
                          previouslyPicked = 2;
                          currentTotal += 2;
                        });
                      },
                      child: Text('2',
                          style: TextStyle(fontSize: 75, color: theme.primary)),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 100,
                    color: theme.outline,
                  ),
                  Expanded(
                    child: BasicButton(
                      onPressed: () {
                        setState(() {
                          turn = turn == 'p1' ? 'p2' : 'p1';

                          turnNum++;
                          previouslyPicked = 3;
                          currentTotal += 3;
                        });
                      },
                      child: Text('3',
                          style: TextStyle(fontSize: 75, color: theme.primary)),
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
