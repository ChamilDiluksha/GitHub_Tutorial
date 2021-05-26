import 'package:flutter/material.dart';
import 'package:github_tutorial/Models/gitmodel.dart';
import 'package:github_tutorial/Utils/DBHelper.dart';
import 'package:github_tutorial/screens/UserScreen/gitHubSteps.dart';
import 'package:github_tutorial/screens/UserScreen/gitStepsDetails.dart';

class UserNav extends StatefulWidget {
  const UserNav({Key key}) : super(key: key);

  @override
  _UserNavState createState() => _UserNavState();
}

class _UserNavState extends State<UserNav> {

  Gitmodel _gitmodel = Gitmodel();
  List<Gitmodel> _gitmodels = [];
  DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    setState(() {
      _databaseHelper = DatabaseHelper.instance;
    });
    _refreshCommandList();
  }

  _refreshCommandList() async {
    List<Gitmodel> x = await _databaseHelper.retrieveCommands();
    setState(() {
      _gitmodels = x;
    });
  }

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
                            "Git Hub Tutorial Steps",
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

            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.black87,
              ),
              title: Text(
                'Home' ,
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
            Container(
              height: 600.0,
              child: ListView.builder(
                itemCount: _gitmodels.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => StepDetails(
                              items : _gitmodels[index],
                            )
                        ),
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Colors.white10
                            ),
                            padding:  EdgeInsets.all(6),
                            child: Image.asset(
                              "images/GitMasters.png",
                              width: 23,
                              height: 23,
                            ),
                          ),
                          title: Text(
                            'Step ${index + 1} : ${_gitmodels[index].command}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 15.0,),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
