import 'package:flutter/material.dart';
import 'package:talnts_app/common/widgets/colors.dart';

class Flatbutton extends StatelessWidget {
  const Flatbutton({
    Key? key,
    required this.text,
    this.radius = 20,
    required this.onpressed,
    this.textStyle,
    this.loading = false,
  }) : super(key: key);

  final String text;
  final double radius;
  final Function() onpressed;
  final TextStyle? textStyle;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: loading
          ? const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      )
          : Text(text, style: textStyle ?? const TextStyle(fontSize: 14)),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(statusBar),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(color: statusBar),
          ),
        ),
      ),
      onPressed: () {
        if (loading) {
        } else {
          onpressed();
        }
      },
    );
  }
}
