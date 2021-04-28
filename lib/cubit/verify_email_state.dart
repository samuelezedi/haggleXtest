part of 'verify_email_cubit.dart';

@immutable
abstract class VerifyEmailState {}

class VerifyEmailInitial extends VerifyEmailState {
  int initialTime;
  VerifyEmailInitial({this.initialTime = 0});
}

class Verifying extends VerifyEmailState {}

class VerifyEmailError extends VerifyEmailState {
  final String error;
  VerifyEmailError({this.error});
}

class VerificationCodeResent extends VerifyEmailState{}

class EmailVerified extends VerifyEmailState {}
