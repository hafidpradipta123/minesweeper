import 'package:flutter/material.dart';

class MyNumberBox extends StatelessWidget {
  const MyNumberBox({super.key, this.child, required this.revealed, required this.function});
  final child;
  final bool revealed;
  final function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function ,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Container(
          color: revealed? Colors.grey[300] : Colors.grey[400],
          child: Center(child: Text( revealed?  child.toString(): '')),
        ),
      ),
    );
  }
}
