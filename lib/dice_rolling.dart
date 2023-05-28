import 'dart:math';
import 'package:flutter/material.dart';

class DiceRollingApp extends StatefulWidget {
  const DiceRollingApp({Key? key}) : super(key: key);

  @override
  State<DiceRollingApp> createState() => _DiceRollingAppState();
}

class _DiceRollingAppState extends State<DiceRollingApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int diceRoll = 1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  void rollDice() {
    _animationController.forward(from: 0.0);
    setState(() {
      diceRoll = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text(
        'Dice Number:',
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 20.0),
      AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(
            scale: _animation.value * 0.5 + 0.3,
            child: Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(100.0),
              ),
              child: Center(
                child: Text(
                  '$diceRoll',
                  style: const TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      const SizedBox(height: 40.0),
      ElevatedButton(
        onPressed: rollDice,
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 5.0,
          animationDuration: const Duration(milliseconds: 200),
        ),
        child: const Text(
          'Roll Dice',
          style: TextStyle(fontSize: 24.0, color: Colors.white),
        ),
      )
    ]));
  }
}
