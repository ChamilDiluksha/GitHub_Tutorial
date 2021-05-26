import 'package:flutter/material.dart';
import 'package:github_tutorial/Models/gitmodel.dart';
import 'package:github_tutorial/Utils/DBHelper.dart';
import 'package:github_tutorial/Widgets/NavDrawer.dart';
import 'package:github_tutorial/screens/AdminScreen/AdminHome.dart';

class EditGitStep extends StatefulWidget {

  final Gitmodel gitmodel;

  const EditGitStep({this.gitmodel});

  @override
  _EditGitStepState createState() => _EditGitStepState();
}

class _EditGitStepState extends State<EditGitStep> {

  final _formKey = GlobalKey<FormState>();
  DatabaseHelper _databaseHelper;
  final _ctrlCommand = TextEditingController();
  final _ctrlDescription = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _databaseHelper = DatabaseHelper.instance;
    });
    _SetData();
  }

  _SetData() {
    setState(() {
      _ctrlCommand.text = widget.gitmodel.command;
      _ctrlDescription.text =  widget.gitmodel.description;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _form(),
          ],
        ),
      ),
    );
  }

  _form() => Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _ctrlCommand,
                decoration: InputDecoration(labelText: 'Git Command'),
                onSaved: (val) => setState(() => widget.gitmodel.command = val),
                validator: (val) =>
                (val.length == 0 ? 'This field is required' : null),
              ),
              TextFormField(
                controller: _ctrlDescription,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (val) => setState(() => widget.gitmodel.description = val),
                validator: (val) =>
                (val.length == 0 ? 'This field is required' : null),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: RaisedButton(
                  onPressed: () => _onSubmit(),
                  child: Text('Update'),
                  color: Colors.black,
                  textColor: Colors.white,
                ),
              ),
            ],
          )
      )
  );

  _onSubmit() async {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (widget.gitmodel.id == null)
        await _databaseHelper.insertCommands(widget.gitmodel);
      else
        await _databaseHelper.updateCommands(widget.gitmodel);
      _resetForm();
    }
  }

  _resetForm() {
    setState(() {
      _formKey.currentState.reset();
      _ctrlCommand.clear();
      _ctrlDescription.clear();
      widget.gitmodel.id = null;
    });
  }
}
