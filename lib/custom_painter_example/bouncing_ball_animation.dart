import 'package:flutter/material.dart';

class BouncingBallAnimation extends StatefulWidget {
  const BouncingBallAnimation({super.key});

  @override
  State<BouncingBallAnimation> createState() => _BouncingBallAnimationState();
}

class _BouncingBallAnimationState extends State<BouncingBallAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );
    animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(200, 200),
                  painter: BouncingBallPainter(
                    animationValue: animation.value,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BouncingBallPainter extends CustomPainter {
  final double animationValue;
  BouncingBallPainter({required this.animationValue});
  @override
  // Help us to draw what we want
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.blue;
    canvas.drawCircle(
      // Offset(size.width / 2, animationValue),
      Offset(size.width / 2, size.height - (animationValue * size.height)),
      20,
      paint,
    );
  }

  @override
  // Precise if the paint have to be rebuilt when we create a new instance of BouncingBallPainter
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
