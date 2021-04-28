import 'package:bloc/bloc.dart';
import 'package:hagglex_test/models/user.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dashbaord_state.dart';

class DashbaordCubit extends Cubit<DashbaordState> {
  DashbaordCubit() : super(DashbaordInitial());

  void saveCurrentUser(User user) {
    emit(DashbaordInitial(currentUser: user));
  }

  void logOut() async {
    final currentState = (state as DashbaordInitial);
    currentState.currentUser=null;
    final session = await SharedPreferences.getInstance();
    session.clear();
    emit(LoggedOut());
  }
}
