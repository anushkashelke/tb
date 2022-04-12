//sign up page
import 'package:flutter/material.dart';
import 'package:timbrebells/Utils/Image_picker.dart';
import 'package:timbrebells/resources/auth_method.dart';
import 'package:timbrebells/text_field_input.dart';
import 'package:timbrebells/Home_Page/Home.dart';
import 'package:timbrebells/Bottom_navigation_bar.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }

  void SignUpUser() async {
    String res = await auth_methods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text);
    if (res == "success") {
      Navigator.of(context).pushReplacement(   //through push replacement it won't navigate back to sign up page from the home page
          MaterialPageRoute(builder: (context) => const BottombarWidget()));
    } else {
      showSnackBar(context, 'some error occured');
    }
  }

  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Timbrebells'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFieldInput(
                  hintText: 'Enter your username',
                  textInputType: TextInputType.text,
                  textEditingController: _usernameController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15.0, bottom: 0.0),
                child: TextFieldInput(
                  hintText: 'Enter your password',
                  textInputType: TextInputType.text,
                  textEditingController: _passwordController,
                  isPass: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
                child: TextFieldInput(
                  hintText: 'Enter your Email Address',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                ),
              ),
              Container(
                height: 43,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,),
                child: TextButton(
                  onPressed: () {   //to jump on pages
                    SignUpUser();
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                  ),
                ),
              ),
              /*InkWell(
                onTap: () async {
                  SignUpUser();
                },
                child:Padding(
                  padding: EdgeInsets.all(10),
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
/*
Container(

                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
 */
/*obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Password',
                    )),*/
/*child: TextField(
                    decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Email id',
                )),*/
