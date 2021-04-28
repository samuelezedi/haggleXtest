import 'package:bloc/bloc.dart';
import 'package:country_calling_code_picker/country.dart';
import 'package:hagglex_test/main.dart';
import 'package:hagglex_test/models/user.dart';
import 'package:hagglex_test/services/repo.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Repository repository = Repository();

  void updatePhoneData() {
    emit(UpdatePhoneCode(flag: "flags/nga.png", phoneCode: "+234"));
  }

  void updatePhoneNumber({Country code}) {
    final currentState = state;
    if (currentState is UpdatePhoneCode)
      emit(UpdatePhoneCode(flag: code.flag, phoneCode: code.callingCode));
  }

  void register(
      {String email,
      String password,
      String username,
      String phone,
      String refCode}) {
    emit(Registering());
    repository
        .registerUser(
            email: email,
            password: password,
            username: username,
            phone: phone,
            refCode: refCode)
        .then((value) {
      if (value['type'] == "success") {
        userRegistered(value['token'], value['user']);
      } else {
        emit(RegistrationError(error: value['message']));
      }
    });
  }

  void userRegistered(String token, Map<String, dynamic> user) async {
    final session = await SharedPreferences.getInstance();
    session.setString("auth_token", token);
    currentUser = User.fromMap(user);
    emit(UserRegistered(token: token));
    // repository.resendVerification(token, user['email']).then((value) {
    //   emit(UserRegistered(token: token));
    // });
  }
}
