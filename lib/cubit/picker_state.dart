part of 'picker_cubit.dart';

@immutable
abstract class PickerState {}

class PickerInitial extends PickerState {}
class CountryListLoaded extends PickerState{
  List<Country> countries;
  List<Country> mainList;
  CountryListLoaded({this.countries, this.mainList});
}
