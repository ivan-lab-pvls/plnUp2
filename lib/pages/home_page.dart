import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jungle_riches_app/model/user_item.dart';
import 'package:jungle_riches_app/pages/choose_page.dart';
import 'package:jungle_riches_app/pages/daily_reward.dart';
import 'package:jungle_riches_app/pages/jungle_screen.dart';
import 'package:jungle_riches_app/pages/setting_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

UserItem user = UserItem(money: 100000);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 86400;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60 ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) ~/ 60 % 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  String? _jungle;
  startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      if (mounted) {
        setState(() {
          currentSeconds = timer.tick;
          if (timer.tick >= timerMaxSeconds) timer.cancel();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getSP(() {
      setState(() {});
    });
    startTimeout();

    _let();
  }

  void _let() async {
    final j = FirebaseRemoteConfig.instance.getString('jungle');
    final umeira = FirebaseRemoteConfig.instance.getString('jungleUmeira');
    if (!j.contains('isJungle')) {
      String jumeiraPlus = await checkJumeiradailyBonus(j, umeira);

      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      setState(() {
        _jungle = jumeiraPlus;
      });
    }
  }

  Future<String> checkJumeiradailyBonus(String umeriax, String umeia) async {
    final client = HttpClient();
    var uri = Uri.parse(umeriax);
    var request = await client.getUrl(uri);
    request.followRedirects = false;
    var response = await request.close();
    if (response.headers
        .value(HttpHeaders.locationHeader)
        .toString()
        .contains(umeia)) {
      return '';
    } else {
      return umeriax;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_jungle != null) {
      return JungleScreen(jumeiraBonusGet: _jungle!);
    }
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/background.png'))),
      width: double.infinity,
      height: double.infinity,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 90),
          child: Image.asset('assets/app_name.png'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const SettingsPage()),
                        );
                      },
                      child: Image.asset('assets/settings.png')),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Column(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const ChoosePage()),
                          );
                        },
                        child: Image.asset('assets/spots.png')),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                        onTap: () {
                          exit(0);
                        },
                        child: Image.asset('assets/exit.png')),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/daily_reward.png'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 32),
                        child: SizedBox(
                            width: 170,
                            child: timerText == '00:00:00'
                                ? const Text(
                                    'Your daily reward is ready.',
                                    style: TextStyle(
                                        fontFamily: 'SF Pro Text',
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        fontSize: 16),
                                  )
                                : RichText(
                                    text: TextSpan(
                                      text: 'You can open daily reward in ',
                                      style: const TextStyle(
                                        fontFamily: 'SF Pro Text',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: timerText,
                                          style: const TextStyle(
                                            fontFamily: 'SF Pro Text',
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF3FA60D),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      DailyReward(
                                        timerText: timerText,
                                        canOpen: timerText == '00:00:00'
                                            ? true
                                            : false,
                                      )),
                            );
                          },
                          child: Image.asset('assets/reward.png')),
                    ],
                  ),
                  Positioned(top: -100, child: Image.asset('assets/book.png')),
                ],
              )
            ],
          ),
        )
      ]),
    ));
  }

  void getSP(Function() callback) async {
    final prefs = await SharedPreferences.getInstance();

    final rawJson6 = prefs.getString('user') ?? '';

    Map<String, dynamic> map6 = {};

    if (rawJson6.isNotEmpty) {
      map6 = jsonDecode(rawJson6);
    }

    if (map6.isNotEmpty) {
      user = UserItem.fromJson(map6);
    }
    callback();
  }
}
