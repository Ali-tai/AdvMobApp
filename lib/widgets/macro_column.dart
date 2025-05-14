import 'package:flutter/material.dart';

class MacroColumn extends StatelessWidget {
  final int level;
  final String label;
  final int max;
  final Color color;

  const MacroColumn({super.key, required this.level, required this.label, required this.max, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: color, fontSize: 20)),
        Text(max.toString(), style: TextStyle(color: color, fontSize: 20)),
        BatteryIndicator(level: (level / max).toDouble(), bordercolor: color),
        Text(level.toString(), style: TextStyle(color: color, fontSize: 20)),
      ],
    );
  }

}

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
