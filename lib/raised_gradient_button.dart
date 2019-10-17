import 'package:flutter/material.dart';

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final Function onPressed;

  const RaisedGradientButton(
      {Key key, this.gradient, this.width = double.infinity, this.height = 50.0,this.padding, this.onPressed, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(gradient: gradient, borderRadius: BorderRadius.circular(4.0), boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 4.0),
            blurRadius: 4.0,
          )
        ]),
        child: Material(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(4.0),
            onTap: onPressed,
            child: Center(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
