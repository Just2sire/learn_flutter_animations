import 'package:flutter/material.dart';

class PulsatingCircleAnimation extends StatelessWidget {
  const PulsatingCircleAnimation({super.key});

  // final double size = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pulsating Circle Animation'),
      ),
      body: Center(
        child: TweenAnimationBuilder(
          // La propriété child de TweenAnimationBuilder sert à passer des enfants qu'on ne veut pas rebuild
          // chaque fois que l'animation est faite. C'est lui le paramètre widget dans le callback du builder
          duration: const Duration(milliseconds: 1500),
          tween: Tween<double>(begin: 0, end: 200),
          builder: (context, size, widget) {
            return Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    blurRadius: size,
                    spreadRadius: size / 2,
                  ),
                ],
              ),
              // child: widget,
            );
          },
          child: const AnimatedScale(
            duration: Duration(milliseconds: 1500),
            scale: 1.5,
            child: Text("Hello World!"),
          ),
        ),
      ),
    );
  }
}
