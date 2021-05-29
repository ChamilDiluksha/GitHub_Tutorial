import 'package:flutter/material.dart';
import 'package:github_tutorial/Models/gitmodel.dart';
import 'package:github_tutorial/Utils/DBHelper.dart';
import 'package:github_tutorial/Widgets/UserNavDrawer.dart';
import 'package:github_tutorial/Widgets/stepsLIstWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../SignIn/login_page.dart';

class gitHubSteps extends StatefulWidget {

  @override
  _gitHubStepsState createState() => _gitHubStepsState();
}

class _gitHubStepsState extends State<gitHubSteps> {


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        drawer: UserNav(),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 28),
          children: <Widget>[
            Container(
              height: 260.0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: const Radius.circular(70),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black,Colors.black],
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter,
                    )
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _logout(context);
                              },
                            ),
                          ],
                        ),
                        Image(
                          image: AssetImage("images/GitMasters.png"),
                          height: 125,
                          width: 125,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'Git Hub Tutorial',
                          style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
           stepsLIstWidget(),
          ],
        ),
      );
  }


  _logout(BuildContext context) async {
    final token = await SharedPreferences.getInstance();
    final name = token.getString("Name");

      if(name == "Admin"){

      }
      else {
        token.remove("Name");

        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
  }
}
