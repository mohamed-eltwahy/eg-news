import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget loading()
{
  return Container(
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

Widget noconnection()
{
  return Container(
    child: Center(
      child:Text('No InterNet Connection!',style: TextStyle(color: Colors.red),),
    ),
  );
}

Widget nodata()
{
  return Container(
    child: Center(
      child:Text('No Data Available!',style: TextStyle(color: Colors.red),),
    ),
  );
}

  String postdatewritten(String datetime) {
    Duration timeAgo = DateTime.now().difference(DateTime.parse(datetime));
    DateTime diference = DateTime.now().subtract(timeAgo);
    return timeago.format(diference);
  }