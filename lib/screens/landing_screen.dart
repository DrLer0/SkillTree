import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skilltree_app/utils/authentication.dart';
import 'package:skilltree_app/widgets/widgets.dart';
import 'package:skilltree_app/res/custom_colors.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.firebaseNavy,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        'assets/skill_tree.png',
                        height: 80,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Text(
                    //   'FlutterFire',
                    //   style: TextStyle(
                    //     color: CustomColors.firebaseYellow,
                    //     fontSize: 40,
                    //   ),
                    // ),
                    // Text(
                    //   'Authentication',
                    //   style: TextStyle(
                    //     color: CustomColors.firebaseOrange,
                    //     fontSize: 40,
                    //   ),
                    // ),
                  ],
                ),
              ),
              FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GoogleSignInButton();
                  }
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      CustomColors.firebaseOrange,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
