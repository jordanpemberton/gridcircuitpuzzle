import 'package:flutter/material.dart';

class PiecePart extends StatelessWidget {
  PiecePart({
    this.align,
    this.widthf,
    this.heightf,
    this.hglt = false,
  });

  final AlignmentGeometry align;
  final double widthf;
  final double heightf;
  final bool hglt;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align,
      child: FractionallySizedBox(
        widthFactor: widthf,
        heightFactor: heightf,
        child: Container(
          color: hglt ? Color.fromRGBO(200, 50, 10, 1) : Color.fromRGBO(140, 135, 130, 1),
        ),
      ),
    );
  }
}
