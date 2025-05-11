import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BatteryIndicator extends StatelessWidget {
  final double level;
  final Color bordercolor;

  const BatteryIndicator({super.key, required this.level, required this.bordercolor});

  Color getColor() {
    if (level <= 0.5) {
      return Colors.green;
    } else if (level <= 0.75) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 30,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: bordercolor, width: 2),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: level * 140,
            decoration: BoxDecoration(
              color: getColor(),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}
