import 'package:developerweek/home.dart';
import 'package:developerweek/utils/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final String loginImage = 'assets/login.svg';
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error initializing Firebase');
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppBar(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    centerTitle: false,
                    title: Text(
                      'Login',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(color: Colors.black)),
                    ),
                    automaticallyImplyLeading: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 1,
                        child: SvgPicture.asset(loginImage,
                            semanticsLabel: 'Login Page')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Meet other empowering creators and let your creativity run free.',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(fontSize: 25)),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  _isSigningIn
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : OutlinedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              _isSigningIn = true;
                            });

                            User? user = await Authentication.signInWithGoogle(
                                context: context);

                            setState(() {
                              _isSigningIn = false;
                            });

                            if (user != null) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => Home(
                                      //user: user,
                                      ),
                                ),
                              );
                            }
                            setState(() {
                              _isSigningIn = false;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                  image: AssetImage("assets/google.png"),
                                  height: 35.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text('Sign in with Google',
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w600,
                                      ))),
                                )
                              ],
                            ),
                          ),
                        ),
                ],
              );
            }
            return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue));
          }),
    );
  }
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Container(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text('Login',
//                   style: TextStyle(fontSize: 30, color: Colors.black)),
//               Text(
//                   'Safe platform for you to share your thoughts and engage with others.',
//                   style: TextStyle(fontSize: 15, color: Colors.black)),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
//                 child: Container(
//                     height: MediaQuery.of(context).size.height * 0.4,
//                     width: MediaQuery.of(context).size.width * 1,
//                     child: SvgPicture.asset(loginImage,
//                         semanticsLabel: 'Login Page')),
//               ),
//               FutureBuilder(
//                 future: Authentication.initializeFirebase(context: context),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     return Text('Error initializing Firebase');
//                   } else if (snapshot.connectionState == ConnectionState.done) {
//                     return              RaisedButton(
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: [
//                      Image.asset('assets/google.png',
//                          height: MediaQuery.of(context).size.height * 0.05),
//                      Text(
//                      'Login with Google',
//                        style: TextStyle(fontSize: 15),
//                      ),
//                    ],
//                  ),
//                  onPressed: () {
//                    //Navigator.pushNamed(context, '/home');
//                  },
//                ),
//                   }
//                   return CircularProgressIndicator();
//               )
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }
}
