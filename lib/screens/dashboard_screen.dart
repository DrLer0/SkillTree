import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skilltree_app/screens/screens.dart';
// import 'package:skill_tree/screens/sign_in_screen.dart';

import 'package:skilltree_app/res/custom_colors.dart';
import 'package:skilltree_app/utils/authentication.dart';
import 'package:skilltree_app/widgets/widgets.dart';
// import '../widgets/app_bar_title.dart';
// import 'addskill_screen.dart';

class DashboardScreen extends StatefulWidget {
  final User _user;

  const DashboardScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.firebaseNavy,
        title: AppBarTitle(),
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (item) => handleClick(item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(value: 0, child: Text('Add skill')),
              PopupMenuItem<int>(value: 1, child: Text('Logout')),
            ],
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(3.0),
          children: <Widget>[
            makeDashboardItem("Ordbog", Icons.book),
            makeDashboardItem("Alphabet", Icons.alarm),
            makeDashboardItem("Alphabet", Icons.alarm),
            makeDashboardItem("Alphabet", Icons.alarm),
            makeDashboardItem("Alphabet", Icons.alarm),
            makeDashboardItem("Alphabet", Icons.alarm)
          ],
        ),
      ),
    );
  }

  Card makeDashboardItem(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: new InkWell(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
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
