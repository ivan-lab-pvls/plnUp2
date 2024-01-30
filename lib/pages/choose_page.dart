import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jungle_riches_app/model/user_item.dart';
import 'package:jungle_riches_app/pages/home_page.dart';
import 'package:jungle_riches_app/pages/roulette_page.dart';
import 'package:jungle_riches_app/pages/slot_page1.dart';
import 'package:jungle_riches_app/pages/slot_page2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChoosePage extends StatefulWidget {
  const ChoosePage({super.key});

  @override
  State<ChoosePage> createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  CarouselController carouselController = CarouselController();
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/background.png'))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 24, 60, 0),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset('assets/chevron_left.png')),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  if (page == 0)
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Image.asset('assets/spot_roulette.png'),
                    ),
                  if (page == 1)
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Image.asset('assets/spot1.png'),
                    ),
                  if (page == 2)
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Image.asset('assets/spot2.png'),
                    ),
                  const Expanded(
                    child: SizedBox(),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            carouselController.previousPage();
                            if (page < 3 && page != 0) {
                              page--;
                            } else {
                              page = 2;
                            }
                            setState(() {});
                          },
                          child: Image.asset('assets/back.png')),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: SizedBox(
                          width: 300,
                          child: CarouselSlider(
                              carouselController: carouselController,
                              items: getSpots(),
                              options: CarouselOptions(
                                aspectRatio: 16 / 9,
                                viewportFraction: 1,
                                initialPage: page,
                                enableInfiniteScroll: true,
                                reverse: false,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.3,
                                scrollDirection: Axis.horizontal,
                              )),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            carouselController.nextPage();
                            if (page < 2) {
                              page++;
                            } else {
                              page = 0;
                            }
                            setState(() {});
                          },
                          child: Image.asset('assets/next.png')),
                    ],
                  ),
                  InkWell(
                      onTap: () {
                        if (page == 0) {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const RoulettePage()),
                          );
                          user.money = user.money! - 10000;
                        } else if (page == 1) {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const SlotPage2()),
                          );
                          user.money = user.money! - 10000;
                        } else if (page == 2) {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const SlotPage1()),
                          );
                          user.money = user.money! - 10000;
                        }
                        addSP(user);
                      },
                      child: Image.asset('assets/play.png'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getSpots() {
    List<Widget> list = [];
    list.add(Image.asset('assets/Roulette.png'));
    list.add(Image.asset('assets/spot_slot.png'));
    list.add(Image.asset('assets/spot_pokkies.png'));
    return list;
  }
}

Future<void> addSP(UserItem? user) async {
  final prefs = await SharedPreferences.getInstance();

  String rawJson6 = jsonEncode(user!.toJson());
  prefs.setString('user', rawJson6);
}
