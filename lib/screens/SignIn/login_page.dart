import 'package:flutter/material.dart';
import 'package:github_tutorial/Models/user.dart';
import 'package:github_tutorial/Utils/DBHelper.dart';
import 'package:github_tutorial/main.dart';
import 'package:github_tutorial/screens/AdminScreen/AdminHome.dart';
import 'package:github_tutorial/screens/SignIn/register_page.dart';
import 'package:github_tutorial/screens/UserScreen/gitHubSteps.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      body: Container(
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
    );
  }

  _form() => Container(
    margin: const EdgeInsets.only(top: 75),
    color: Colors.white,
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
    child: Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
              'LOGIN',
              style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold)
          ),
          Container(
            margin: EdgeInsets.only(top: 60),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
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
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
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
                  'Login',
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
                  'Need a Login?',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, top:40),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => RegisterPage())
                    );
                  },
                  child: Text(
                    'REGISTER',
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

  _onSubmit()  {
    var form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      _dbHelper.getUserbyEmail(_user.username, _user.password)
          .then((value) => _loginHandler(value, context));

      _dbHelper.fetchUsers();

      form.reset();
    }
  }
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

_loginHandler(bool state, BuildContext context) async {
  final token = await SharedPreferences.getInstance();
  final name = token.getString("Name");
  print("Name: "+name);

  if (state){
    if(name == "Admin"){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminHome())
      );
      _displaySuccess(context, 'Admin Login Success!');
    }
    else {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => gitHubSteps())
      );
      _displaySuccess(context, 'User Login Success!');
    }
  }
}

_displaySuccess(BuildContext context, message) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Colors.grey,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
