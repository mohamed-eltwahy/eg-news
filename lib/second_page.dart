import 'package:flutter/material.dart';
import 'package:news/models/headlines.dart';
import 'package:news/utilities.dart';

class SecondPage extends StatefulWidget {
  Headlines head;
  SecondPage(this.head);
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.head.urlToImage),
                    fit: BoxFit.cover),
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 25,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30, right: 20),
                    child: Container(
                      width: 180,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade400,
                      ),
                      child: Center(
                          child: Text(
                       widget.head.source.name,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 5, right: 20),
                child: Row(
                  children: <Widget>[
                     Text(
                      postdatewritten(widget.head.publishedAt),
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    Icon(
                      Icons.access_alarm,
                      color: Colors.grey,
                      size: 16,
                    ),
                   
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  widget.head.title,
                  style: TextStyle(
                    fontSize: 30,
                    height: 1.2,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueAccent.shade200,
                    ),
                    width: 150,
                    height: 2,
                  ),
                ),
              ],
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  widget.head.description,
             
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
