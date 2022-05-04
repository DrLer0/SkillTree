import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skilltree_app/models/models.dart';

class SkillIcon extends StatelessWidget {
  final Skill skill;
  const SkillIcon({Key? key, required this.skill}) : super(key: key);

  Widget getIcon() {
    if (skill.category == "art") {
      return const FaIcon(FontAwesomeIcons.palette);
    } else if (skill.category == "health") {
      return const FaIcon(FontAwesomeIcons.heartbeat);
    } else if (skill.category == "lifestyle") {
      return const FaIcon(FontAwesomeIcons.houseUser);
    } else if (skill.category == "skill") {
      return const FaIcon(FontAwesomeIcons.hammer);
    } else if (skill.category == "sport") {
      return const FaIcon(FontAwesomeIcons.basketballBall);
    } else {
      return const FaIcon(FontAwesomeIcons.heart);
    }
  }

  Color getColor() {
    if (skill.category == "art") {
      return const Color.fromARGB(255, 182, 175, 124);
    } else if (skill.category == "health") {
      return const Color.fromARGB(255, 182, 124, 172);
    } else if (skill.category == "lifestyle") {
      return const Color.fromARGB(255, 133, 182, 124);
    } else if (skill.category == "skill") {
      return const Color.fromARGB(255, 182, 124, 124);
    } else if (skill.category == "sport") {
      return const Color.fromARGB(255, 245, 246, 167);
    } else {
      return const Color.fromARGB(255, 124, 155, 182);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            decoration: BoxDecoration(
              color: getColor(),
              border: Border.all(
                color: Colors.grey,
                width: 5,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
                icon: getIcon(),
                onPressed: () {
                  print("Pressed");
                }))
      ],
    );
  }
}
