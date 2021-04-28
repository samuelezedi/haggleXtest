import 'package:bloc/bloc.dart';
import 'package:hagglex_test/main.dart';
import 'package:hagglex_test/models/user.dart';
import 'package:hagglex_test/services/repo.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());
  Repository repository = Repository();

  void checkIfUserLoggedIn() async {
    await Future.delayed(Duration(seconds: 2)).then((value) async {
      final session = await SharedPreferences.getInstance();
      if (session.getString('auth_token') != null&&session.getString('userId') != null) {
        //user exists
        emit(SplashUserLoggedIn());
      } else {
        emit(SplashUserNotLoggedIn());
      }
    });
    // emit(Sp)
  }
}
