import 'package:flutter/material.dart';

class SilverExp extends StatefulWidget {
  const SilverExp({super.key});

  @override
  State<SilverExp> createState() => _SilverExpState();
}

class _SilverExpState extends State<SilverExp> {
  List<String> data = ["prince", "jose"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  getBody() {
    return CustomScrollView(
      slivers: <Widget>[
        const SliverAppBar(
        title: Text('SliverFillViewport Example'),
        expandedHeight: 150.0,
        flexibleSpace: FlexibleSpaceBar(
          background: FlutterLogo(),
        ),
        pinned: true,
      ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return ListTile(
              leading: const Icon(Icons.label),
              title: Text(data[index]),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    ; // Remove the item
                  });
                },
              ),
            );
          },
          childCount: data.length,
        )),
        SliverFillViewport(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(
                color: index.isEven ? Colors.blue : Colors.green,
                child: Center(
                  child: Text(
                    'Page $index',
                    style: const TextStyle(color: Colors.white, fontSize: 48),
                  ),
                ),
              );
            },
            childCount: 3, // Three full-screen children
          ),
          viewportFraction: 1.0, // Each child fills the viewport
        ),
      ],
    );
  }
}
