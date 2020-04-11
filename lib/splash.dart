import 'package:flutter/material.dart';
import 'dart:async';

import 'package:news/Home.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    _checkmethod().then((status) {
      if (status) {
        _navigatetohome();
      }
    });
  }

  Future<bool> _checkmethod() async {
    await Future.delayed(Duration(seconds: 3));
    return true;
  }

  _navigatetohome() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      return Home();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage('images/newseg.jpg'),
                        fit: BoxFit.fill)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
