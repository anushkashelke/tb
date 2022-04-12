//Sign in Page
import 'package:flutter/material.dart';
import 'package:timbrebells/Utils/Image_picker.dart';
import 'package:timbrebells/text_field_input.dart';
import 'package:timbrebells/resources/auth_method.dart';
import 'package:timbrebells/Home_Page/Home.dart';
import 'package:timbrebells/Bottom_navigation_bar.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  void dispose(){
    super.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }
  void LogIn() async{
    String res = await auth_methods().LogIn(email: _emailController.text ,password: _passwordController.text);
    if(res=="success"){   //if login is successful go to home page
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const BottombarWidget()));
    }
    else{
       showSnackBar(context, "Invalid email/password");
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
            mainAxisAlignment:MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFieldInput(
                  hintText:'Enter your email',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController ,
                ),
              ),
              Padding(
                padding:EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15.0, bottom:15.0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFieldInput(
                  hintText:'Enter your password',
                  textInputType: TextInputType.text,
                  textEditingController: _passwordController ,
                  isPass: true,
                ),
              ),

              Container(
                height: 43,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,),
                child: TextButton(
                  onPressed: () {   //to jump on pages
                    LogIn();
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                  ),
                ),
              ),
              /*TextButton(
                onPressed: () {
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),*/
              /*InkWell(
                onTap: () async{
                  LogIn();
                },
                child:Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 15),
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
