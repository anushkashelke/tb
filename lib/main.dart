import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timbrebells/Welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timbrebells/Bottom_navigation_bar.dart';
import 'package:timbrebells/providers/Userprovider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //initialize FlutterFire
  {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //for state management
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        /*StreamBuilder(stream: FireBase) */
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //snapshot=contains data from a database location
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                //if user is authenticated
                return const BottombarWidget();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return const Welcome();
          },
        ),
      ),
    );
  }
}

/*initialRoute: 'Welcome', //page name
      routes: {
        'Welcome': (context) => Welcome(), //class name
        'Sign in': (context) => SignIn(),
        'Sign up': (context) => SignUp(),
      },  */

/*import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Timbrebells'),
        ),
        body:SafeArea(
          child:Column(
              children: <Widget>[
                Text(
                  'Timbrebells',
                   textAlign:TextAlign.center,
                   style:TextStyle(
                    fontSize:30.0,
                    fontFamily:'Tangerine',
                    color:Colors.blue[900],
                    fontWeight:FontWeight.bold,
                  ),
                ),
                SizedBox(
                   height:10.0,
                ),
                Text(
                  'Tuning together for global melody',
                  style:TextStyle(
                    fontSize:20.0,
                    fontFamily:'Tangerine',
                    color:Colors.black,
                  )
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0,10.0,0.0,0.0),
                  child:FlatButton(
                    child: Text('Sign Up', style: TextStyle(fontSize: 20.0),),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    onPressed: () {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10.0,10.0,0.0,0.0),
                  child: FlatButton(
                    child: Text('Sign In', style: TextStyle(fontSize: 20.0),),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    onPressed: () {},
                  ),
                ),
              ]
          )
          )
      ),
    );
  }
}
*/
