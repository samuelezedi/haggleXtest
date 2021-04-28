import 'package:bloc/bloc.dart';
import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:meta/meta.dart';

part 'picker_state.dart';

class PickerCubit extends Cubit<PickerState> {
  PickerCubit() : super(PickerInitial());

  void fetchCountryList(context) async {
    List<Country> countries = await getCountries(context);
    updateCountryList(countries);
  }

  void updateCountryList(List<Country> countries) {
    emit(CountryListLoaded(countries: countries, mainList: countries));
  }

  void searchCountry(text) {
    final currentState = (state as CountryListLoaded);
    if (text == null || text.isEmpty) {
      currentState.countries.clear();
      currentState.countries.addAll(currentState.mainList);
      emit(CountryListLoaded(
          countries: currentState.countries, mainList: currentState.mainList));
    } else {
      currentState.countries = currentState.mainList
          .where((element) =>
              element.name
                  .toLowerCase()
                  .contains(text.toString().toLowerCase()) ||
              element.callingCode
                  .toLowerCase()
                  .contains(text.toString().toLowerCase()) ||
              element.countryCode
                  .toLowerCase()
                  .startsWith(text.toString().toLowerCase()))
          .map((e) => e)
          .toList();
      emit(CountryListLoaded(
          countries: currentState.countries, mainList: currentState.mainList));
    }
  }
}
