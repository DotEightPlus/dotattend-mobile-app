import 'package:dot_attend/resources/auth_methods.dart';
import 'package:dot_attend/screens/auth/background.dart';
import 'package:dot_attend/screens/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _usernameTextEditingController =
      TextEditingController();
  TextEditingController _matricNoTextEditingController =
      TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();
  TextEditingController _confirmPasswordTextEditingController =
      TextEditingController();
  TextEditingController _nameTextEditingController = TextEditingController();
  TextEditingController _mobileNoTextEditingController =
      TextEditingController();
  TextEditingController _emailTextEditingController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  AuthMethods _authMethods = AuthMethods();
  bool _isLoading = false;

  /// Check if form is valid before perform login or signup
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (_passwordTextEditingController.text ==
        _confirmPasswordTextEditingController.text) {
      if (form.validate()) {
        form.save();
        return true;
      }
    }
    return false;
  }

  validateAndSubmit() async {
    print("authentication process");
    if (_validateAndSave()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _authMethods.signUp(_emailTextEditingController.text,
            _passwordTextEditingController.text);
        User currentUser;
        currentUser = _auth.currentUser;

        await _authMethods.sendEmailVerification();

        //FirebaseUser user = await _auth.currentUser;
        await _authMethods.addDataToDb(
          currentUser: currentUser,
          email: _emailTextEditingController.text.trim(),
          username: _usernameTextEditingController.text.trim(),
          password: _passwordTextEditingController.text.trim(),
          mobileNo: _mobileNoTextEditingController.text.trim(),
          matricNo: _matricNoTextEditingController.text.trim(),
          name: _nameTextEditingController.text.trim(),
        );

        String userId = currentUser.uid;
        _showVerifyEmailSentDialog();
        print('Signed up user: $userId');
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
        });
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  _showVerifyEmailSentDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content:
              new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                //_changeFormToLogin();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: Stack(
          children: [
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "REGISTER",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2661FA),
                          fontSize: 36),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTextEditingController,
                    decoration: InputDecoration(labelText: "Email"),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _nameTextEditingController,
                    decoration: InputDecoration(labelText: "Name"),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: _mobileNoTextEditingController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(labelText: "Mobile Number"),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: _usernameTextEditingController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: "Username"),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: _matricNoTextEditingController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: "Matric No."),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: _passwordTextEditingController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: _confirmPasswordTextEditingController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(labelText: "Confirm Password"),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: RaisedButton(
                    onPressed: () => validateAndSubmit,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: size.width * 0.5,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: new LinearGradient(colors: [
                            Color.fromARGB(255, 255, 136, 34),
                            Color.fromARGB(255, 255, 177, 41)
                          ])),
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        "SIGN UP",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()))
                    },
                    child: Text(
                      "Already Have an Account? Sign in",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2661FA)),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
