import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final String loginImage = 'assets/login.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Login',
                  style: TextStyle(fontSize: 30, color: Colors.black)),
              Text(
                  'Safe platform for you to share your thoughts and engage with others.',
                  style: TextStyle(fontSize: 15, color: Colors.black)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 1,
                    child: SvgPicture.asset(loginImage,
                        semanticsLabel: 'Login Page')),
              ),
              RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/google.png',
                        height: MediaQuery.of(context).size.height * 0.05),
                    Text(
                      'Login with Google',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                onPressed: () {
                  //Navigator.pushNamed(context, '/home');
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
