import 'package:flutter/material.dart';
import 'radial_progress_painter.dart';

class RadialProgressBar extends StatefulWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final double currentProgress; // must be from 0 to 1
  final double strokeWith;
  final Widget child;

  const RadialProgressBar({
    Key key,
    @required this.foregroundColor,
    this.backgroundColor = Colors.black12,
    this.currentProgress = 0.0,
    this.strokeWith = 6.0,
    this.child,
  })  : assert(foregroundColor != null),
        super(key: key);

  @override
  _RadialProgressBarState createState() => _RadialProgressBarState();
}

class _RadialProgressBarState extends State<RadialProgressBar>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> curve;
  Animation<Color> backgroundColorTween;
  Animation<Color> foregroundColorTween;
  Animation<double> progressTween;

  void initAnimations() {
    backgroundColorTween =
        Tween<Color>(begin: widget.backgroundColor, end: widget.backgroundColor)
            .animate(curve);
    foregroundColorTween =
        Tween<Color>(begin: widget.foregroundColor, end: widget.foregroundColor)
            .animate(curve);
    progressTween =
        Tween<double>(begin: 0.0, end: widget.currentProgress).animate(curve);
    controller.forward();
  }

  void didUpdateAnimations(RadialProgressBar oldWidget) {
    if (oldWidget.backgroundColor != widget.backgroundColor) {
      backgroundColorTween = Tween<Color>(
              begin: oldWidget.backgroundColor, end: widget.backgroundColor)
          .animate(curve);
    }
    if (oldWidget.foregroundColor != widget.foregroundColor) {
      foregroundColorTween = Tween<Color>(
              begin: oldWidget.foregroundColor, end: widget.foregroundColor)
          .animate(curve);
    }
    if (oldWidget.currentProgress != widget.currentProgress) {
      progressTween = Tween<double>(
              begin: oldWidget.currentProgress, end: widget.currentProgress)
          .animate(curve);
    }
    controller.forward();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    curve = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    initAnimations();
  }

  @override
  void didUpdateWidget(RadialProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    didUpdateAnimations(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      /// We use the AspectRatio widget to ensure that our CustomPaint keeps our desired aspect ratio. The value 1 we provided means that the aspect ratio is 1:1 i.e. a square.
      aspectRatio: 1 / 1,
      child: AnimatedBuilder(
        animation: curve,
        builder: (_, __) => CustomPaint(
          child: widget.child ?? Container(),
          foregroundPainter: RadialProgressPainter(
            backgroundColor: backgroundColorTween.value,
            foregroundColor: foregroundColorTween.value,
            currentProgress: progressTween.value,
            strokeWith: widget.strokeWith,
          ),
        ),
      ),
    );
  }
}
