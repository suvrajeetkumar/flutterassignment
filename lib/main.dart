import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Event.dart';
import 'data.dart';
void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

void prints(String s){
  print(s);
}


class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState(){
    super.initState();
    print("init");
    initialState();
  }

  int a=0;
  int _value=1;
  String filteredValue = "Recommended" ;
  List<Data> datas = [];
  List<Data> filterdata = [];
  String s ;
  void printss() {
    if(filteredValue=="Recommended"){
      setState(() {
        filterdata=[];
        for( var i = 3; i<5 ; i++ ){
          filterdata.add(Data(title: datas[i].title,day: datas[i].day, time: datas[i].time,genre: datas[i].genre,add: datas[i].add),);
        }
      });
    //  print(filteredValue);
    }
    else if(filteredValue=="latest"){
      setState(() {
        filterdata=[];
        for( var i = 1; i<3 ; i++ ){
          filterdata.add(Data(title: datas[i].title,day: datas[i].day, time: datas[i].time,genre: datas[i].genre,add: datas[i].add),);
        }
      });
    //  print(filteredValue);
    }
    else if(filteredValue=="all"){
      setState(() {
        filterdata=[];
        for( var i = 0; i<5 ; i++ ){
          filterdata.add(Data(title: datas[i].title,day: datas[i].day, time: datas[i].time,genre: datas[i].genre,add: datas[i].add),);
        }
      });
      //print(filteredValue);
    }

//    void initialState(){
//      print(filterdata[0].day);
//    }


//    @override
//    void initState() {
//      super.initState();
//      print("init ran");
//    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(240.0), // here the desired height
          child:
          AppBar(

            flexibleSpace:
            Padding(
              padding: const EdgeInsets.only(top: 35.0,left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(

                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Hello',
                              style: TextStyle(
                                  color: Colors.white
                              )
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'Suvrajeet Kumar!',
                            style: TextStyle( fontSize: 30,
                                color: Colors.white),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left:80.0),
                        child: Icon(Icons.cloud_circle,color: Colors.white,size: 80,),
                      ),

                    ],
                  ),

                  SizedBox(height: 25,),
                  Row(
                      children: [
                        Text(
                          ''
                              'Events curated just for you',
                          style: TextStyle( fontSize: 20,
                              color: Colors.white),
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: DropdownButton<String>(
                              value: filteredValue,

                              items: [
                                DropdownMenuItem<String>(
                                  child: Text("Recommended"),
                                  value: "Recommended",
                                ),
                                DropdownMenuItem<String>(
                                  child: Text("Latest"),
                                  value: "latest",
                                ),
                                DropdownMenuItem<String>(
                                  child: Text("all"),
                                  value: "all",
                                ),
                              ],
                              onChanged: ( String value) {

                                setState(() {
                                  this.filteredValue = value;
                                  //filterdata[0].day = datas[0].day;
                                  //s = datas[0].day;

                                });
                                printss();

                                //prints(filterdata[0].day);

                              },
                            hint: Text('Filter',style: TextStyle(color: Colors.white),
                            ), ),

                        ),
                      ]
                  ),

                ],
              ),


            ),
            backgroundColor: Colors.black,







          ),

        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection('events').snapshots(),
          builder: (context, snapshot) {

            if(!snapshot.hasData) return Text('loading');
//            datas = [
//              Data(add: snapshot.data.documents[0]['image'], day: snapshot.data.documents[0]['day'], time: snapshot.data.documents[0]['time'],title: snapshot.data.documents[0]['title'],genre: snapshot.data.documents[0]['genre']),
//              Data(add: snapshot.data.documents[1]['image'], day: snapshot.data.documents[1]['day'], time: snapshot.data.documents[1]['time'],title: snapshot.data.documents[1]['title'],genre: snapshot.data.documents[1]['genre']),
//              Data(add: snapshot.data.documents[2]['image'], day: snapshot.data.documents[2]['day'], time: snapshot.data.documents[2]['time'],title: snapshot.data.documents[2]['title'],genre: snapshot.data.documents[2]['genre']),
//              Data(add: snapshot.data.documents[3]['image'], day: snapshot.data.documents[3]['day'], time: snapshot.data.documents[3]['time'],title: snapshot.data.documents[3]['title'],genre: snapshot.data.documents[3]['genre']),
//              Data(add: snapshot.data.documents[4]['image'], day: snapshot.data.documents[4]['day'], time: snapshot.data.documents[4]['time'],title: snapshot.data.documents[4]['title'],genre: snapshot.data.documents[3]['genre']),
//            ];


            for( var i = 0; i<5 ; i++ ){
              datas.add(Data(add: snapshot.data.documents[i]['image'], day: snapshot.data.documents[i]['day'], time: snapshot.data.documents[i]['time'],title: snapshot.data.documents[i]['title'],genre: snapshot.data.documents[i]['genre']),);
            }




            return Center(
              child: GridView.count( crossAxisCount: 1,
                children:
                  filterdata.map((filterdata) => Events(add: '${filterdata.add}',day: '${filterdata.day}',time: '${filterdata.time}',title: '${filterdata.title}',genre: '${filterdata.genre}',)).toList(),
//                  Events(add: snapshot.data.documents[0]['image'], day: snapshot.data.documents[0]['day'], time: snapshot.data.documents[0]['time'],title: snapshot.data.documents[0]['title'],genre: snapshot.data.documents[0]['genre']),
//                  Events(add: snapshot.data.documents[1]['image'], day: snapshot.data.documents[1]['day'], time: snapshot.data.documents[1]['time'],title: snapshot.data.documents[1]['title'],genre: snapshot.data.documents[1]['genre']),

              ),

            );

          }
        ),
        backgroundColor: Colors.blueGrey[900],

      ),
    );
  }

  void initialState() {
    Future.delayed(Duration(seconds: 3),(){
      setState(() {
//        filterdata = [
//          Data(title: datas[0].title,day: datas[0].day, time: datas[0].time,genre: datas[0].genre,add: datas[0].add),
//          Data(title: datas[1].title,day: datas[1].day, time: datas[1].time,genre: datas[1].genre,add: datas[1].add),
//          Data(title: datas[2].title,day: datas[2].day, time: datas[2].time,genre: datas[2].genre,add: datas[2].add),
//          Data(title: datas[3].title,day: datas[3].day, time: datas[3].time,genre: datas[3].genre,add: datas[3].add),
//          Data(title: datas[4].title,day: datas[4].day, time: datas[4].time,genre: datas[4].genre,add: datas[4].add),
//        ];
        for( var i = 0; i<5 ; i++ ){
          filterdata.add(Data(title: datas[i].title,day: datas[i].day, time: datas[i].time,genre: datas[i].genre,add: datas[i].add),);
        }

      });
    });

  }

}



