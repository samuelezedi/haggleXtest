import 'package:bloc/bloc.dart';
import 'package:hagglex_test/main.dart';
import 'package:hagglex_test/services/repo.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  VerifyEmailCubit() : super(VerifyEmailInitial());

  Repository repository = Repository();
  void verify(String code) async {
    final session = await SharedPreferences.getInstance();
    emit(Verifying());
    repository.verifyUser(code, session.getString('auth_token')).then((value) {
      if (value['type'] == "success") {
        session.setString('userId', currentUser.id);
        emit(EmailVerified());
      } else {
        emit(VerifyEmailError(error: value['message']));
      }
    });
  }

  void resendCode() async {
    final session = await SharedPreferences.getInstance();
    repository
        .resendVerification(session.getString('auth_token'), currentUser.email)
        .then((value) {
      if (value) {
        emit(VerificationCodeResent());
        resentCodeCount(300);
      }
    });
  }

  void resentCodeCount(number) {
    Future.delayed(Duration(seconds: 1)).then((value) {
      if (state is VerifyEmailInitial) {
        if (number > 0) {
          emit(VerifyEmailInitial(initialTime: number-1));
          resentCodeCount(number-1);
        }
      }
    });
  }
}
