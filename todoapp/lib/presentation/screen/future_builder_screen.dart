import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FutureBuilderExp extends StatefulWidget {
  const FutureBuilderExp({super.key});

  @override
  State<FutureBuilderExp> createState() => _FutureBuilderExpState();
}

class _FutureBuilderExpState extends State<FutureBuilderExp> {
  late Future<int> futureNumbers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureNumbers = getNumbers();
  }

  Future<int> getNumbers() async {
    await Future.delayed(Duration(seconds: 4));
    return 1;
  }

  Future<int> refresh() async {
    await Future.delayed(Duration(seconds: 4));
    setState(() {
      futureNumbers = Future.value(10);
    });
    return futureNumbers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: futureNumbers,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.toString());
              }
              return Text("none");
            }),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        refresh();
      },
      child: Icon(Icons.refresh),),
    );
  }
}
