import 'package:snake_ji/play_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bgimage.jpg"),
               repeat: ImageRepeat.repeat,
          ),
          border: Border.all(
            width: 8,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: Image.asset("assets/snakeimg.png")),

            SizedBox(height: 50.0),

            Text('S N A K E J I', style: TextStyle(color: Colors.white, fontSize: 60.0, fontFamily: 'Schyler', fontWeight: FontWeight.bold), textAlign: TextAlign.center),

            SizedBox(height: 50.0),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 50),
                  textStyle: TextStyle(fontSize: 24,color: Colors.black),
                  backgroundColor: Colors.redAccent,
                ),
                child: Text('Begin',style: TextStyle(color: Colors.white)),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SnakeJi()));

                })
          ],
        ),
      )
    );
  }
}

