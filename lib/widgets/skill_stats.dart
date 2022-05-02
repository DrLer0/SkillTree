import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skilltree_app/models/skill.dart';
import 'package:skilltree_app/widgets/widgets.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:skilltree_app/firebase_options.dart';

class SkillStats extends StatefulWidget {
  final Skill skill;
  const SkillStats({Key? key, required this.skill}) : super(key: key);

  @override
  State<SkillStats> createState() => _SkillStatsState();
}

class _SkillStatsState extends State<SkillStats> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      alignment: Alignment.center,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.skill.skillName),
                  Text('Level: ' + widget.skill.level.toString()),
                  ProgressBar(
                    skill_experience_points: widget.skill.experience,
                  ),
                ],
              ),
            ),
            Skill(widget.skill.skillName, widget.skill.level,
                widget.skill.experience,
                notifyParent: refresh)
            // IconButton(
            //     onPressed: () {
            //       print("Pressed");
            //     },
            //     icon: FaIcon(FontAwesomeIcons.bookOpen))
          ]),
    ));
  }
}


// class SkillStats extends StatelessWidget {
//   final Skill skill;
//   const SkillStats({Key? key, required this.skill}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//         child: Container(
//       alignment: Alignment.center,
//       child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(skill.skillName),
//                   Text('Level: ' + skill.level.toString()),
//                   ProgressBar(
//                     skill_experience_points: skill.experience,
//                   ),
//                 ],
//               ),
//             ),
//             skill
//             // IconButton(
//             //     onPressed: () {
//             //       print("Pressed");
//             //     },
//             //     icon: FaIcon(FontAwesomeIcons.bookOpen))
//           ]),
//     ));
//   }
// }
