import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skilltree_app/widgets/widgets.dart';
import 'package:skilltree_app/models/models.dart';
import 'package:skilltree_app/res/custom_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skilltree_app/utils/authentication.dart';
import 'package:skilltree_app/screens/screens.dart';

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

class _SkillScreenMobile extends StatefulWidget {
  final TrackingScrollController scrollController;
  _SkillScreenMobile({Key? key, required this.scrollController})
      : super(key: key);

  @override
  State<_SkillScreenMobile> createState() => _SkillScreenMobileState();
}

class _SkillScreenMobileState extends State<_SkillScreenMobile> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> skillStream =
      FirebaseFirestore.instance
          .collection('skill')
          .snapshots(includeMetadataChanges: false);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: widget.scrollController,
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.black54,
          title: const Text(
            'Skill Tree',
            style: TextStyle(
                color: Color(0xFF2C384A),
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2),
          ),
          actions: [
            PopupMenuButton<int>(
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(value: 0, child: Text('Add skill')),
                PopupMenuItem<int>(value: 1, child: Text('Logout')),
              ],
            ),
          ],
          centerTitle: true,
          floating: true,
        ),
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: skillStream,
            builder: (BuildContext context, snapshot) {
              // if (snapshot.hasData) {
              return SliverList(
                  delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final Skill skillItem =
                      Skill.fromJson(snapshot.data!.docs[index].data());
                  return SkillContainer(skill: skillItem);
                },
                childCount: snapshot.hasData ? snapshot.data!.size : 0,
              ));
            }),
      ],
    );
  }

  Future<void> handleClick(int item) async {
    switch (item) {
      case 1:
        await Authentication.signOut(context: context);
        Navigator.of(context).pushReplacement(_routeToSignInScreen());

        break;
      case 0:
        Navigator.of(context).pushReplacement(_routeToAddSkillScreen());
        break;
    }
  }

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _routeToAddSkillScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AddSkillScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
