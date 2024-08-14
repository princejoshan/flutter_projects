import 'package:flutter/material.dart';

import 'appcolors.dart';

class AppButtonWidget extends StatefulWidget {
  final String title;
  final Color? bgColor;
  final Color? textColor;
  final Function()? onPressed;

  const AppButtonWidget(
      {super.key,
      required this.title,
      this.bgColor,
      required this.onPressed,
      this.textColor});

  @override
  State<AppButtonWidget> createState() => _AppButtonWidgetState();
}

class _AppButtonWidgetState extends State<AppButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  widget.bgColor ?? AppColors.primaryColor, // Background color
            ),
            child: Text(
              widget.title,
              style: TextStyle(color: widget.textColor ?? AppColors.white),
            ),
          )),
    );
  }
}
