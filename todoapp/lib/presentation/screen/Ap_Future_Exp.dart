import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ApiExp extends StatefulWidget {
  const ApiExp({super.key});

  @override
  State<ApiExp> createState() => _ApiExpState();
}

class _ApiExpState extends State<ApiExp> {
  late Future<dynamic> postResponse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // postResponse = getPosts();
    // postResponse = getPostWithTimeout();
    postResponse = getPostWithWait();

  }

  Future<dynamic> getPosts() async {
    try {
      var response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));
      if (response.statusCode == 200) {
        var post = jsonDecode(response.body);
        return post;
      } else {
        return Future.error(response);
      }
    } catch (e) {
      print(e.toString());
      return Future.error(e);
    }
  }

  Future<dynamic> getPostWithThen() {
    return http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/todos"))
        .then((value) {
      return jsonDecode(value.body);
    }).catchError((error) {
      return error;
    }).whenComplete(() => print("useful for cleanup"));
  }

  Future<dynamic> getPostWithTimeout() {
    return http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/todos"))
        .timeout(const Duration(seconds: 1), onTimeout: () {
      return Future.error("Request timed out");
    }).then((value) {
      return jsonDecode(value.body);
    }).catchError((error) {
      return error;
    }).whenComplete(() => print("useful for cleanup"));
  }

  Future<dynamic> getPostWithWait() async {

    try
        {
          var results = await Future.wait([http
              .get(Uri.parse("https://jsonplaceholder.typicode.com/todos")), Future.delayed(Duration(seconds: 2))]);
          return jsonDecode(results[0].body);
        }catch(e) {
      print('Error: $e');

    }
  }

  Widget _getBody() {
    return FutureBuilder(
        future: postResponse,
        builder: (context, snap) {
          if (snap.hasData) {
            List<dynamic> data = snap.data;
            return CustomScrollView(
              slivers: <Widget>[
                const SliverAppBar(
                  title: Text("Sliver"),
                  pinned: true,
                ),
                SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, crossAxisSpacing: 100),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(data[index]["title"]),
                      );
                    }),
              ],
            );
          }
          if (snap.hasError) {
            return const Text("Error");
          }
          return const SizedBox.shrink();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _getBody()),
    );
  }
}
