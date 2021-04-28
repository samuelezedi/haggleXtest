import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hagglex_test/cubit/picker_cubit.dart';
import 'package:hagglex_test/utils/theming.dart';

class PickerPage extends StatelessWidget {
  static const String routeName = "/picker_page";
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PickerCubit>(context).fetchCountryList(context);
    return Scaffold(
      backgroundColor: AppColors.mainPurple,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: AppColors.lightPurple,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  Expanded(child: searchCountry(context)),
                  Icon(Icons.search, color: Colors.white)
                ],
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20.0),
              child: Divider(color: Colors.white,),
            ),
            Expanded(
                child: BlocBuilder<PickerCubit, PickerState>(
                  builder: (context, state) {
                    if(!(state is CountryListLoaded))
                      return Center(child: CircularProgressIndicator(),);

                    final countries = (state as CountryListLoaded).countries;
                    return ListView(
                      children: countries.map((e){
                        return InkWell(
                          onTap: () {
                            Navigator.pop(context, e);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom: 12, top: 12, left: 24, right: 24),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  e.flag,
                                  package: countryCodePackageName,
                                  width: 32,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                    child: Text(
                                      '${e.callingCode} ${e.name}',
                                      style: TextStyle(fontSize:16,color: Colors.white),
                                    )),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget searchCountry(context) {
    return TextFormField(
      onChanged: (value){
        BlocProvider.of<PickerCubit>(context).searchCountry(value);
      },
        cursorColor: Colors.white,
        controller: search,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Search for country",
          hintStyle: TextStyle(color: Colors.white, fontSize: 14),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
        ));
  }
}
