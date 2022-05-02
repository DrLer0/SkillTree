import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class Skill {
//   final String skillName;
//   final int level;
//   final double experience;
//   final bool isSelected = false;

//   const Skill({
//     required this.skillName,
//     required this.level,
//     required this.experience,
//   });
// }

class Skill extends StatefulWidget {
  final String skillName;
  int level;
  double experience;
  bool isSelected = false;
  Function notifyParent;

  Skill(this.skillName, this.level, this.experience,
      {Key? key, required this.notifyParent})
      : super(key: key);

  @override
  State<Skill> createState() => _SkillState();
}

class _SkillState extends State<Skill> {
  @override
  Widget build(BuildContext context) {
    CollectionReference skill = FirebaseFirestore.instance.collection('skill');
    // Future<void> addSkill() {
    //   return skill
    //       .add({
    //         'skillName': skillName,
    //         'level': level,
    //         'exp': experience,
    //       })
    //       .then((value) => print("Added Skill"))
    //       .catchError((error) => print("Failed to add skill: $skill"));
    // }
    void incrementExp() {
      setState(() {
        widget.experience = widget.experience + 0.1;
        if (widget.experience > 1.0) {
          widget.level++;
          widget.experience = 0;
        }
        print(widget.experience);
        print("pressed Increment");
        widget.notifyParent();
      });

      return;
    }

    return IconButton(
        onPressed: incrementExp, icon: FaIcon(FontAwesomeIcons.bookOpen));
  }
}

// class Skill extends StatelessWidget {
//   final String skillName;
//   int level;
//   double experience;
//   bool isSelected = false;

//   Skill(this.skillName, this.level, this.experience, {Key? key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference skill = FirebaseFirestore.instance.collection('skill');
//     // Future<void> addSkill() {
//     //   return skill
//     //       .add({
//     //         'skillName': skillName,
//     //         'level': level,
//     //         'exp': experience,
//     //       })
//     //       .then((value) => print("Added Skill"))
//     //       .catchError((error) => print("Failed to add skill: $skill"));
//     // }
//     void incrementExp() {
//       experience += 0.1;
//       if (experience > 1.0) {
//         level++;
//         experience = 0;
//       }
//       print("pressed Increment");
//       return;
//     }

//     return IconButton(
//         onPressed: incrementExp, icon: FaIcon(FontAwesomeIcons.bookOpen));
//   }
// }
