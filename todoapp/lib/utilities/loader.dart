import 'package:flutter/material.dart';

class Loader {
  BuildContext _context;
  bool isLoaderVisible = false;

  void hide() {
    Navigator.of(_context).pop();
  }

  void show() {
    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (ctx) => _FullScreenLoader());
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }

  Loader._create(this._context);

  factory Loader.of(BuildContext context) {
    return Loader._create(context);
  }
}

class _FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.1)),
        child: const Center(child: CircularProgressIndicator()));
  }
}
