import 'package:flutter/material.dart';
import 'package:github_tutorial/Models/gitmodel.dart';

class StepDetails extends StatefulWidget {

  final Gitmodel items;

  StepDetails({this.items});

  @override
  _StepDetailsState createState() => _StepDetailsState();
}

class _StepDetailsState extends State<StepDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            snap: true,
            floating: true,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(70.0))),
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: const Radius.circular(70),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF303030),Color(0xFF212121)],
                        end: Alignment.bottomCenter,
                        begin: Alignment.topCenter,
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text('${widget.items.command.toUpperCase()}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate(
            [
              SizedBox(height: 15.0,),
              ListTile(
                title: Text(
                  widget.items.command,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  "All Steps",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 15.0,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "DESCRIPTION",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              SizedBox(height: 10.0,),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
                child: Text(
                  widget.items.description,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          ),
        ],
      ),
    );
  }
}
