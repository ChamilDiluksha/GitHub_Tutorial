import 'package:flutter/material.dart';
import 'package:github_tutorial/Models/gitmodel.dart';

import 'UserNavDrawer.dart';

class seeALLSteps extends StatefulWidget {

  final List<Gitmodel> items;

  seeALLSteps({this.items});

  @override
  _seeALLStepsState createState() => _seeALLStepsState();
}

class _seeALLStepsState extends State<seeALLSteps> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: UserNav(),
      backgroundColor: Colors.black,
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: IconButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.close, color: Colors.white,size: 35.0,)
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        ListTile(
                          title: Text(
                            "Git Hub Tutorial",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            "All Steps",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                  ),
                  child: Container(
                    height: 600.0,
                    child: ListView.builder(
                      itemCount: widget.items.length,
                      itemBuilder: (context, index) {
                        return Column(
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
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              title: Text(
                                'Step ${index + 1} : ${widget.items[index].command}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                widget.items[index].description,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(height: 15.0,),
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
