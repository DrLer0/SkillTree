import 'package:flutter/material.dart';
import 'package:skilltree_app/widgets/widgets.dart';
import 'package:skilltree_app/models/models.dart';
import 'package:skilltree_app/data/data.dart';

class SkillScreen extends StatefulWidget {
  const SkillScreen({Key? key}) : super(key: key);

  @override
  State<SkillScreen> createState() => _SkillScreenState();
}

class _SkillScreenState extends State<SkillScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();
  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: _SkillScreenMobile(scrollController: _trackingScrollController),
    );
  }
}

class _SkillScreenMobile extends StatelessWidget {
  final TrackingScrollController scrollController;
  const _SkillScreenMobile({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        const SliverAppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Skill Tree',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2),
          ),
          centerTitle: true,
          floating: true,
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            final Skill skillItem = skill_list[index];
            return SkillContainer(skill: skillItem);
          },
          childCount: skill_list.length,
        ))
      ],
    );
  }
}
