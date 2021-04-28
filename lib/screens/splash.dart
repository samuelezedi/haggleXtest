import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hagglex_test/cubit/splash_cubit.dart';
import 'package:hagglex_test/screens/dashboard.dart';
import 'package:hagglex_test/screens/login.dart';
import 'package:hagglex_test/utils/theming.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/';
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SplashCubit>(context).checkIfUserLoggedIn();
    return Scaffold(
      backgroundColor: AppColors.mainPurple,
      body: BlocListener<SplashCubit, SplashState>(
  listener: (context, state) {
    // TODO: implement listener}
    if(state is SplashUserNotLoggedIn){
      //redirect to login
      Navigator.pushNamed(context, Login.routeName);
    } else if(state is SplashUserLoggedIn){
      //redirect to dashboard
      Navigator.pushNamed(context, Dashboard.routeName);
    } else if(state is SplashUserLoggedInNotVerified) {
      //should navigate to verify email, but I'll skip this.
      Navigator.pushNamed(context, Dashboard.routeName);
    }
  },
  child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width:70,child: Image.asset('assets/images/logo.png',fit: BoxFit.cover,)),
            Text('HaggleX', style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold))
          ],
        ),
      ),
),
    );
  }
}
