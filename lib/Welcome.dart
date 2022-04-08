import 'package:flutter/material.dart';
import 'package:timbrebells/Screens/Sign in.dart';
import 'package:timbrebells/Screens/Sign up.dart';

class Welcome extends StatefulWidget {   //stful
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Timbrebells'),
        ),
        body: SafeArea(
          child: Column(children: <Widget>[
            Text(
              'Timbrebells',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                fontFamily: 'Tangerine',
                color: Colors.blue[900],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text('Tuning together for global melody',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Tangerine',
                  color: Colors.black,
                )),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              Container(
                height: 43,
                width: 130,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,),
                child: TextButton(
                  onPressed: () {   //to jump on pages
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignIn()),
                    );
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                height: 43,
                width: 130,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                  ),
                ),
              ),
          ],
            ),
          ]),
        ),
      ),
    );
  }
}
