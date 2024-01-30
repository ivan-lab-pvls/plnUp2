import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jungle_riches_app/pages/choose_page.dart';
import 'package:jungle_riches_app/pages/game_over_page.dart';
import 'package:jungle_riches_app/pages/home_page.dart';
import 'package:jungle_riches_app/pages/pause_page.dart';
import 'package:jungle_riches_app/widget/spinning_wheel.dart';

class RoulettePage extends StatefulWidget {
  const RoulettePage({super.key});

  @override
  RoulettePageState createState() => RoulettePageState();
}

class RoulettePageState extends State<RoulettePage> {
  int userBid = 10000;
  @override
  void dispose() {
    super.dispose();
  }

  MySpinController mySpinController = MySpinController();

  List<SpinItem> spins = [
    SpinItem(
        child: const Text(
          '0',
          style: TextStyle(
              fontFamily: 'SF Pro Text',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        labelStyle: const TextStyle(
            fontFamily: 'SF Pro Text',
            color: Colors.white,
            fontWeight: FontWeight.w700),
        color: const Color(0xFFC9B58A)),
    SpinItem(
        child: Image.asset('assets/small_slot_element.png'),
        labelStyle: const TextStyle(
            fontFamily: 'SF Pro Text',
            color: Colors.white,
            fontWeight: FontWeight.w700),
        color: const Color(0xFFC9B58A)),
    SpinItem(
        child: const Text(
          '100',
          style: TextStyle(
              fontFamily: 'SF Pro Text',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        labelStyle: const TextStyle(
            fontFamily: 'SF Pro Text',
            color: Colors.white,
            fontWeight: FontWeight.w700),
        color: const Color(0xFFC9B58A)),
    SpinItem(
        child: const Text(
          '50',
          style: TextStyle(
              fontFamily: 'SF Pro Text',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        labelStyle: const TextStyle(
            fontFamily: 'SF Pro Text',
            color: Colors.black,
            fontWeight: FontWeight.w700),
        color: const Color(0xFFC9B58A)),
    SpinItem(
        child: Image.asset('assets/medium_slot_element.png'),
        labelStyle: const TextStyle(
            fontFamily: 'SF Pro Text',
            color: Colors.black,
            fontWeight: FontWeight.w700),
        color: const Color(0xFFC9B58A)),
    SpinItem(
        child: const Text(
          '0',
          style: TextStyle(
              fontFamily: 'SF Pro Text',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        labelStyle: const TextStyle(
            fontFamily: 'SF Pro Text',
            color: Colors.white,
            fontWeight: FontWeight.w700),
        color: const Color(0xFFC9B58A)),
    SpinItem(
        child: Image.asset('assets/chest_slot_element.png'),
        labelStyle: const TextStyle(
            fontFamily: 'SF Pro Text',
            color: Colors.white,
            fontWeight: FontWeight.w700),
        color: const Color(0xFFC9B58A)),
    SpinItem(
        child: const Text(
          '0',
          style: TextStyle(
              fontFamily: 'SF Pro Text',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        labelStyle: const TextStyle(
            fontFamily: 'SF Pro Text',
            color: Colors.white,
            fontWeight: FontWeight.w700),
        color: const Color(0xFFC9B58A)),
    SpinItem(
        child: const Text(
          '20',
          style: TextStyle(
              fontFamily: 'SF Pro Text',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        labelStyle: const TextStyle(
            fontFamily: 'SF Pro Text',
            color: Colors.white,
            fontWeight: FontWeight.w700),
        color: const Color(0xFFC9B58A)),
    SpinItem(
        child: const Text(
          '10000',
          style: TextStyle(
              fontFamily: 'SF Pro Text',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        labelStyle: const TextStyle(
            fontFamily: 'SF Pro Text',
            color: Colors.white,
            fontWeight: FontWeight.w700),
        color: const Color(0xFFC9B58A)),
    SpinItem(
        child: Image.asset('assets/bag_slot_element.png'),
        labelStyle: const TextStyle(
            fontFamily: 'SF Pro Text',
            color: Colors.white,
            fontWeight: FontWeight.w700),
        color: const Color(0xFFC9B58A)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/roulette_background.png'))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 343,
                        width: 155,
                        decoration: BoxDecoration(
                            color: const Color(0xFF8A7252),
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      Positioned(
                        top: 10,
                        child: Container(
                          width: 140,
                          height: 65,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD8C6A2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'WIN',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'SF Pro Text',
                                    color: Color(0xFFFF5901),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900),
                              ),
                              if (userBid != 10000)
                                Text(
                                  '$userBid',
                                  style: const TextStyle(
                                      fontFamily: 'SF Pro Text',
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 10, child: Image.asset('assets/rewards.png'))
                    ],
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                            top: -35,
                            child:
                                Image.asset('assets/roulette_page_name.png')),
                        MySpinner(
                          mySpinController: mySpinController,
                          wheelSize: 300,
                          itemList: spins,
                          onFinished: (p0) {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 140,
                            height: 75,
                            decoration: BoxDecoration(
                                color: const Color(0xFFD8C6A2),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: const Color(0xFF8A7252), width: 8)),
                            child: Column(
                              children: [
                                const Text(
                                  'BALANCE',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'SF Pro Text',
                                      color: Color(0xFF3FA60D),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  '${user.money}',
                                  style: const TextStyle(
                                      fontFamily: 'SF Pro Text',
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const PausePage()),
                                );
                              },
                              child: Image.asset('assets/menu.png'))
                        ],
                      ),
                      const SizedBox(
                        height: 170,
                      ),
                      InkWell(
                          onTap: () async {
                            int rdm = Random().nextInt(11);
                            await mySpinController.spinNow(
                                luckyIndex: rdm + 1,
                                totalSpin: 10,
                                baseSpinDuration: 20,
                                callBack: (target) {
                                  if (double.parse(target.toStringAsFixed(2)) ==
                                      0.32) {
                                    userBid = userBid * 5;
                                  } else if (double.parse(target.toStringAsFixed(2)) ==
                                      0.68) {
                                    userBid = userBid * 15;
                                  } else if (double.parse(
                                              target.toStringAsFixed(2)) ==
                                          0.23 ||
                                      double.parse(target.toStringAsFixed(2)) ==
                                          0.77 ||
                                      double.parse(target.toStringAsFixed(2)) ==
                                          0.59) {
                                    userBid = userBid;
                                  } else if (double.parse(target.toStringAsFixed(2)) ==
                                      0.86) {
                                    userBid = userBid * 20;
                                  } else if (double.parse(target.toStringAsFixed(2)) ==
                                      0.50) {
                                    userBid = userBid + 20;
                                  } else if (double.parse(
                                          target.toStringAsFixed(2)) ==
                                      0.05) {
                                    userBid = userBid + 100;
                                  } else if (double.parse(
                                          target.toStringAsFixed(2)) ==
                                      0.41) {
                                    userBid = userBid + 10000;
                                  } else if (double.parse(
                                          target.toStringAsFixed(2)) ==
                                      0.14) {
                                    userBid = userBid * 10;
                                  } else if (double.parse(
                                          target.toStringAsFixed(2)) ==
                                      0.95) {
                                    userBid = userBid + 50;
                                  }
                                });
                            setState(() {});
                            Future.delayed(const Duration(milliseconds: 1500),
                                () {
                              if (userBid > 10000) {
                                user.money = user.money! + userBid;
                              }
                              addSP(user);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        GameOverPage(
                                          userBid:
                                              userBid > 10000 ? userBid : 0,
                                          currentGameType:
                                              ECurrentGame.roulette,
                                        )),
                              );
                            });
                          },
                          child: Image.asset('assets/spin.png')),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
