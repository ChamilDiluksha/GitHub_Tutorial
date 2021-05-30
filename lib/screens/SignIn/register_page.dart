import 'package:flutter/material.dart';
import 'package:github_tutorial/Models/user.dart';
import 'package:github_tutorial/Utils/DBHelper.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int _counter = 0;

  User _user = User();

  List<User> _users = [];

  final _formKey = GlobalKey<FormState>();

  DatabaseHelper _dbHelper;

  @override
  void initState() {
    super.initState();

    setState(() {
      _dbHelper = DatabaseHelper.instance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height*0.3,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(40)),
                ),
                child: Center(
                  child: Image.asset(
                    "images/GitMasters.png",
                    width: 120,
                    height: 120,
                  ),
                ),
              ),
              _form(),
            ],
          ),
        ),
      ),
    );
  }

  _form() => Container(
    margin: const EdgeInsets.only(top: 85),
    color: Colors.white,
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    child: Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
              'REGISTER',
              style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold)
          ),
          Container(
            margin: EdgeInsets.only(top: 60),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Color(0xFFEEEEEE),
            ),
            padding: EdgeInsets.only(left: 10),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Username or Email',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.black,
                  size: 30,
                ),
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.name,
              onSaved: (val) => setState(() => _user.username = val),
              validator: (val) => (val.length==0 ? 'Required Field.!': null),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Color(0xFFEEEEEE),
            ),
            padding: EdgeInsets.only(left: 10),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                prefixIcon: Icon(
                  Icons.vpn_key,
                  color: Colors.black,
                  size: 30,
                ),
                border: InputBorder.none,
              ),
              obscureText: true,
              onSaved: (val) => setState(() => _user.password = val),
              validator: (val) => (val.length==0 ? 'Required Field.!': null),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                color: Colors.black,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                onPressed: () => _onSubmit(),
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:
                EdgeInsets.only(top: 40),
                child: Text(
                  'Already Registred?',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, top:40),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => LoginPage())
                    );
                  },
                  child: Text(
                    'LOG IN',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  _onSubmit() async {
    var form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      await _dbHelper.insertContact(_user);
      _displaySuccess(context);
      form.reset();
    }
  }

  _list() => Expanded(
      child: Card(
          margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemBuilder: (context, index) {
              return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(_users[index].username),
                      subtitle: Text(_users[index].password),
                    ),
                    Divider(
                        height: 5.0
                    )
                  ]
              );
            },
            itemCount: _users.length,
          )
      )
  );
}

Widget _textInput({controller, hint, icon}) {
  return Container(
    margin:
    EdgeInsets.only(top: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      color: Color(0xFFCFD8DC),
    ),
    padding: EdgeInsets.only(left: 10),
    child: TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
        prefixIcon: Icon(icon),
      ),
      obscureText: true,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
    ),
  );
}

_displaySuccess(BuildContext context) {
  final snackBar = SnackBar(
    content: Text('Registration Success..'),
    backgroundColor: Colors.grey,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}