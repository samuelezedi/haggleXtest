import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hagglex_test/cubit/verify_email_cubit.dart';
import 'package:hagglex_test/screens/dashboard.dart';
import 'package:hagglex_test/screens/success.dart';
import 'package:hagglex_test/utils/theming.dart';

class VerifyEmail extends StatelessWidget {
  static const String routeName = "/verify_page";

  TextEditingController code = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<VerifyEmailCubit>(context).resentCodeCount(10);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.mainPurple,
      body: SingleChildScrollView(
        child: BlocListener<VerifyEmailCubit, VerifyEmailState>(
          listener: (context, state) {
            if (state is VerifyEmailError) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text(state.error),
                duration: Duration(seconds: 3),
              ));
            } else if (state is EmailVerified) {
              Navigator.pushNamed(context, SuccessPage.routeName);
            } else if (state is VerificationCodeResent) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text("Verification Code Resent"),
                duration: Duration(seconds: 3),
              ));
            }
          },
          child: Column(
            children: [
              SizedBox(
                height: 65,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 50,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.lightPurple,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios_sharp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Verify your account',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'BasisGrotesqueProBold',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 70),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(),
                      child: Center(
                        child: Image.asset('assets/images/check.png'),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'We just sent a verification code to your email.\nPlease enter the code',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    _codeField(),
                    SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {
                        if (code.text.trim() != "") {
                          BlocProvider.of<VerifyEmailCubit>(context)
                              .verify(code.text);
                        } else {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text("You have empty fields"),
                            duration: Duration(seconds: 3),
                          ));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: AppColors.buttonGradient,
                            borderRadius: BorderRadius.circular(6)),
                        padding: EdgeInsets.all(15),
                        child: Center(
                          child: BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
                            builder: (context, state) {
                              // TODO: implement listener}
                              if (state is Verifying) {
                                return SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator());
                              } else {
                                return Text(
                                  'VERIFY ME',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'This code will expire in 10 minutes',
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            if (!(state is Verifying)) {
                              if (state is VerifyEmailInitial) {
                                if (state.initialTime == 0) {
                                  BlocProvider.of<VerifyEmailCubit>(context)
                                      .resendCode();
                                } else {
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                                    content: Text(
                                        "Hold on for about ${state.initialTime} seconds"),
                                    duration: Duration(seconds: 3),
                                  ));
                                }
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Resend Code',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  Widget _codeField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      cursorColor: Colors.black,
      controller: code,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: "Verification Code",
        hintStyle: TextStyle(color: Colors.black, fontSize: 14),
        border: UnderlineInputBorder(
            borderSide: new BorderSide(color: Colors.black)),
        focusedBorder: UnderlineInputBorder(
            borderSide: new BorderSide(color: Colors.black)),
        enabledBorder: UnderlineInputBorder(
            borderSide: new BorderSide(color: Colors.black)),
      ),
    );
  }
}
