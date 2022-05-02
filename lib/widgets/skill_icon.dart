import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skilltree_app/models/models.dart';

class SkillIcon extends StatelessWidget {
  final Skill skill;
  const SkillIcon({Key? key, required this.skill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            decoration: BoxDecoration(
              color: const Color(0xff7c94b6),
              border: Border.all(
                color: Colors.grey,
                width: 5,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
                // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                icon: FaIcon(FontAwesomeIcons.gamepad),
                onPressed: () {
                  print("Pressed");
                }))
      ],
    );
  }
}
