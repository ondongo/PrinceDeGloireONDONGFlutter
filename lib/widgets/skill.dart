import 'package:flutter/material.dart';

import 'package:mon_premier_projet/widgets/gauge.dart';

class Skill extends StatelessWidget {
  const Skill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> skills = [
      {"skillName": "Php", "completion": 0.10},
      {"skillName": "Flutter", "completion": 0.50},
      {"skillName": "Dart", "completion": 0.40},
      {"skillName": "JavaScript", "completion": 0.30},
    ];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: skills.length,
      itemBuilder: (context, index) {
        var skill = skills.elementAt(index);
        return Card(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gauge(
                  completion: (skill["completion"] as num).toDouble(),
                  skillName: skill["skillName"] as String,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
