import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:share_plus/share_plus.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // String? iconName;
  bool isIPhone = false;

  Future<void> _initPlatformState() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    setState(() {
      isIPhone = iosInfo.model.toLowerCase().contains('iphone');
    });
  }

  @override
  void initState() {
    super.initState();
    _initPlatformState();
    // _pc();
  }

  // void _pc() async {
  //   if (await FlutterDynamicIcon.supportsAlternateIcons) {
  //     final name = await FlutterDynamicIcon.getAlternateIconName();
  //     setState(() {
  //       iconName = name ?? Icon.values.first.name;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8C6A2),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 24, 60, 90),
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
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Image.asset('assets/setting.png'),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                            onTap: () {
                              Share.share(
                                  'Check out this Pln-Up: Lucky Days game!');
                            },
                            child: Image.asset('assets/share.png')),
                        const SizedBox(
                          height: 4,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Jumeira(
                                    jumera:
                                        'https://docs.google.com/document/d/1sgVIB2uFDz11jGnJSxWCCaI8QT3Eo3hg0iTts4ZVrNY/edit?usp=sharing'),
                              ));
                            },
                            child: Image.asset('assets/privacy.png')),
                        const SizedBox(
                          height: 4,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Jumeira(
                                    jumera:
                                        'https://docs.google.com/document/d/1B0WQxOhWxPkZCb0pWexAarQuf0lv04aJoaqH4NxSwv0/edit?usp=sharing'),
                              ));
                            },
                            child: Image.asset('assets/terms.png'))
                      ],
                    ),
                  ),
                  // if (isIPhone)
                  //   Expanded(
                  //     flex: 4,
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text('App icon'),
                  //             const SizedBox(height: 8),
                  //             Wrap(
                  //               spacing: 8,
                  //               runSpacing: 8,
                  //               children: Icon.values
                  //                   .map(
                  //                     (e) => GestureDetector(
                  //                       onTap: () async {
                  //                         try {
                  //                           if (await FlutterDynamicIcon
                  //                               .supportsAlternateIcons) {
                  //                             await FlutterDynamicIcon
                  //                                 .setAlternateIconName(e.name);
                  //                             setState(() {
                  //                               iconName = e.name;
                  //                             });
                  //                           }
                  //                         } catch (_) {}
                  //                       },
                  //                       child: Container(
                  //                         decoration: BoxDecoration(
                  //                           borderRadius:
                  //                               BorderRadius.circular(16),
                  //                           color: iconName == e.name
                  //                               ? const Color(0xFF3FA60D)
                  //                               : null,
                  //                         ),
                  //                         padding: const EdgeInsets.all(4),
                  //                         child: ClipRRect(
                  //                           borderRadius:
                  //                               BorderRadius.circular(12),
                  //                           child: Image.asset(
                  //                             e.asset,
                  //                             width: 50,
                  //                             height: 50,
                  //                             fit: BoxFit.cover,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   )
                  //                   .toList(),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // const Spacer(flex: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// enum Icon {
//   iconDefault('assets/icons/icon_default.png', 'icon_default'),
//   icon1('assets/icons/icon1.png', 'icon1'),
//   icon2('assets/icons/icon2.png', 'icon2'),
//   icon3('assets/icons/icon3.png', 'icon3'),
//   icon4('assets/icons/icon4.png', 'icon4'),
//   icon5('assets/icons/icon5.png', 'icon5');

//   const Icon(this.asset, this.name);

//   final String asset;
//   final String name;
// }

class Jumeira extends StatefulWidget {
  const Jumeira({super.key, required this.jumera});
  final String jumera;

  @override
  State<Jumeira> createState() => _JumeiraState();
}

class _JumeiraState extends State<Jumeira> {
  var _progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            InAppWebView(
              onLoadStop: (controller, url) {
                controller.evaluateJavascript(
                    source:
                        "javascript:(function() { var ele=document.getElementsByClassName('docs-ml-header-item docs-ml-header-drive-link');ele[0].parentNode.removeChild(ele[0]);var footer = document.getelementsbytagname('footer')[0];footer.parentnode.removechild(footer);})()");
              },
              onProgressChanged: (controller, progress) => setState(() {
                _progress = progress;
              }),
              initialUrlRequest: URLRequest(
                url: Uri.parse(widget.jumera),
              ),
            ),
            if (_progress != 100)
              Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
