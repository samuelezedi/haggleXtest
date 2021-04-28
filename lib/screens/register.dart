import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hagglex_test/cubit/register_cubit.dart';
import 'package:hagglex_test/screens/select_country.dart';
import 'package:hagglex_test/screens/verify_email.dart';
import 'package:hagglex_test/utils/theming.dart';

class Register extends StatelessWidget {
  static const String routeName = '/register';
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController refCode = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RegisterCubit>(context).updatePhoneData();
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.mainPurple,
        body: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegistrationError) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text(state.error),
                duration: Duration(seconds: 3),
              ));
            } else if (state is UserRegistered) {
              Navigator.pushNamed(context, VerifyEmail.routeName);
            }
          },
          child: SingleChildScrollView(
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 70),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Create a new account',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      _emailAddressField(),
                      SizedBox(
                        height: 25,
                      ),
                      _passwordField(),
                      SizedBox(
                        height: 25,
                      ),
                      _userNameField(),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              var data = await Navigator.pushNamed(
                                  context, PickerPage.routeName);
                              BlocProvider.of<RegisterCubit>(context)
                                  .updatePhoneNumber(code: data);
                            },
                            child: BlocBuilder<RegisterCubit, RegisterState>(
                              builder: (context, state) {
                                // TODO: implement listener}

                                return Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(8),
                                        width: 20,
                                        height: 14,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  state is UpdatePhoneCode
                                                      ? state.flag
                                                      : "flags/nga.png",
                                                  package: countryCodePackageName,
                                                ),
                                                fit: BoxFit.cover)),
                                      ),
                                      Text(
                                          state is UpdatePhoneCode
                                              ? state.phoneCode
                                              : "+234",
                                          style: TextStyle(fontSize: 12)),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(child: _phoneNumberField()),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      _refCodeField(),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'by signing you agree to HaggieX terms and privacy policy',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {
                          print('here');
                          if (email.text.trim() != "" &&
                              phoneNumber.text.trim() != "" &&
                              username.text.trim() != "" &&
                              password.text.trim() != "") {
                            var currentState = (BlocProvider.of<RegisterCubit>(context).state as UpdatePhoneCode);
                            String prefix = currentState.phoneCode;
                            BlocProvider.of<RegisterCubit>(context).register(
                                email: email.text,
                                password: password.text,
                                phone: prefix+phoneNumber.text,
                                refCode: refCode.text,
                                username: username.text);
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
                            child: BlocBuilder<RegisterCubit, RegisterState>(
                              builder: (context, state) {
                                // TODO: implement listener}
                                if (state is Registering) {
                                  return SizedBox(width:16,height:16,child: CircularProgressIndicator());
                                } else {
                                  return Text(
                                    'SIGN UP',
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
                      )
                    ],
                  ),
                ),
                SizedBox(height: 25)
              ],
            ),
          ),
        ));
  }

  Widget _emailAddressField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.black,
      controller: email,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: "Email Address",
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

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      cursorColor: Colors.black,
      controller: password,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: "Password (Min 8 Characters)",
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

  Widget _userNameField() {
    return TextFormField(
      cursorColor: Colors.black,
      controller: username,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: "Create a username",
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

  Widget _phoneNumberField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      cursorColor: Colors.black,
      controller: phoneNumber,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: "Enter your phone number",
        hintStyle: TextStyle(color: Colors.black, fontSize: 12),
        border: UnderlineInputBorder(
            borderSide: new BorderSide(color: Colors.black)),
        focusedBorder: UnderlineInputBorder(
            borderSide: new BorderSide(color: Colors.black)),
        enabledBorder: UnderlineInputBorder(
            borderSide: new BorderSide(color: Colors.black)),
      ),
    );
  }

  Widget _refCodeField() {
    return TextFormField(
      cursorColor: Colors.black,
      controller: refCode,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: "Referral code (optional)",
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
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
