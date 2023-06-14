import 'package:snake_ji/play_screen.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {

  final int score;

  GameOver({
    required this.score
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/gameover2.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You Died', style: TextStyle(color: Colors.white, fontSize: 80.0, fontWeight: FontWeight.bold, fontFamily: 'Schyler', shadows: [
                Shadow( // bottomLeft
                  offset: Offset(-2.0, -2.0),
                  color: Colors.black
                ),
                Shadow( // bottomRight
                  offset: Offset(2.0, -2.0),
                  color: Colors.black
                ),
                Shadow( // topRight
                  offset: Offset(2.0, 2.0),
                  color: Colors.black
                ),
                Shadow( // topLeft
                  offset: Offset(-2.0, 2.0),
                  color: Colors.black
                ),
              ])
            ),
            
            SizedBox(height: 50.0),

            Text('Score: $score', style: TextStyle(color: Colors.red, fontSize: 40.0,fontWeight: FontWeight.w800)),

            SizedBox(height: 50.0),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),

              child: Container(
                child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SnakeJi()));
                    },
                    icon: Icon(Icons.refresh, color: Colors.black, size: 30.0),
                    label: Text("Retry", style: TextStyle(color: Colors.black, fontSize: 20.0))
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}