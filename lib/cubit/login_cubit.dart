import 'package:bloc/bloc.dart';
import 'package:hagglex_test/main.dart';
import 'package:hagglex_test/models/user.dart';
import 'package:hagglex_test/services/repo.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Repository repository = Repository();

  void login({String email, String password}) {
    emit(LogginIn());
    repository
        .loginUser(
        email: email,
        password: password,)
        .then((value) {
      if (value['type'] == "success") {
        userLoggedIn(value['token'], value['user']);
      } else {
        emit(LoggingError(error: value['message']));
      }
    });
  }

  void userLoggedIn(String token, Map user)async {
    final session = await SharedPreferences.getInstance();
    session.setString("auth_token", token);
    session.setString("userId", user['_id']);
    currentUser = User.fromMap(user);
    if(currentUser.isVerified){
      emit(LoggedIn());
    }else {
      repository.resendVerification(token, user['email']).then((value) {
        emit(LoggedInUnverified());
      });
    }
  }
}
