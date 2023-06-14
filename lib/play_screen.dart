import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:snake_ji/score_screen.dart';
import 'package:flutter/material.dart';

class SnakeJi extends StatefulWidget {
  @override
  _SnakejiState createState() => _SnakejiState();
}

class _SnakejiState extends State<SnakeJi> with TickerProviderStateMixin {

  late int _scoreOfPlayer;
  late bool _gameStarted;
  late var _snakeAnimation;
  late AnimationController _controllerS;
  List _snake = [404, 405, 406, 407];
  final int _squaresCount = 500;
  final Duration _duration = Duration(milliseconds: 300);
  final int _squareSize = 20;
  late String _currentDirectionSnake;
  late int _snakeFoodPosition;
  Random _random = new Random();

  @override
  void initState() {
    super.initState();
    _gameSetUp();
  }

  void _gameSetUp() {
    _scoreOfPlayer = 0;
    _currentDirectionSnake = 'RIGHT';
    _gameStarted = true;
    do {
      _snakeFoodPosition = _random.nextInt(_squaresCount);
    } while(_snake.contains(_snakeFoodPosition));
    _controllerS = AnimationController(vsync: this, duration: _duration);
    _snakeAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _controllerS);
  }

  void _gameBegins() {
    Timer.periodic(Duration(milliseconds: 300), (Timer timer) {
      _stateUpdationSnake();
      if(_gameStarted) timer.cancel();
    });
  }

  bool _gameOver() {
    for (int i = 0; i < _snake.length - 1; i++) if (_snake.last == _snake[i]) return true;
    return false;
  }

  void _stateUpdationSnake() {
    if(!_gameStarted) {
      setState(() {
        _scoreOfPlayer = (_snake.length - 4) * 100;
        switch (_currentDirectionSnake) {
          case 'DOWN':
            if (_snake.last > _squaresCount) _snake.add(_snake.last + _squareSize - (_squaresCount + _squareSize));
            else _snake.add(_snake.last + _squareSize);
            break;
          case 'UP':
            if (_snake.last < _squareSize) _snake.add(_snake.last - _squareSize + (_squaresCount + _squareSize));
            else _snake.add(_snake.last - _squareSize);
            break;
          case 'RIGHT':
            if ((_snake.last + 1) % _squareSize == 0) _snake.add(_snake.last + 1 - _squareSize);
            else _snake.add(_snake.last + 1);
            break;
          case 'LEFT':
            if ((_snake.last) % _squareSize == 0) _snake.add(_snake.last - 1 + _squareSize);
            else _snake.add(_snake.last - 1);
        }

        if (_snake.last != _snakeFoodPosition) _snake.removeAt(0);
        else {
          do {
            _snakeFoodPosition = _random.nextInt(_squaresCount);
          } while (_snake.contains(_snakeFoodPosition));
        }

        if (_gameOver()) {
          setState(() {
            _gameStarted = !_gameStarted;
          });
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => GameOver(score: _scoreOfPlayer)));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('S N A K E J I', style: TextStyle(color: Colors.black, fontSize: 25.0, fontFamily: 'Schyler')),
        centerTitle: false,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Score: $_scoreOfPlayer', style: TextStyle(fontSize: 16.0,color: Colors.black)),
            )
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.redAccent,
        elevation: 20,
        label: Text(
          _gameStarted ? 'Start' : 'Pause',
          style: TextStyle(),
        ),
        onPressed: () {
          setState(() {
            if(_gameStarted) _controllerS.forward();
            else _controllerS.reverse();
            _gameStarted = !_gameStarted;
            _gameBegins();
          });
        },
        icon: AnimatedIcon(icon: AnimatedIcons.play_pause, progress: _snakeAnimation,)
      ),
      body: Center(
        child: GestureDetector(
          onVerticalDragUpdate: (drag) {
            if (drag.delta.dy > 0 && _currentDirectionSnake != 'UP') _currentDirectionSnake = 'DOWN';
            else if (drag.delta.dy < 0 && _currentDirectionSnake != 'DOWN') _currentDirectionSnake = 'UP';
          },
          onHorizontalDragUpdate: (drag) {
            if (drag.delta.dx > 0 && _currentDirectionSnake != 'LEFT') _currentDirectionSnake = 'RIGHT';
            else if (drag.delta.dx < 0 && _currentDirectionSnake != 'RIGHT')  _currentDirectionSnake = 'LEFT';
          },
          child: Expanded(
            flex: 8,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: GridView.builder(
                itemCount: _squareSize + _squaresCount,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _squareSize),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Center(
                      child: Container(
                        color: Colors.black,
                        padding: _snake.contains(index) ? EdgeInsets.all(1) : EdgeInsets.all(0),
                        child: ClipRRect(
                          borderRadius: index == _snakeFoodPosition || index == _snake.last ? BorderRadius.circular(7) : _snake.contains(index) ? BorderRadius.circular(2.5) : BorderRadius.circular(1),
                          child: Container(
                            color: _snake.contains(index) ? Colors.lightGreen : index == _snakeFoodPosition ? Colors.orange : Colors.grey
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
