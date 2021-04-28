part of 'dashbaord_cubit.dart';

@immutable
abstract class DashbaordState {}

class DashbaordInitial extends DashbaordState {
  User currentUser;
  DashbaordInitial({this.currentUser});
}
class LoggedOut extends DashbaordState{}
