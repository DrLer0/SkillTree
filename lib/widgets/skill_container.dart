import 'package:flutter/material.dart';
import 'package:skilltree_app/models/models.dart';
import 'package:skilltree_app/widgets/widgets.dart';

class SkillContainer extends StatelessWidget {
  final Skill skill;
  const SkillContainer({Key? key, required this.skill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 10,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
      child: Container(
          // constraints: BoxConstraints(
          //   maxWidth: 300,
          // ),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          color: Colors.black26,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [_SkillOverview(skill: skill)],
                ),
              ),
            ],
          )),
    );
  }
}

class _SkillOverview extends StatelessWidget {
  final Skill skill;
  const _SkillOverview({Key? key, required this.skill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(maxWidth: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SkillIcon(skill: skill),
            SkillStats(skill: skill),
          ],
        ));
  }
}
