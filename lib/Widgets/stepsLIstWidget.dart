import 'package:flutter/material.dart';
import 'package:github_tutorial/Models/gitmodel.dart';
import 'package:github_tutorial/Utils/DBHelper.dart';
import 'package:github_tutorial/screens/UserScreen/gitStepsDetails.dart';
import 'package:github_tutorial/Widgets/seeAllStepsWIdget.dart';

class stepsLIstWidget extends StatefulWidget {
  const stepsLIstWidget({Key key}) : super(key: key);

  @override
  _stepsLIstWidgetState createState() => _stepsLIstWidgetState();
}

class _stepsLIstWidgetState extends State<stepsLIstWidget> {

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
    _refreshCommandList();

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Step by Step ',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => seeALLSteps(
                          items : _gitmodels,
                        )
                    ),
                  );
                },
                child: Text(
                  'See All Steps',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15.0,),
        Container(
          height: 450.0,
          child: _StepList(context, _gitmodels),
        ),
      ],
    );
  }


  Widget _StepList(BuildContext context, List<Gitmodel> stepModel){

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stepModel.length,
        itemBuilder: (BuildContext context, int index){

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => StepDetails(
                      items : stepModel[index],
                    )
                ),
              );
            },
            child: Container(
                margin: EdgeInsets.all(10.0),
                width: 300.0,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Positioned(
                      bottom: 5.0,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          bottom: const Radius.circular(25.0),
                          top: const Radius.circular(25.0),
                        ),
                        child: Container(
                          height: 300.0,
                          width: 300.0,
                          color: Colors.black26,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20.0, top: 10.0, left: 10.0, right: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 15.0),
                                  child: Text(
                                    'Step ${index + 1} ',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0,),
                                Expanded(
                                  child: ListView(
                                    children: <Widget>[
                                      Text(
                                        stepModel[index].description,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                bottom: const Radius.circular(25.0),
                              ),
                              child: Container(
                                height: 120.0,
                                width: 300.0,
                                color: Colors.black54,
                              ),
                            ),
                            Positioned(
                              left: 15.0,
                              bottom: 45.0,
                              child: Container(
                                width: 300.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      stepModel[index].command,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            ),
          );
        }
    );
  }
}


