import 'package:flutter/material.dart';
import 'package:skilltree_app/models/models.dart';

class ProgressBar extends StatefulWidget {
  final double skill_experience_points;
  const ProgressBar({Key? key, required this.skill_experience_points})
      : super(key: key);

  @override
  State<ProgressBar> createState() => _ProgressBar(skill_experience_points);
}

class _ProgressBar extends State<ProgressBar> with TickerProviderStateMixin {
  double _skill_experience_points;
  late AnimationController controller;

  _ProgressBar(this._skill_experience_points);

  @override
  void didUpdateWidget(ProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {
      if (_skill_experience_points != widget.skill_experience_points) {
        _skill_experience_points = widget.skill_experience_points;
      }
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 10, maxWidth: 175),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          children: <Widget>[
            Flexible(
                child: LinearProgressIndicator(
              value: _skill_experience_points,
            )),
          ],
        ),
      ),
    );
  }
}
