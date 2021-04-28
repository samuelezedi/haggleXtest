import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hagglex_test/cubit/dashbaord_cubit.dart';
import 'package:hagglex_test/main.dart';
import 'package:hagglex_test/screens/login.dart';
import 'package:hagglex_test/utils/theming.dart';

class Dashboard extends StatelessWidget {
  static const String routeName = '/dashboard';
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DashbaordCubit>(context).saveCurrentUser(currentUser);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.mainPurple,
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 5, bottom: Platform.isIOS ? 15 : 5),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              child: Container(
                width: 70,
                height: 70,
                child: Image.asset(
                  'assets/images/dasbboard.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            InkWell(
              child: Container(
                width: 70,
                height: 70,
                child: Image.asset(
                  'assets/images/wallet.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            InkWell(
              child: Container(
                width: 70,
                height: 70,
                child: Image.asset(
                  'assets/images/OTC.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            InkWell(
              child: Container(
                width: 70,
                height: 70,
                child: Image.asset(
                  'assets/images/Savings.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            InkWell(
              child: Container(
                width: 70,
                height: 70,
                child: Image.asset(
                  'assets/images/Utilities.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: BlocListener<DashbaordCubit, DashbaordState>(
          listener: (context, state) {
            if (state is LoggedOut) {
              Navigator.pushNamed(context, Login.routeName);
            }
          },
          child: Column(
            children: [
              headerSection(),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white),
                  child: ListView(
                    children: [
                      carouselBanner(),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Markets',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                      Column(
                        children: coinList.map((e) {
                          return ListTile(
                            dense: true,
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.grey[200],
                                  image: DecorationImage(
                                      image: AssetImage(
                                        e['leading'],
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                            title: Text(e['name']),
                            subtitle: Text(e['sub']),
                            trailing: Container(
                                width: 80, child: Image.asset(e['trailing'])),
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Do more with HaggleX',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                      Column(
                        children: moreWithHaggle.map((e) {
                          return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[100],
                                        offset: Offset(0.0, 3.0),
                                        blurRadius: 14,
                                        spreadRadius: 10)
                                  ]),
                              child: ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color:
                                        AppColors.purplePink.withOpacity(0.3),
                                  ),
                                  child: e['leading'],
                                ),
                                title: Text(e['name']),
                                subtitle: Text(e['sub']),
                              ));
                        }).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Trending cryptp news',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                      Column(
                        children: news.map((e) {
                          return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: ListTile(
                                leading: Container(
                                  width: 60,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey[200],
                                      image: DecorationImage(
                                          image: AssetImage(
                                            e['leading'],
                                          ),
                                          fit: BoxFit.cover)),
                                ),
                                title: Text(
                                  e['name'],
                                  style: TextStyle(fontSize: 12),
                                ),
                                subtitle: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        e['sub'],
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text(
                                        "Category: " + e['cat'],
                                        style: TextStyle(fontSize: 10),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                        }).toList(),
                      ),
                      Center(
                          child: InkWell(
                              onTap: () {
                                BlocProvider.of<DashbaordCubit>(context)
                                    .logOut();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Logout',
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              )))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List coinList = [
    {
      "name": "Haggle (HAG)",
      "sub": "NGN 380",
      "trailing": "assets/images/haggle.png",
      "leading": "assets/images/haggle-logo.png"
    },
    {
      "name": "Bitcoin (BTC)",
      "sub": "NGN 4,233,323",
      "trailing": "assets/images/btc.png",
      "leading": "assets/images/bitcoin-logo.png"
    },
    {
      "name": "Ethereum (ETH)",
      "sub": "NGN 4,233,323",
      "trailing": "assets/images/ethereum.png",
      "leading": "assets/images/eth-logo.png"
    },
    {
      "name": "Tether (USDT)",
      "sub": "NGN 4,233,323",
      "trailing": "assets/images/tether.png",
      "leading": "assets/images/usdt.png"
    },
    {
      "name": "Bitcoin Cash (BCH)",
      "sub": "NGN 4,233,323",
      "trailing": "assets/images/bitcoin-cash.png",
      "leading": "assets/images/bitcoincash-logo.png"
    },
    {
      "name": "Dogecoin (DOGE)",
      "sub": "NGN 4,233,323",
      "trailing": "assets/images/doge.png",
      "leading": "assets/images/doge-logo.png"
    },
    {
      "name": "Litcoin (LTC)",
      "sub": "NGN 4,233,323",
      "trailing": "assets/images/litecoin.png",
      "leading": "assets/images/litecoin-logo.png"
    }
  ];

  List moreWithHaggle = [
    {
      "name": "Send money instantly",
      "sub": "Send crypto to another wallet",
      "trailing": "assets/images/haggle.png",
      "leading": Transform.rotate(
          angle: -math.pi / 3.5,
          child: Icon(
            Icons.send,
            color: AppColors.mainPurple,
          ))
    },
    {
      "name": "Receive money from anyone",
      "sub": "Receive crupto from another waller",
      "trailing": "assets/images/btc.png",
      "leading": Transform.rotate(
          angle: 260 * math.pi / 360,
          child: Icon(
            Icons.send,
            color: AppColors.mainPurple,
          ))
    },
    {
      "name": "Virtual Card",
      "sub": "Make faster payments using HaggleX cards",
      "trailing": "assets/images/ethereum.png",
      "leading": Icon(
        Icons.credit_card,
        color: AppColors.mainPurple,
      )
    },
    {
      "name": "Gglobal Remittance",
      "sub": "Send money to anyone, anywhere",
      "trailing": "assets/images/tether.png",
      "leading": Icon(
        CupertinoIcons.globe,
        color: AppColors.mainPurple,
      )
    },
  ];

  List news = [
    {
      "name":
          "Blockchain Bites: BTC on Ethereum, Defi's latest stable coin, the currency cold wares",
      "sub": "6hrs ago",
      "cat": "DeFi",
      "leading": "assets/images/news.jpeg"
    },
    {
      "name":
          "Blockchain Bites: BTC on Ethereum, Defi's latest stable coin, the currency cold wares",
      "sub": "6hrs ago",
      "cat": "DeFi",
      "leading": "assets/images/news.jpeg"
    },
    {
      "name":
          "Blockchain Bites: BTC on Ethereum, Defi's latest stable coin, the currency cold wares",
      "sub": "6hrs ago",
      "cat": "DeFi",
      "leading": "assets/images/news.jpeg"
    },
    {
      "name":
          "Blockchain Bites: BTC on Ethereum, Defi's latest stable coin, the currency cold wares",
      "sub": "6hrs ago",
      "cat": "DeFi",
      "leading": "assets/images/news.jpeg"
    },
    {
      "name":
          "Blockchain Bites: BTC on Ethereum, Defi's latest stable coin, the currency cold wares",
      "sub": "6hrs ago",
      "cat": "DeFi",
      "leading": "assets/images/news.jpeg"
    },
    {
      "name":
          "Blockchain Bites: BTC on Ethereum, Defi's latest stable coin, the currency cold wares",
      "sub": "6hrs ago",
      "cat": "DeFi",
      "leading": "assets/images/news.jpeg"
    },
  ];
}

class carouselBanner extends StatelessWidget {
  const carouselBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: 140,
            child: Image.asset('assets/images/banner1.png', fit: BoxFit.cover),
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: 140,
            child: Image.asset('assets/images/banner2.png', fit: BoxFit.cover),
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: 140,
            child: Image.asset('assets/images/banner3.png', fit: BoxFit.cover),
          ),
          Container(
            padding: EdgeInsets.all(10),
            height: 140,
            child: Image.asset('assets/images/banner4.png', fit: BoxFit.cover),
          )
        ],
      ),
    );
  }
}

class headerSection extends StatelessWidget {
  const headerSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: 43,
                  height: 43,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColors.purplePink,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                              color: AppColors.mainPurple, width: 4)),
                      child: Center(
                          child: Text(
                        'SV',
                        style: TextStyle(
                            color: AppColors.mainPurple,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )),
                    ),
                  ),
                ),
              ),
              Text(
                'HaggleX',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontFamily: 'BasisGrotesqueProBold'),
              ),
              Container(
                width: 60,
                height: 60,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        left: 30,
                        bottom: 30,
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                              child: Text(
                            '5',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )),
                        ))
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                'Total portfolio balance',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$****",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Container(
                width: 130,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        width: 60,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: AppColors.yellow,
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(0.0, 0.6),
                                  spreadRadius: 0.5,
                                  blurRadius: 10)
                            ]),
                        child: Center(
                            child: Text('USD',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)))),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      width: 60,
                      height: 45,
                      child: Center(
                          child: Text('NGN',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ))),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
