import 'package:flutter/material.dart';

class ListAnimation extends StatefulWidget {
  const ListAnimation({super.key});

  @override
  State<ListAnimation> createState() => _ListAnimationState();
}

class _ListAnimationState extends State<ListAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slideAnimation;
  late List<Animation<Offset>> animations = [];
  final int itemCount = 5;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    animations = List.generate(
      itemCount,
      (index) => Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(index * (1 / itemCount), 1), // 0.2 s interval
        ),
      ),
    );

    // slideAnimation = Tween<Offset>(
    //   begin: const Offset(-1, 0),
    //   end: Offset.zero,
    // ).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Animation'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return SlideTransition(
            position: animations[index],
            child: ListTile(
              title: Text('Hello World, Desiré. ${index.toString()}'),
            ),
          );
        },
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
          Icons.done,
        ),
      ),
    );
  }
}
