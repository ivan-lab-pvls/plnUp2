import 'dart:math' as math;
import 'package:flutter/material.dart';

class SpinItem {
  Widget child;
  TextStyle labelStyle;
  Color color;

  SpinItem(
      {required this.child, required this.color, required this.labelStyle});
}

class MySpinner extends StatefulWidget {
  final MySpinController mySpinController;
  final List<SpinItem> itemList;
  final double wheelSize;
  final Function(void) onFinished;
  const MySpinner({
    Key? key,
    required this.mySpinController,
    required this.onFinished,
    required this.itemList,
    required this.wheelSize,
  }) : super(key: key);

  @override
  State<MySpinner> createState() => _MySpinnerState();
}

class _MySpinnerState extends State<MySpinner> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.mySpinController.initLoad(
      tickerProvider: this,
      itemList: widget.itemList,
    );
  }

  @override
  void dispose() {
    super.dispose();
    null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15),
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: widget.mySpinController._baseAnimation,
                builder: (context, child) {
                  double value = widget.mySpinController._baseAnimation.value;
                  double rotationValue = (360 * value);
                  return RotationTransition(
                    turns: AlwaysStoppedAnimation(rotationValue / 360),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        RotatedBox(
                          quarterTurns: 3,
                          child: Container(
                              width: widget.wheelSize,
                              height: widget.wheelSize,
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                  color: Color(0xFFC9B58A),
                                  //color: Colors.white.withOpacity(0.2),
                                  shape: BoxShape.circle),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xFF9D8462),
                                    shape: BoxShape.circle),
                                padding: const EdgeInsets.all(10),
                                child: CustomPaint(
                                  painter:
                                      SpinWheelPainter(items: widget.itemList),
                                ),
                              )),
                        ),
                        ...widget.itemList.map((each) {
                          int index = widget.itemList.indexOf(each);
                          double rotateInterval = 360 / widget.itemList.length;
                          double rotateAmount = (index + 0.5) * rotateInterval;

                          return RotationTransition(
                            turns: AlwaysStoppedAnimation(rotateAmount / 360),
                            child: Transform.translate(
                              offset: Offset(0, -widget.wheelSize / 4),
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: each.child,
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  );
                },
              ),
              Positioned(
                top: 130,
                child: Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.all(0),
                    child: Transform.rotate(
                        angle: 6.21, child: Image.asset('assets/center.png'))),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MySpinController {
  late AnimationController _baseAnimation;
  late TickerProvider _tickerProvider;
  bool _xSpinning = false;
  List<SpinItem> _itemList = [];

  Future<void> initLoad({
    required TickerProvider tickerProvider,
    required List<SpinItem> itemList,
  }) async {
    _tickerProvider = tickerProvider;
    _itemList = itemList;
    await setAnimations(_tickerProvider);
  }

  Future<void> setAnimations(TickerProvider tickerProvider) async {
    _baseAnimation = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 200),
    );
  }

  Future<void> spinNow(
      {required int luckyIndex,
      int totalSpin = 10,
      int baseSpinDuration = 100,
      required Function(double) callBack}) async {
    //getWhereToStop
    int itemsLength = _itemList.length;
    int factor = luckyIndex % itemsLength;
    if (factor == 0) factor = itemsLength;
    double spinInterval = 1 / itemsLength;
    double target = 1 - ((spinInterval * factor) - (spinInterval / 2));

    callBack(target);
    if (!_xSpinning) {
      _xSpinning = true;
      int spinCount = 0;

      do {
        _baseAnimation.reset();
        _baseAnimation.duration = Duration(milliseconds: baseSpinDuration);
        if (spinCount == totalSpin) {
          await _baseAnimation.animateTo(target);
        } else {
          await _baseAnimation.forward();
        }
        baseSpinDuration = baseSpinDuration + 50;
        _baseAnimation.duration = Duration(milliseconds: baseSpinDuration);
        spinCount++;
      } while (spinCount <= totalSpin);

      _xSpinning = false;
    }
  }
}

class SpinWheelPainter extends CustomPainter {
  final List<SpinItem> items;

  SpinWheelPainter({required this.items});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    final paint = Paint()..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.black
          .withOpacity(0.25) // Adjust the shadow color and opacity as needed
      ..maskFilter = const MaskFilter.blur(
          BlurStyle.normal, 10.0); // Adjust the blur radius as needed

    const spaceBetweenItems =
        0.02; // Adjust this value to set the desired space between items
    final totalSections = items.length;
    const totalAngle = 2 * math.pi;
    final sectionAngleWithSpace =
        (totalAngle - (totalSections * spaceBetweenItems)) / totalSections;
    const spaceOnBothSides = spaceBetweenItems / 2;

    for (var i = 0; i < items.length; i++) {
      final startAngle =
          i * (sectionAngleWithSpace + spaceBetweenItems) + spaceOnBothSides;

      paint.color = items[i].color;

      // Draw shadow before drawing the arc
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sectionAngleWithSpace,
        true,
        shadowPaint,
      );

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sectionAngleWithSpace,
        true,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
