import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hagglex_test/cubit/login_cubit.dart';
import 'package:hagglex_test/screens/dashboard.dart';
import 'package:hagglex_test/screens/register.dart';
import 'package:hagglex_test/screens/verify_email.dart';
import 'package:hagglex_test/utils/theming.dart';

import 'verify_email.dart';

class Login extends StatelessWidget {
  static const String routeName = '/login';
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.mainPurple,
      body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoggingError) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text("${state.error}"),
                duration: Duration(seconds: 3),
              ));
            } else if (state is LoggedInUnverified) {
              Navigator.pushNamed(context, VerifyEmail.routeName);
            } else if (state is LoggedIn) {
              Navigator.pushNamed(context, Dashboard.routeName);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 154,
                  ),
                  Row(
                    children: [
                      Text(
                        'Welcome!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontFamily: 'BasisGrotesqueProBold',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  TextFormField(
                    cursorColor: Colors.white,
                    controller: email,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Email Address",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                      border: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    obscureText: true,
                    cursorColor: Colors.white,
                    controller: password,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                      border: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {

                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      if (email.text.trim() != "" && password.text.trim() != "") {
                        BlocProvider.of<LoginCubit>(context)
                            .login(email: email.text, password: password.text);
                      } else {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text("You have empty fields"),
                          duration: Duration(seconds: 3),
                        ));
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppColors.yellow,
                          borderRadius: BorderRadius.circular(5)),
                      child: BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          if (state is LogginIn)
                            return Center(
                              child: Container(
                                  width: 17,
                                  height: 17,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.black),
                                  )),
                            );
                          return Center(
                            child: Text(
                              'LOG IN',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Register.routeName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'New user? Create a new account',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
