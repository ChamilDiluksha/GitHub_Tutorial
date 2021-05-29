import 'package:flutter/material.dart';
import 'package:github_tutorial/Models/gitmodel.dart';
import 'package:github_tutorial/Utils/DBHelper.dart';
import 'package:github_tutorial/Widgets/NavDrawer.dart';
import 'package:github_tutorial/screens/AdminScreen/EditGitStep.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Admin"),
      ),
      drawer: NavDrawer(),
      body: Column(
        children: <Widget>[
          _list(),
        ],
      ),
    );
  }

  _showSuccessfulDeletedAlert(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Git Step Deleted !!')));
  }

  _list() => Expanded(
      child: Container(
          margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: ListView.builder(
            padding: EdgeInsets.all(5.0),
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    leading: Image(
                      image: AssetImage("images/GitMasters.png"),
                      height: 35.0,
                      width: 35.0,
                    ),
                    title: Text(
                      _gitmodels[index].command.toUpperCase(),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(_gitmodels[index].description),
                    trailing: IconButton(
                        icon: Icon(
                          Icons.delete_sweep,
                          color: Colors.black,
                        ),
                        onPressed: () async {
                          await _databaseHelper
                              .deleteCommands(_gitmodels[index].id);
                          _showSuccessfulDeletedAlert(context);
                          _refreshCommandList();
                        }),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => EditGitStep(
                              gitmodel: _gitmodels[index],
                            )),
                      );
                    },
                  ),
                  Divider(
                    height: 5.0,
                  )
                ],
              );
            },
            itemCount: _gitmodels.length,
          )));
}
