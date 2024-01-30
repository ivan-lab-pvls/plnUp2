import 'package:flutter/material.dart';
import 'package:jungle_riches_app/pages/home_page.dart';
import 'package:jungle_riches_app/pages/roulette_page.dart';
import 'package:jungle_riches_app/pages/slot_page1.dart';
import 'package:jungle_riches_app/pages/slot_page2.dart';

enum ECurrentGame { roulette, spotSlot, spotPokkies }

class GameOverPage extends StatefulWidget {
  const GameOverPage(
      {super.key, required this.currentGameType, required this.userBid});
  final ECurrentGame currentGameType;
  final int userBid;

  @override
  State<GameOverPage> createState() => _GameOverPageState();
}

class _GameOverPageState extends State<GameOverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.darken),
                image: const AssetImage('assets/roulette_background.png'))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.currentGameType == ECurrentGame.roulette)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Image.asset('assets/spot_roulette.png'),
                  ),
                if (widget.currentGameType == ECurrentGame.roulette)
                  Image.asset('assets/Roulette.png'),
                if (widget.currentGameType == ECurrentGame.spotSlot)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Image.asset('assets/spot1.png'),
                  ),
                if (widget.currentGameType == ECurrentGame.spotSlot)
                  Image.asset('assets/spot_slot.png'),
                if (widget.currentGameType == ECurrentGame.spotPokkies)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Image.asset('assets/spot2.png'),
                  ),
                if (widget.currentGameType == ECurrentGame.spotPokkies)
                  Image.asset('assets/spot_pokkies.png')
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/you_win.png'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      '${widget.userBid}',
                      style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        if (widget.currentGameType == ECurrentGame.roulette) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const RoulettePage()),
                          );
                          user.money = user.money! - 10000;
                        } else if (widget.currentGameType ==
                            ECurrentGame.spotSlot) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const SlotPage2()),
                          );
                          user.money = user.money! - 10000;
                        } else if (widget.currentGameType ==
                            ECurrentGame.spotPokkies) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const SlotPage1()),
                          );
                          user.money = user.money! - 10000;
                        }
                      },
                      child: Image.asset('assets/play_again.png')),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const HomePage()),
                        );
                      },
                      child: Image.asset('assets/menu_over_page.png')),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 260,
                  width: 150,
                  decoration: BoxDecoration(
                      color: const Color(0xFF8A7252),
                      borderRadius: BorderRadius.circular(16)),
                ),
                Image.asset('assets/rewards.png')
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
