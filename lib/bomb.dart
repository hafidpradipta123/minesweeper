import 'package:flutter/material.dart';

class MyBomb extends StatelessWidget {
  const MyBomb({super.key,  required this.child, required this.revealed, required this.function});
  final bool revealed;
  final child;
  final function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Container(
          color: Colors.grey[800],
          child: Center(child: Text(child.toString())),
        ),
      ),
    );
  }
}
