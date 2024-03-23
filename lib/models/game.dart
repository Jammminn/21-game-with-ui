import 'package:flutter/cupertino.dart';
import 'dart:math';

/* 
  The backend of the app.
  
  Works like so:
    startGame will reset the needed variables to default values as well as do the robot's turn if needed.
    startTurn will take the user's choice and add it to the total if the user hasnt won then it will do the robot's turn and update a few variables accordingly and check if anyone won once again.
    It checks who won by comparing the user's turn number to the current turn if theyre equal the user has won otherwise the robot did.
*/

class Game21Engine extends ChangeNotifier {
  final int _goal = 21;
  final String _startingTurn = 'random';
  int Function(int) _robot = Robots.randomBot; // Sets robot.
  final Map<String, int> _scoreHistory = {
    'user': 0,
    'robot': 0,
    'total': 0
  }; // keeps track of the score
  String _currentTurn = 'user';
  int _currentTotal = 0;
  late TurnManager _turnInfo;
  bool _gameStarted = false;
  String? _winner;
  String? _winnerName;

  void startGame() {
    _gameStarted = true;
    Random random = Random();
    if (_startingTurn == 'random') {
      _currentTurn = random.nextBool() ? 'user' : 'robot';
    } else {
      _currentTurn = _startingTurn;
    }
    _currentTotal = 0;

    _turnInfo = TurnManager(
        p1Name: _currentTurn,
        p2Name: _currentTurn == 'robot' ? 'user' : 'robot');

    if (_currentTurn == 'robot') {
      int robotInput = _robot(_currentTotal);
      _currentTotal += robotInput;
      _turnInfo.updateTurn(
          name: 'robot', inputNumber: robotInput, total: _currentTotal);
    }
  }

  void startTurn(int userInput) {
    _currentTotal += userInput;
    _turnInfo.updateTurn(
        name: 'user', inputNumber: userInput, total: _currentTotal);
        
    if (!gameFinished) {
      int robotInput = _robot(_currentTotal);
      _currentTotal += robotInput;
      _turnInfo.updateTurn(
          name: 'robot', inputNumber: robotInput, total: _currentTotal);
    }
    notifyListeners();

    if (gameFinished) {
      _gameStarted = false;
      _winner = _turnInfo.p1Turn == _turnInfo._turn // Gets who won.
          ? _turnInfo.p1Name
          : _turnInfo.p2Name;
          
      winnerName = _winner == 'user' ? 'YOU' : 'ROBOT';
      
      _scoreHistory[_winner!] = _scoreHistory[_winner!]! + 1;
      _scoreHistory['total'] = _scoreHistory['total']! + 1; // Made thinking i would use it but ended up useless, still here in case i want to add it somewhere in the future.
    }
  }

  bool get gameFinished => _currentTotal >= _goal;
  int get currentTotal => _currentTotal;
  TurnManager get turnInfo => _turnInfo;
  Map<String, int> get scoreHistory => _scoreHistory;
  bool get gameStarted => _gameStarted;
  String? get winnerName => _winnerName;

  set newRobot(int Function(int) robot) {
    _robot = robot;
  }

  set winnerName(String? name) {
    _winnerName = name;
    notifyListeners();
  }
}

class TurnManager {
  late String p1Name;
  late String p2Name;

  int _turn = 0;
  int _p1Turn = 0;
  int _p2Turn = 0;

  int _p1Total = 0;
  int _p2Total = 0;

  int _p1InputNumber = 0;
  int _p2InputNumber = 0;

  TurnManager({required this.p1Name, required this.p2Name});

  void updateTurn({required name, required total, required inputNumber}) {
    _turn += 1;
    if (name == p1Name) {
      _p1Turn = _turn;
      _p1Total = total;
      _p1InputNumber = inputNumber;
    } else {
      _p2Turn = _turn;
      _p2Total = total;
      _p2InputNumber = inputNumber;
    }
  }

  int get turn => _turn;
  int get p1Turn => _p1Turn;
  int get p2Turn => _p2Turn;
  int get p1Total => _p1Total;
  int get p2Total => _p2Total;
  int get p1InputNumber => _p1InputNumber;
  int get p2InputNumber => _p2InputNumber;
}

class Robots {
  // randomly selects a number between 1 and 3
  static int randomBot(int total) {
    Random random = Random();
    int randomVal = random.nextInt(3) + 1;
    if (total + randomVal > 21) randomVal = 21 - total;
    return randomVal;
  }

  // does math stuff to find the best move usually trying to get to 17 to gaurantee a win and gets a gauranteed 17 by getting 13 and so forth
  static int impossibleBot(int total) {
    List<int> goals = [5, 9, 13, 17, 21];
    int? currentGoal;
    for (int g in goals) {
      if (total < g) {
        currentGoal = g;
        break;
      }
    }
    int amount = (currentGoal! - total);
    if (amount > 3) {
      return 1;
    } else {
      return amount;
    }
  }
}
