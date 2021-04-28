import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hagglex_test/cubit/dashbaord_cubit.dart';
import 'package:hagglex_test/cubit/login_cubit.dart';
import 'package:hagglex_test/cubit/picker_cubit.dart';
import 'package:hagglex_test/cubit/register_cubit.dart';
import 'package:hagglex_test/cubit/verify_email_cubit.dart';
import 'package:hagglex_test/screens/dashboard.dart';
import 'package:hagglex_test/screens/login.dart';
import 'package:hagglex_test/screens/register.dart';
import 'package:hagglex_test/screens/select_country.dart';
import 'package:hagglex_test/screens/splash.dart';
import 'package:hagglex_test/screens/success.dart';
import 'package:hagglex_test/screens/verify_email.dart';
import 'package:hagglex_test/services/repo.dart';

import 'cubit/splash_cubit.dart';

class Routing {
  Repository repository;

  Routing() {
    repository = Repository();
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => SplashCubit(), child: SplashScreen()));

      case Register.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) {
                  return RegisterCubit();
                },
                child: Register()));
      case Dashboard.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => DashbaordCubit(),
                  child: Dashboard(),
                ));
      case Login.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LoginCubit(),
                  child: Login(),
                ));
      case PickerPage.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => PickerCubit(),
                  child: PickerPage(),
                ));
      case VerifyEmail.routeName:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => VerifyEmailCubit(),
                  child: VerifyEmail(),
                ));
      case SuccessPage.routeName:
        return MaterialPageRoute(
            builder: (_) => SuccessPage());
      default:
        return null;
    }
  }
}
