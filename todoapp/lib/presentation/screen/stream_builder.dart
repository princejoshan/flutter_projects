
import 'package:flutter/material.dart';

class StreamBuilderExp extends StatefulWidget {
  const StreamBuilderExp({super.key});

  @override
  State<StreamBuilderExp> createState() => _StreamBuilderExpState();
}

class _StreamBuilderExpState extends State<StreamBuilderExp> {
  late Stream<int>stream;


  @override
  void initState() {
    super.initState();
    //singlesubscription
    // stream = getStreamValues();
    //multiple subscription
    stream = getStreamValues().asBroadcastStream();
  }

  Stream<int> getStreamValues()async* {
    await Future.delayed(Duration(seconds: 2));
    yield 10;
    await Future.delayed(Duration(seconds: 2));
    yield 5;
    await Future.delayed(Duration(seconds: 2));
    yield 4;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(stream: stream, builder: (context,snapshot) {
              if(snapshot.hasData) {
                return Text(snapshot.data.toString());
              }
              return Text("none");
            }),
            StreamBuilder(stream: stream, builder: (context,snapshot) {
              if(snapshot.hasData) {
                return Text(snapshot.data.toString());
              }
              return Text("none");
            }),
          ],
        ),
      )
    );
  }
}
