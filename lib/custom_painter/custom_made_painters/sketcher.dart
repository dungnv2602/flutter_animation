import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Offset> points = <Offset>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              final RenderBox box = context.findRenderObject();
              final offset = box.globalToLocal(details.globalPosition)
                // exclude the Y coordinate of the AppBar
                ..translate(0.0, -AppBar().preferredSize.height);
              // add to list offset for sketch
              points = List.from(points)..add(offset);
            });
          },
          onPanEnd: (_) {
            points.add(null);
          },
          child: CustomPaint(
            painter: SketchPainter(points),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            points.clear();
          });
        },
      ),
    );
  }
}

class SketchPainter extends CustomPainter {
  final List<Offset> points;

  SketchPainter(this.points);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SketchPainter oldDelegate) => oldDelegate.points != points;

  @override
  bool shouldRebuildSemantics(SketchPainter oldDelegate) => false;
}
