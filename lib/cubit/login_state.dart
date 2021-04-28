part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LogginIn extends LoginState {}
class LoggedIn extends LoginState{}
class LoggedInUnverified extends LoginState{}
class LoggingError extends LoginState{
  String error;
  LoggingError({this.error});
}
