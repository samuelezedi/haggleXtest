part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}
class SplashUserLoggedIn extends SplashState {}
class SplashUserLoggedInNotVerified extends SplashState {}
class SplashUserNotLoggedIn extends SplashState{}
