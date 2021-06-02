import 'package:flutter/material.dart';
import 'package:github_tutorial/Models/gitmodel.dart';
import 'package:github_tutorial/Utils/DBHelper.dart';
import 'package:github_tutorial/Widgets/NavDrawer.dart';

import 'AdminHome.dart';

class addGitSteps extends StatefulWidget {

  final Gitmodel items;

  const addGitSteps({this.items});

  @override
  _addGitStepsState createState() => _addGitStepsState();
}

class _addGitStepsState extends State<addGitSteps> {

  final _formKey = GlobalKey<FormState>();
  Gitmodel _gitmodel = Gitmodel();
  List<Gitmodel> _gitmodels = [];
  DatabaseHelper _databaseHelper;
  final _ctrlCommand = TextEditingController();
  final _ctrlDescription = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _databaseHelper = DatabaseHelper.instance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
              "Add Git Steps",
              style: TextStyle(
                  color: Colors.white
              )
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: (){
            Navigator.pop(context, AdminHome());
          },
        ),
      ),
      drawer: NavDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _form(),
            ],
          ),
        ),
      ),
    );
  }

  _form() => Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                child: new TextFormField (
                  decoration: new InputDecoration(
                      labelText: 'Git Command',
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(color: Colors.grey[800]),
                      fillColor: Colors.grey[300]),
                  onSaved: (val) => setState(() => _gitmodel.command = val),
                  validator: (val) =>
                  (val.length == 0 ? 'This field is required' : null),
                ),
                padding: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              ),
              Container(
                child: new TextFormField (
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  minLines: 5,
                  maxLines: 15,
                  textAlign: TextAlign.start,
                  decoration: new InputDecoration(
                      labelText: 'Description',
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      alignLabelWithHint: true,
                      hintStyle: new TextStyle(color: Colors.grey[800]),
                      fillColor: Colors.grey[300]),
                  onSaved: (val) => setState(() => _gitmodel.description = val),
                  validator: (val) =>
                  (val.length == 0 ? 'This field is required' : null),
                ),
                padding: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: RaisedButton(
                    onPressed: () => _onSubmit(),
                    child: Text('SUBMIT'),
                    color: Colors.black,
                    padding: EdgeInsets.only(left: 50, right: 50),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ],
          )
      )
  );

  _onSubmit() async {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (_gitmodel.id == null)
        await _databaseHelper.insertCommands(_gitmodel);
      else
        await _databaseHelper.updateCommands(_gitmodel);
      _displaySuccess(context);
      _resetForm();
    }
  }

  _resetForm() {
    setState(() {
      _formKey.currentState.reset();
      _ctrlCommand.clear();
      _ctrlDescription.clear();
      _gitmodel.id = null;
    });
  }

  _displaySuccess(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () => {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminHome())
        ) },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("The Record Added"),
      content: Text("The new Git Command is Added Successfully!!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }
}
