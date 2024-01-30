import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jungle_riches_app/pages/choose_page.dart';
import 'package:jungle_riches_app/pages/game_over_page.dart';
import 'package:jungle_riches_app/pages/home_page.dart';
import 'package:jungle_riches_app/pages/pause_page.dart';
import 'package:jungle_riches_app/widget/slot_machine.dart';

class SlotPage2 extends StatefulWidget {
  const SlotPage2({Key? key}) : super(key: key);

  @override
  _SlotPage2State createState() => _SlotPage2State();
}

class _SlotPage2State extends State<SlotPage2> {
  late SlotMachineController _controller;
  int userBid = 10000;
  List<int> resultIndex = [];
  List<RollItem> rolls = [
    RollItem(
        index: 0,
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  scale: 0.8,
                  image: AssetImage('assets/small.png'))),
        )),
    RollItem(
        index: 1,
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  scale: 0.8,
                  image: AssetImage(
                    'assets/medium_small.png',
                  ))),
        )),
    RollItem(
        index: 2,
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  scale: 0.8,
                  image: AssetImage('assets/chest.png'))),
        )),
    RollItem(
        index: 3,
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  scale: 0.8,
                  image: AssetImage('assets/bag.png'))),
        )),
  ];

  @override
  void initState() {
    super.initState();
  }

  void onButtonTap({required int index}) {
    _controller.stop(reelIndex: index);
  }

  void onStart() {
    final index = Random().nextInt(20);
    _controller.start(hitRollItemIndex: index < 4 ? index : null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/slot_background.png'))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          padding: const EdgeInsets.only(top: 5),
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
                    width: 25,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 400,
                        height: 340,
                        decoration: BoxDecoration(
                            color: const Color(0xFF8A7252),
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      Positioned(
                        top: 10,
                        child: Container(
                          height: 45,
                          width: 385,
                          decoration: const BoxDecoration(
                              color: Color(0xFFD8C6A2),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              )),
                          child: Image.asset('assets/app_name.png'),
                        ),
                      ),
                      Positioned(
                        top: 47,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            SlotMachine(
                              reelHeight: 270,
                              reelItemExtent: 55,
                              numberOfReel: 4,
                              rollItems: rolls,
                              onCreated: (controller) {
                                _controller = controller;
                              },
                              onFinished: (resultIndexes) {
                                resultIndex.addAll(resultIndexes);

                                if (resultIndexes[0] == 0 &&
                                    resultIndexes[1] == 0 &&
                                    resultIndexes[2] == 0 &&
                                    resultIndexes[3] == 0) {
                                  userBid = userBid * 10;
                                } else if (resultIndexes[0] == 1 &&
                                    resultIndexes[1] == 1 &&
                                    resultIndexes[2] == 1 &&
                                    resultIndexes[3] == 1) {
                                  userBid = userBid * 20;
                                } else if (resultIndexes[0] == 2 &&
                                    resultIndexes[1] == 2 &&
                                    resultIndexes[2] == 2 &&
                                    resultIndexes[3] == 2) {
                                  userBid = userBid * 15;
                                } else if (resultIndexes[0] == 3 &&
                                    resultIndexes[1] == 3 &&
                                    resultIndexes[2] == 3 &&
                                    resultIndexes[3] == 3) {
                                  userBid = userBid * 5;
                                }

                                setState(() {});
                              },
                            ),
                            Positioned(
                                top: 130,
                                left: 80,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/center2.png'))),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
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
                            padding: const EdgeInsets.only(top: 5),
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
                        height: 190,
                      ),
                      InkWell(
                          onTap: () async {
                            onStart();
                            Future.delayed(const Duration(milliseconds: 100),
                                () {
                              onButtonTap(index: 0);
                              onButtonTap(index: 1);
                              onButtonTap(index: 2);
                              onButtonTap(index: 3);
                            });
                            Future.delayed(const Duration(milliseconds: 1800),
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
                                              ECurrentGame.spotSlot,
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
