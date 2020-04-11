import 'package:flutter/material.dart';
import 'package:news/models/headlines.dart';
import 'package:news/Api/headlinesapi.dart';
import 'package:news/second_page.dart';
import 'package:news/utilities.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  ValueNotifier<int> notifier = ValueNotifier(0);
  List color = [
    Colors.red.shade400,
    Colors.blue.shade400,
    Colors.yellow.shade400,
  ];

  getcolor() {
    return color.length;
  }

  HeadLinesApi headLinesApi = HeadLinesApi();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('أخبار مصر اليوم'),
      ),
      body: FutureBuilder(
        future: headLinesApi.getheahlinenews(),
        builder: (context, AsyncSnapshot asyncSnapshot) {
          switch (asyncSnapshot.connectionState) {
            case ConnectionState.active:
              return loading();
              break;
            case ConnectionState.waiting:
              return loading();
              break;
            case ConnectionState.none:
              return nodata();
              break;
            case ConnectionState.done:
              if (asyncSnapshot.hasError) {
                return noconnection();
              } else {
                List<Headlines> headlines = asyncSnapshot.data;

                return ListView.builder(
                    itemBuilder: (context, position) {
                      if (position == 0) {
                        return indicator(headlines[position]);
                      }

                      if (position == 1) {
                        return _headcard();
                      } else {
                        return _card(headlines[position]);
                      }
                    },
                    itemCount: headlines.length);
              }
              break;
          }

          return asyncSnapshot.data;
        },
      ),
    );
  }

  Widget _headcard() {
    return Transform.translate(
      offset: Offset(10, -30.0),
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 5),
                child: Text(
                  "أهم العناوين",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(Headlines headlines) {
    return Transform.translate(
      offset: Offset(2, -30),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: 8,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SecondPage(headlines);
            }));
          },
          child: Container(
            width: double.infinity,
            height: 200,
            child: Card(
              elevation: 6,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          SizedBox(
                            width: 220,
                            height: 110,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                headlines.title,
                                maxLines: 4,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 50,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Container(
                                width: 150,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey,
                                ),
                                child: Center(
                                    child: Text(
                                  headlines.source.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 100, top: 16),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  postdatewritten(headlines.publishedAt),
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Icon(
                                  Icons.access_alarm,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Container(
                              height: 110,
                              width: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(headlines.urlToImage),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget indicator(Headlines headlines) {
    return Column(
      children: <Widget>[
        ValueListenableBuilder(
          valueListenable: notifier,
          builder: (context, value, position) {
            return slider(value);
          },
        ),
        SizedBox(
          height: 250,
          child: PageView.builder(
            itemBuilder: (context, position) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SecondPage(headlines);
                  }));
                },
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 210,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(headlines.urlToImage),
                                fit: BoxFit.fill)),
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 150,
                                height: 25,
                                child: Center(
                                    child: Text(
                                  headlines.source.name,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: color[position],
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        end: Alignment.topCenter,
                                        begin: Alignment.bottomCenter,
                                        colors: [
                                          Colors.grey.withOpacity(.1),
                                          Colors.grey.withOpacity(.5)
                                        ],
                                      )),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 8, right: 8),
                                        child: Text(
                                          headlines.title,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              postdatewritten(
                                                  headlines.publishedAt),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                            Icon(
                                              Icons.access_alarm,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: 3,
            onPageChanged: (index) {
              notifier.value = index;
            },
          ),
        ),
      ],
    );
  }

  Widget slider(value) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i < 3; i++)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 3),
              width: i == value ? 30 : 8,
              height: i == value ? 6 : 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: i == value ? Colors.grey.shade800 : Colors.grey.shade400,
              ),
            ),
        ],
      ),
    );
  }
}
