part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class UpdatePhoneCode extends RegisterState {
  String flag = "flags/nga.png";
  String phoneCode = "+234";
  UpdatePhoneCode({this.flag, this.phoneCode});
}

class Registering extends RegisterState {}

class RegistrationError extends RegisterState {
  String error;
  RegistrationError({this.error});
}

class UserRegistered extends RegisterState {
  String token;
  UserRegistered({this.token});
}
