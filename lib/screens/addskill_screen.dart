import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skilltree_app/screens/screens.dart';
import 'package:skilltree_app/widgets/widgets.dart';
import 'package:skilltree_app/res/custom_colors.dart';
import 'package:skilltree_app/utils/authentication.dart';

class AddSkillScreen extends StatefulWidget {
  @override
  _AddSkillScreenState createState() => _AddSkillScreenState();
}

class _AddSkillScreenState extends State<AddSkillScreen> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _notesFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _nameFocusNode.unfocus();
        _notesFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: CustomColors.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CustomColors.firebaseNavy,
          title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 8),
                Text(
                  'Create Skill',
                  style: TextStyle(
                    color: CustomColors.firebaseOrange,
                    fontSize: 18,
                  ),
                )
              ]),
          actions: <Widget>[
            PopupMenuButton<int>(
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(value: 0, child: Text('Dashboard')),
                PopupMenuItem<int>(value: 1, child: Text('Logout')),
              ],
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: SingleChildScrollView(
              child: AddSkillForm(
                nameFocusNode: _nameFocusNode,
                notesFocusNode: _notesFocusNode,
                // startDateFocusNode: _startDateFocusNode,
                // endDateFocusNode: _endDateFocusNode,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleClick(int item) async {
    switch (item) {
      case 1:
        await Authentication.signOut(context: context);
        Navigator.of(context).pushReplacement(_routeToSignInScreen());

        break;
      case 0:
        Navigator.of(context).pushReplacement(_routeToSignInScreen());
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
}
