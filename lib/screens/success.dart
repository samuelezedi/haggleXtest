import 'package:flutter/material.dart';
import 'package:hagglex_test/screens/dashboard.dart';
import 'package:hagglex_test/utils/theming.dart';

class SuccessPage extends StatelessWidget {
  static const String routeName = "/success_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainPurple,
      body: Column(
        children: [
          SizedBox(height: 200,),
          Container(
            width: 64,
            height: 64,
            child: Image.asset('assets/images/yellow-check.png',fit: BoxFit.cover,),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Setup Complete', style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
          SizedBox(
            height: 20,
          ),
          Text('Thank you for setting up your HaggleX account',style: TextStyle(color: Colors.white,fontSize: 12,),),
          Expanded(
            child: Container(),
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, Dashboard.routeName);
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.all(25),
              decoration: BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  'START EXPLORING',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
