import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:quick_desk/APIs.dart';

void main() {
  runApp(const MyApp());
}

bool taked = false;
bool clickable = true;
String CountOfCounter = "";

Widget widgetForNowServing = NowServing();
Widget widgetForLastNumber = const LastNumber();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Customer View'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children:  [
            Padding(padding: EdgeInsets.all(20)),
            StatusBoard(),
            Padding(padding: EdgeInsets.all(20)),
            Container(
              alignment: Alignment.center,
              child: Counters(),
            ),

          ],
        ),
      ),
    );
  }
}

class StatusBoard extends StatefulWidget {
  const StatusBoard({Key? key}) : super(key: key);
  @override
  _StatusBoardState createState() => _StatusBoardState();
}
class _StatusBoardState extends State<StatusBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 400),
      // margin: const EdgeInsets.all(10),
      // padding: const EdgeInsets.all(20),
      width: (MediaQuery.of(context).size.width/5)*4,

      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
        // crossAxisAlignment: CrossAxisAlignment.center, //Center Column contents horizontally,
        children:const [
          NowServing(),
          LastNumber(),
          TakeNumber(),
        ],
      ),
    );
  }
}

class Counters extends StatefulWidget {
  const Counters({Key? key}) : super(key: key);
  @override
  _CountersState createState() => _CountersState();
}
class _CountersState extends State<Counters> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        FutureBuilder<String>(
            future: Functions.counterOfCounter(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                String status = snapshot.data ?? "";
                Map<String, dynamic> decodeResponse = jsonDecode(status);
                return Wrap(
                  children: [
                    for(int i = 1 ; i <= int.parse(decodeResponse["aryresultlist"][0]["count"]) ; i++)
                      Counter(AoC: i.toString())
                  ],
                );
              } else {
                return Container();
              }
            }
        ),
      ],
    );

  }
}

class TakeNumber extends StatefulWidget {
  const TakeNumber({Key? key}) : super(key: key);

  @override
  _TakeNumberState createState() => _TakeNumberState();
}
class _TakeNumberState extends State<TakeNumber> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child:
        ((){
          if(taked == false){
            return TextButton(
              onPressed: ()async{
                setState(() {
                  taked = true;
                });
                var response = await Functions.generateNumber();
              },
              child: const Text("Take a Number"),
            );
          }else{
            return FutureBuilder<String>(
              future: Functions.getNumber(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                if(snapshot.hasData){
                  String status = snapshot.data ?? "";
                  Map<String, dynamic> decodeResponse = jsonDecode(status);
                  return Text("Your Number : "+decodeResponse["aryresultlist"][0]["id"]);
                }else{
                  return Container();
                }
              }
            );
          }
        }()),
    );
  }
}

class NowServing extends StatefulWidget {
  const NowServing({Key? key}) : super(key: key);
  @override
  _NowServingState createState() => _NowServingState();
}
class _NowServingState extends State<NowServing> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration (seconds: 5), () => setState(() {
      widgetForNowServing = const NowServing();
    }));
    return Container(
      padding: EdgeInsets.all(10),
      child: FutureBuilder<String>  (
          future: Functions.servingNumber(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot){
            if(snapshot.hasData){
              String status = snapshot.data ?? "";
              Map<String, dynamic> decodeResponse = jsonDecode(status);
              if(decodeResponse["aryresultlist"][0]["id"] == null){
                return Text("Now Serving : no number in the serving");
              }else{
                return Text("Now Serving : "+decodeResponse["aryresultlist"][0]["id"].padLeft(4, '0'));
              }

            }else{
              return Container();
            }
          }
      )
    );
  }
}

class LastNumber extends StatefulWidget {
  const LastNumber({Key? key}) : super(key: key);
  @override
  _LastNumberState createState() => _LastNumberState();
}
class _LastNumberState extends State<LastNumber> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration (seconds: 5), () => setState(() {
      widgetForLastNumber = const LastNumber();
    }));
    return FutureBuilder<String>  (
        future: Functions.lastNumber(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot){
          if(snapshot.hasData){
            String status = snapshot.data ?? "";
            Map<String, dynamic> decodeResponse = jsonDecode(status);
            if(decodeResponse["aryresultlist"].length <=0){
              return const Text("Last Number : get the first number");
            }else{
              return Text("Last Number : "+decodeResponse["aryresultlist"][0]["id"].padLeft(4, '0'));
            }

          }else{
            return Container();
          }
        }
    );
  }

}

class CounterStatus extends StatefulWidget {
  const CounterStatus({Key? key,required this.cID}) : super(key: key);
  final String cID;
  @override
  _CounterStatusState createState() => _CounterStatusState();
}
class _CounterStatusState extends State<CounterStatus> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>  (
        future: Functions.counterStatus(widget.cID),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot){
          if(snapshot.hasData){
            String status = snapshot.data ?? "";
            Map<String, dynamic> decodeResponse = jsonDecode(status);
            if(decodeResponse["aryresultlist"][0]["status"]!='0' && decodeResponse["aryresultlist"][0]["current_number"]!=null){
              return Container(
                alignment: Alignment.centerRight,
                width: 20,
                height: 20,
                color:
                Colors.red,
              );
            }else if(decodeResponse["aryresultlist"][0]["status"]=='0'){
              return Container(
                width: 20,
                height: 20,
                color:
                Colors.grey,
              );
            }
            else{
              return Container(
                width: 20,
                height: 20,
                color:
                Colors.green,
              );
            }
          }else{
            return Container();
          }
        }
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({Key? key ,required this.AoC}) : super(key: key);
  final String AoC;
  @override
  _CounterState createState() => _CounterState();
}
class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration (seconds: 5), () => setState(() {
        Counter( AoC: widget.AoC,);
    }));
    return Container(
      margin: const EdgeInsets.all(10),
      color: Colors.grey[200],
      constraints: const BoxConstraints( maxWidth: 200,maxHeight: 200),
      // width: (MediaQuery.of(context).size.width/5),
      // height: (MediaQuery.of(context).size.height/5),
      width: 200,
      height: 200,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: CounterStatus(cID: widget.AoC),
          ),

          Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 20)),

          Text('COUNTER '+widget.AoC),

          Padding(padding: EdgeInsets.all(15)),

          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Text('Now Serving : '),
          ),

          Padding(padding: EdgeInsets.all(5)),

          Container(
            child: FutureBuilder<String>  (
              future: Functions.counterStatus(widget.AoC),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                if(snapshot.hasData){
                  String status = snapshot.data ?? "";
                  Map<String, dynamic> decodeResponse = jsonDecode(status);

                  if(decodeResponse["aryresultlist"][0]["status"]!='0'){
                    if(decodeResponse["aryresultlist"][0]["current_number"] != null){
                      return Text(decodeResponse["aryresultlist"][0]["current_number"]);
                    }else{
                      return Text("No Serving");
                    }
                  }else{
                    return Text('Offline');
                  }
                }else{
                  return Container();
                }
              }
            ),
          )
        ],
      ),
    );
  }
}
