import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jungle_riches_app/pages/home_page.dart';
import 'package:jungle_riches_app/pages/setting_page.dart';

class PausePage extends StatelessWidget {
  const PausePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8C6A2),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Pause.png'),
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
          child: Row(
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
              const Expanded(
                child: SizedBox(),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 90),
                child: Column(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset('assets/continue.png')),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const HomePage()),
                          );
                        },
                        child: Image.asset('assets/menu2.png')),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                        onTap: () {
                          exit(0);
                        },
                        child: Image.asset('assets/exit_pause.png')),
                  ],
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
