import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Skill extends StatefulWidget {
  final String skillName;
  final int level;
  double experience;
  bool isSelected = false;

  Skill(
      {Key? key,
      required this.skillName,
      required this.level,
      required this.experience})
      : super(key: key);

  // https://firebase.flutter.dev/docs/firestore/usage#writing-data
  Skill.fromJson(Map<String, Object?> json)
      : this(
            skillName: json['skillName']! as String,
            level: json['level']! as int,
            experience: double.parse(json['experience'].toString()));

  Map<String, Object?> toJson() {
    return {'skillName': skillName, 'level': level, 'experience': experience};
  }

  @override
  State<Skill> createState() => _SkillState();
}

class _SkillState extends State<Skill> {
  @override
  Widget build(BuildContext context) {
    CollectionReference skill = FirebaseFirestore.instance.collection('skill');

    // FirebaseFireStore Add Document Example
    // Future<void> addSkill() {
    //   return skill
    //       .doc(widget.skillName)
    //       .set({
    //         'skillName': widget.skillName,
    //         'level': widget.level,
    //         'experience': widget.experience,
    //       })
    //       .then((value) => print("Added Skill"))
    //       .catchError(
    //           (error) => print("Failed to add skill: ${widget.skillName}"));
    // }

    Future<void> incrementExp() {
      DocumentReference skillRef = skill.doc(widget.skillName);

      return FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(skillRef);
        if (!snapshot.exists) {
          throw Exception("Skill does not exist!");
        }
        double newExperienceValue = snapshot.get('experience') + 0.1;
        if (newExperienceValue >= 1) {
          transaction.update(skillRef, {'experience': 0});

          int newLevel = snapshot.get('level') + 1;
          transaction.update(skillRef, {'level': newLevel});
          setState(() {
            widget.experience = 0;
          });
        } else {
          transaction.update(skillRef, {'experience': newExperienceValue});
          setState(() {
            widget.experience = newExperienceValue;
          });
        }
      }).then((value) => print("DocumentSnapshot successfully updated!"),
          onError: (e) => print("Error updating document $e"));
    }

    return IconButton(
        onPressed: incrementExp, icon: FaIcon(FontAwesomeIcons.bookOpen));
  }
}
