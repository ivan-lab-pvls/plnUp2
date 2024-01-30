import 'dart:async';

import 'package:flutter/material.dart';

class DailyReward extends StatefulWidget {
  const DailyReward(
      {super.key, required this.canOpen, required this.timerText});
  final bool canOpen;
  final String timerText;

  @override
  State<DailyReward> createState() => _DailyRewardState();
}

class _DailyRewardState extends State<DailyReward> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/daily_reward_background.png'))),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 24, 0, 0),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset('assets/chevron_left.png')),
                  ],
                ),
              ),
            ]),
          ),
          if (widget.canOpen) Image.asset('assets/book_reward_page.png'),
          if (!widget.canOpen) Image.asset('assets/book2_daily_reward.png'),
          if (widget.canOpen)
            Positioned(
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/daily_reward_page.png'),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 140),
                    child: Text(
                      'Every 24 hours you\ncan get your daily\nreward.',
                      style: TextStyle(
                          fontFamily: 'SF Pro Text',
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                  Image.asset('assets/open.png'),
                ],
              ),
            ),
          if (!widget.canOpen)
            Positioned(
              right: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/daily_reward_page.png'),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 70),
                      child: SizedBox(
                        width: 200,
                        child: RichText(
                          text: const TextSpan(
                            text: 'We give you ',
                            style: TextStyle(
                              fontFamily: 'SF Pro Text',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: '200 coins',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFFFBD0E),
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'for daily login to the application. We are waiting for you.',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  if (!widget.canOpen)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: SizedBox(
                            width: 170,
                            child: RichText(
                              text: TextSpan(
                                text: 'You can open daily reward in ',
                                style: const TextStyle(
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                                children: [
                                  TextSpan(
                                    text: widget.timerText,
                                    style: const TextStyle(
                                      fontFamily: 'SF Pro Text',
                                      color: Color(0xFF3FA60D),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Image.asset('assets/open_grey.png'),
                      ],
                    ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
