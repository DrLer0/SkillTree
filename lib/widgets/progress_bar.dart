import 'package:flutter/material.dart';
import 'package:skilltree_app/models/models.dart';

class ProgressBar extends StatefulWidget {
  final double skill_experience_points;
  const ProgressBar({Key? key, required this.skill_experience_points})
      : super(key: key);

  @override
  State<ProgressBar> createState() => _ProgressBar(skill_experience_points);
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _ProgressBar extends State<ProgressBar> with TickerProviderStateMixin {
  final double _skill_experience_points;
  late AnimationController controller;

  _ProgressBar(this._skill_experience_points);

  // @override
  // void initState() {
  //   controller = AnimationController(
  //     vsync: this,
  //     duration: const Duration(seconds: 5),
  //   )..addListener(() {
  //       setState(() {});
  //     });
  //   controller.repeat(reverse: true);
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     constraints: BoxConstraints(maxHeight: 50, maxWidth: 175),
  //     child: Padding(
  //       padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
  //       child: Column(
  //         children: <Widget>[
  //           Flexible(
  //               child: LinearProgressIndicator(
  //             value: controller.value,
  //           )),
  //         ],
  //       ),
  //     ),
  //   );
  // }
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
