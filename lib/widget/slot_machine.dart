library flutter_slot_machine;

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class SlotMachineController {
  const SlotMachineController({
    required this.start,
    required this.stop,
  });

  final Function({required int? hitRollItemIndex}) start;
  final Function({required int reelIndex}) stop;
}

class SlotMachine extends StatefulWidget {
  const SlotMachine({
    Key? key,
    required this.rollItems,
    this.multiplyNumberOfSlotItems = 2,
    this.shuffle = true,
    this.width = 600,
    this.height = 300,
    this.reelWidth = 90,
    this.reelHeight = 230,
    this.reelItemExtent = 80,
    this.reelSpacing = 8,
    required this.onCreated,
    required this.onFinished,
    required this.numberOfReel,
  }) : super(key: key);

  final List<RollItem> rollItems;
  final int multiplyNumberOfSlotItems;
  final int numberOfReel;
  final bool shuffle;
  final double width;
  final double height;
  final double reelWidth;
  final double reelHeight;
  final double reelItemExtent;
  final double reelSpacing;
  final Function(SlotMachineController) onCreated;
  final Function(List<int> resultIndexes) onFinished;

  @override
  State<SlotMachine> createState() => _SlotMachineState();
}

class _SlotMachineState extends State<SlotMachine> {
  late SlotMachineController _slotMachineController;
  final Map<int, _ReelController> _reelControllers = {};
  final List<RollItem> _actualRollItems = [];
  List<int> _resultIndexes = [];
  int _stopCounter = 0;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.multiplyNumberOfSlotItems; i++) {
      _actualRollItems.addAll([...widget.rollItems]);
    }

    _slotMachineController = SlotMachineController(
      start: _start,
      stop: _stop,
    );

    widget.onCreated(_slotMachineController);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Reel(
                reelIndex: 0,
                results: _resultIndexes,
                numberOfReel: widget.numberOfReel,
                reelWidth: widget.reelWidth,
                reelHeight: widget.reelHeight,
                itemExtent: widget.reelItemExtent,
                rollItems: _actualRollItems,
                shuffle: widget.shuffle,
                onCreated: (lc) => _reelControllers[0] = lc,
              ),
              SizedBox(width: widget.reelSpacing),
              _Reel(
                reelIndex: 1,
                results: _resultIndexes,
                numberOfReel: widget.numberOfReel,
                reelWidth: widget.reelWidth,
                reelHeight: widget.reelHeight,
                itemExtent: widget.reelItemExtent,
                rollItems: _actualRollItems,
                shuffle: widget.shuffle,
                onCreated: (lc) => _reelControllers[1] = lc,
              ),
              SizedBox(width: widget.reelSpacing),
              _Reel(
                reelIndex: 2,
                results: _resultIndexes,
                numberOfReel: widget.numberOfReel,
                reelWidth: widget.reelWidth,
                reelHeight: widget.reelHeight,
                itemExtent: widget.reelItemExtent,
                rollItems: _actualRollItems,
                shuffle: widget.shuffle,
                onCreated: (lc) => _reelControllers[2] = lc,
              ),
              if (widget.numberOfReel == 4) SizedBox(width: widget.reelSpacing),
              if (widget.numberOfReel == 4)
                _Reel(
                  results: _resultIndexes,
                  reelIndex: 3,
                  numberOfReel: widget.numberOfReel,
                  reelWidth: widget.reelWidth,
                  reelHeight: widget.reelHeight,
                  itemExtent: widget.reelItemExtent,
                  rollItems: _actualRollItems,
                  shuffle: widget.shuffle,
                  onCreated: (lc) => _reelControllers[3] = lc,
                ),
            ],
          ),
        ),
      ],
    );
  }

  _start({required int? hitRollItemIndex}) {
    _stopCounter = 0;
    _resultIndexes = [];

    final win = hitRollItemIndex != null;
    if (win) {
      final index = hitRollItemIndex;
      if (widget.numberOfReel == 3) {
        _resultIndexes.addAll([index, index, index]);
      } else {
        _resultIndexes.addAll([index, index, index, index]);
      }
    } else {
      _resultIndexes = _randomResultIndexes(widget.rollItems.length);
    }
    _reelControllers.forEach((key, _) => _reelControllers[key]!.start());
  }

  _stop({required int reelIndex}) {
    assert(reelIndex >= 0);

    final lc = _reelControllers[reelIndex];
    if (lc == null) return;

    lc.stop(to: _resultIndexes[reelIndex]);

    _stopCounter++;
    if (_stopCounter == 3) {
      Future.delayed(const Duration(milliseconds: 500), () {
        widget.onFinished(_resultIndexes);
        //setState(() {});
      });
    }
  }

  List<int> _randomResultIndexes(int length) {
    bool ok = false;
    List<int> indexes = [];
    while (!ok) {
      if (widget.numberOfReel == 3) {
        final arr = [
          Random().nextInt(length),
          Random().nextInt(length),
          Random().nextInt(length)
        ];
        if (arr[0] != arr[1] || arr[0] != arr[2] || arr[1] != arr[2]) {
          indexes = arr;
          ok = true;
        }
      } else {
        final arr = [
          Random().nextInt(length),
          Random().nextInt(length),
          Random().nextInt(length),
          Random().nextInt(length)
        ];
        if (arr[0] != arr[1] ||
            arr[0] != arr[2] ||
            arr[1] != arr[2] ||
            arr[2] != arr[1] ||
            arr[1] != arr[3]) {
          indexes = arr;
          ok = true;
        }
      }
    }
    return indexes;
  }
}

class _ReelController {
  const _ReelController({
    required this.start,
    required this.stop,
  });

  final Function start;
  final Function({required int to}) stop;
}

class _Reel extends StatefulWidget {
  const _Reel({
    Key? key,
    required this.rollItems,
    required this.reelWidth,
    required this.reelHeight,
    required this.itemExtent,
    this.shuffle = true,
    required this.onCreated,
    required this.reelIndex,
    required this.numberOfReel,
    required this.results,
  }) : super(key: key);

  final List<RollItem> rollItems;
  final double reelWidth;
  final double reelHeight;
  final double itemExtent;
  final int reelIndex;
  final bool shuffle;
  final int numberOfReel;
  final List<int> results;
  final Function(_ReelController) onCreated;

  @override
  State<_Reel> createState() => __ReelState();
}

class __ReelState extends State<_Reel> {
  late Timer timer;
  late _ReelController _laneController;
  final _scrollController = FixedExtentScrollController(initialItem: 0);
  int counter = 0;
  List<RollItem> _actualRollItems = [];

  @override
  void initState() {
    super.initState();
    _actualRollItems = widget.rollItems;
    if (widget.shuffle) _actualRollItems.shuffle();

    _laneController = _ReelController(
      start: _start,
      stop: _stop,
    );
    widget.onCreated(_laneController);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.reelWidth,
      height: widget.reelHeight,
      decoration: BoxDecoration(
        border: widget.numberOfReel == 4
            ? const Border(top: BorderSide(color: Color(0xFF3FA60D), width: 4))
            : null,
      ),
      child: Container(
        padding:
            widget.numberOfReel == 4 ? const EdgeInsets.only(bottom: 20) : null,
        decoration: BoxDecoration(
            color: widget.numberOfReel == 4 ? const Color(0xFFD8C6A2) : null,
            border: widget.numberOfReel == 4
                ? const Border(
                    top: BorderSide(color: Color(0xFF58B82A), width: 4))
                : null,
            borderRadius: widget.numberOfReel == 4
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  )
                : null,
            image: widget.numberOfReel == 3
                ? DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(widget.reelIndex == 0
                        ? 'assets/Vector2.png'
                        : widget.reelIndex == 1
                            ? 'assets/Vector1.png'
                            : 'assets/Vector.png'))
                : null),
        width: widget.reelWidth,
        height: widget.reelHeight,
        child: ListWheelScrollView.useDelegate(
          controller: _scrollController,
          itemExtent: widget.itemExtent,
          physics: const NeverScrollableScrollPhysics(),
          childDelegate: ListWheelChildLoopingListDelegate(
            children: _actualRollItems.map<Widget>((item) {
              return item.child;
            }).toList(),
          ),
        ),
      ),
    );
  }

  _start() {
    counter = 0;
    timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      _scrollController.animateToItem(
        counter,
        duration: const Duration(milliseconds: 50),
        curve: Curves.linear,
      );
      counter--;
    });
  }

  _stop({required int to}) {
    timer.cancel();
    final hitItemIndex =
        _actualRollItems.indexWhere((item) => item.index == to);

    final mod = (-counter) % _actualRollItems.length - 1;
    final addCount = (_actualRollItems.length - mod) +
        (_actualRollItems.length - hitItemIndex) -
        1;

    _scrollController.animateToItem(
      counter - addCount,
      duration: const Duration(milliseconds: 750),
      curve: Curves.decelerate,
    );
    setState(() {});
  }
}

class RollItem {
  const RollItem({
    required this.index,
    required this.child,
  });

  final int index;
  final Widget child;
}

class MyPainter extends CustomPainter {
  final Gradient gradient;
  final double sizeFactor;

  static const Gradient defaultGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xff0e0e0e), Color(0xff02153d)],
  );

  MyPainter({
    this.gradient = defaultGradient,
    this.sizeFactor = 15,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final gradientPaint = Paint()
      ..shader = gradient.createShader(
        Rect.fromLTRB(0, 0, size.width, size.height),
      );

    Path path = Path()
      ..moveTo(3 * sizeFactor, sizeFactor)
      ..quadraticBezierTo(
        size.width / 2,
        .75 * sizeFactor,
        size.width - 3 * sizeFactor,
        sizeFactor,
      )
      ..quadraticBezierTo(
        size.width - 2 * sizeFactor,
        sizeFactor,
        size.width - 2 * sizeFactor,
        2 * sizeFactor,
      )
      ..quadraticBezierTo(
        size.width - 1.75 * sizeFactor,
        size.height / 2,
        size.width - 2 * sizeFactor,
        size.height - 2 * sizeFactor,
      )
      ..quadraticBezierTo(
        size.width - 2 * sizeFactor,
        size.height - sizeFactor,
        size.width - 3 * sizeFactor,
        size.height - sizeFactor,
      )
      ..quadraticBezierTo(
        size.width / 2,
        size.height - .75 * sizeFactor,
        3 * sizeFactor,
        size.height - sizeFactor,
      )
      ..quadraticBezierTo(
        2 * sizeFactor,
        size.height - sizeFactor,
        2 * sizeFactor,
        size.height - 3 * sizeFactor,
      )
      ..quadraticBezierTo(
        1.75 * sizeFactor,
        size.height / 2,
        2 * sizeFactor,
        2 * sizeFactor,
      )
      ..quadraticBezierTo(
        2 * sizeFactor,
        sizeFactor,
        3 * sizeFactor,
        sizeFactor,
      )
      ..close();

    canvas.drawPath(path, gradientPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class MyCustomClipper extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.width);
    path.arcToPoint(Offset(size.height, size.height),
        radius: const Radius.elliptical(30, 10));
    path.lineTo(size.height, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
