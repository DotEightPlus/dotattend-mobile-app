import 'package:dot_attend/screens/auth/background.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  FocusNode _focusNode;
  TextEditingController _emailController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  void initState() {
    _focusNode = FocusNode();
    _emailController = TextEditingController();
    _emailController.text = '';
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Widget _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _label(),
              SizedBox(
                height: 50,
              ),
              _entryFeild('Enter email', controller: _emailController),
              // SizedBox(height: 10,),
              _submitButton(context),
            ],
          )),
    );
  }

  Widget _entryFeild(String hint,
      {TextEditingController controller, bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
        validator: (value) {
          return value.isEmpty ? "Email field cannot be empty" : null;
        },
        focusNode: _focusNode,
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
            fontStyle: FontStyle.normal, fontWeight: FontWeight.normal),
        obscureText: isPassword,
        decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: Colors.blue)),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10)),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: Color(0xFF2661FA),
          onPressed: () {},
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text('Submit', style: TextStyle(color: Colors.white)),
        ));
  }

  Widget _label() {
    return Container(
        child: Column(
      children: <Widget>[
        customText('Forget Password',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 15),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: customText(
              'Enter your email address below to receive password reset instruction',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54),
              textAlign: TextAlign.center),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Background(
        child: Stack(children: [
          _body(context),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(),
        ]),
      ),
    );
  }

  Widget customText(String msg,
      {Key key,
      TextStyle style,
      TextAlign textAlign = TextAlign.justify,
      TextOverflow overflow = TextOverflow.visible,
      BuildContext context,
      bool softwrap = true}) {
    if (msg == null) {
      return SizedBox(
        height: 0,
        width: 0,
      );
    } else {
      if (context != null && style != null) {
        var fontSize =
            style.fontSize ?? Theme.of(context).textTheme.bodyText2.fontSize;
        style = style.copyWith(
          fontSize:
              fontSize - (MediaQuery.of(context).size.width <= 375 ? 2 : 0),
        );
      }
      return Text(
        msg,
        style: style,
        textAlign: textAlign,
        overflow: overflow,
        softWrap: softwrap,
        key: key,
      );
    }
  }
}
