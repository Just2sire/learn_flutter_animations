import 'dart:async';

import 'package:flutter/material.dart';

class SplashAnimation extends StatefulWidget {
  const SplashAnimation({super.key});

  @override
  State<SplashAnimation> createState() => _SplashAnimationState();
}

class _SplashAnimationState extends State<SplashAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    controller.addListener(() {
      if (controller.isCompleted) {
        Navigator.of(context).push(
          // Using our custom route transition class
          MyCustomRouteTransition(route: const Destination()),
        );

        /// How to create a pageTransition
        /**Navigator.of(context).push(
          // Remove MaterialPageRoute
          // MaterialPageRoute(
          //   builder: (context) => const Destination(),
          // ),
          PageRouteBuilder(
            // return a widget you want to build
            pageBuilder: (context, animation, secondaryAnimation) {
              return const Destination();
            },
            // what transition you want to add when transiting to the page you want
            /**
             * animation: presente la progression de l'animation entre l'écren précédent et l'actuel
             * secondaryAnimation: preprésente la progression de la transition de l'itinéraire précédent (celui qui est poussé hors de l'écran). 
             * Il peut donc être utilisé lorsque vous avez des transitions où des éléments de l'écran précédent doivent s'animer.
             * chi:: C'est le widget que retourne pageBuilder
             */
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );

              // Slide transition example
              // final tween = Tween<Offset>(
              //   begin: const Offset(0, -1),
              //   end: Offset.zero,
              // ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut),);

              // return SlideTransition(
              //   position: tween,
              //   child: child,
              // );
            },
          ),
        );*/

        Timer(const Duration(milliseconds: 500), () {
          controller.reset();
        });
      }
    });

    scaleAnimation = Tween<double>(
      begin: 1,
      end: 10,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            controller.forward();
          },
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Create a custom route transition that we can use every where in our app
class Destination extends StatefulWidget {
  const Destination({super.key});

  @override
  State<Destination> createState() => _DestinationState();
}

class _DestinationState extends State<Destination>
    with SingleTickerProviderStateMixin {
  late Animation<double> rotationAnimation;
  late Animation<Offset> slideAnimation;

  late AnimationController slideController;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(
        milliseconds: 2000,
      ),
      vsync: this,
    );
    // Rotation animations

    rotationAnimation = Tween<double>(begin: 0, end: 5).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));

    // slide animations
    slideAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(2, 0))
        .animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));

    controller.forward();
    Timer(const Duration(milliseconds: 1000), () {
      controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Go Back'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SlideTransition(
              position: slideAnimation,
              child: RotationTransition(
                turns: rotationAnimation,
                child: Image.asset(
                  "assets/pic_3.jpg",
                ),
              ),
            ),
            const Text(
              "Hello Desiré",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.isCompleted) {
            controller.reverse();
          } else {
            controller.forward();
          }
        },
        child: const Icon(
          Icons.rotate_left,
        ),
      ),
    );
  }
}

class MyCustomRouteTransition extends PageRouteBuilder {
  final Widget route;
  MyCustomRouteTransition({required this.route})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return route;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );

            // Slide transition example
            // final tween = Tween<Offset>(
            //   begin: const Offset(0, -1),
            //   end: Offset.zero,
            // ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut),);

            // return SlideTransition(
            //   position: tween,
            //   child: child,
            // );
          },
        );
}
