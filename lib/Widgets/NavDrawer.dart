import 'package:flutter/material.dart';
import 'package:github_tutorial/screens/AdminScreen/AddGitSteps.dart';
import 'package:github_tutorial/screens/AdminScreen/AdminHome.dart';
import 'package:github_tutorial/screens/SignIn/login_page.dart';
import 'package:github_tutorial/screens/UserScreen/gitHubSteps.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key key}) : super(key: key);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: const Radius.circular(0),
                ),
                child: Container(
                  height: 200.0,
                  child: DrawerHeader(
                      child: Column(
                        children: <Widget>[
                          Image(
                            image: AssetImage("images/GitMasters.png"),
                            height: 65.0,
                            width: 65.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 25.0),
                            child: Text(
                              "Git Hub Admin",
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF303030),Color(0xFF212121)],
                          end: Alignment.bottomCenter,
                          begin: Alignment.topCenter,
                        )
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25.0,),
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white
                ),
                padding:  EdgeInsets.all(6),
                child: Image.asset(
                  "images/GitMasters.png",
                  width: 20.0,
                  height: 20.0,
                ),
              ),
              title: Text(
                'Add Steps' ,
                style:TextStyle(
                    color: Colors.black87,
                    fontSize: 18.0,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => addGitSteps())
                );
              },
            ),

            ListTile(
              leading: Icon(
                Icons.list,
                color: Colors.black87,
              ),
              title: Text(
                'View All Git Steps' ,
                style:TextStyle(
                  color: Colors.black87,
                  fontSize: 18.0,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => AdminHome())
                );
              },
            ),

            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.black87,
              ),
              title: Text(
                'User View' ,
                style:TextStyle(
                  color: Colors.black87,
                  fontSize: 18.0,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => gitHubSteps())
                );
              },
            ),

            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.black87,
              ),
              title: Text(
                'Sign Out' ,
                style:TextStyle(
                  color: Colors.black87,
                  fontSize: 18.0,
                ),
              ),
              onTap: () {
                _logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  _logout(BuildContext context) async {
    final token = await SharedPreferences.getInstance();

    token.remove("Name");

    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
