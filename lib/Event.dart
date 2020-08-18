import 'package:flutter/material.dart';
class Events extends StatefulWidget {
  final String add ;
  final String day;
  final String time;
  final String title;
  final String genre;
  Events({this.add,this.day,this.time,this.title,this.genre});

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.all(10.0),
      height: 1000,
      child: Card(
          color: Colors.black26,
          child: Column(
            children: [
              Text(widget.title,style: TextStyle(color: Colors.white,fontSize: 40),),
              AspectRatio(
                child: Image.network(widget.add,fit: BoxFit.fill),
                aspectRatio: 1.4/1,),

              Text(widget.genre,style: TextStyle(color: Colors.white),),
              Text(widget.day,style: TextStyle(color: Colors.white),),
              Text(widget.time,style: TextStyle(color: Colors.white),),

            ],
          )

      ),
    );
  }
}