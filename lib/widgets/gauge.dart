import 'package:flutter/material.dart';

class Gauge extends StatelessWidget {
  final double completion;
  final String skillName;
  const Gauge({super.key, required this.completion, required this.skillName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(skillName),
            SizedBox(
              height: 50.0,
              width: 100.0,
              child: Center(child: LinearProgressIndicator(value: completion)),
            ),
          ],
        ),
      ),
    );
  }
}
