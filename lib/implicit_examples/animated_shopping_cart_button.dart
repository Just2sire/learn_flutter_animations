import 'package:flutter/material.dart';

class ShoppingCartButton extends StatefulWidget {
  const ShoppingCartButton({super.key});

  @override
  State<ShoppingCartButton> createState() => _ShoppingCartButtonState();
}

class _ShoppingCartButtonState extends State<ShoppingCartButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => setState(() {
            isPressed = !isPressed;
          }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            width: isPressed ? 200 : 80.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: isPressed ? Colors.green : Colors.blue,
              borderRadius: isPressed ? BorderRadius.circular(30) : BorderRadius.circular(10.0),
            ),
            child: isPressed
                ? const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.check,
                        size: 24,
                        color: Colors.white,
                      ),
                      Text(
                        "Added To Card",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
  }
}
