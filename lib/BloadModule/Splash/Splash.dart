// class MyClipPath extends AnimatedWidget {
//   final Animation<double> animation;
//
//   MyClipPath(this.animation) : super(listenable: animation);
//
//   final Color backgroundColor = Colors.red;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 5.0 * SizeConfig.heightMultiplier!,
//         ),
//         Padding(
//           padding: EdgeInsets.all(7.0 * SizeConfig.heightMultiplier!),
//           child: const Image(
//               image: AssetImage(
//             'assets/logo.png',
//           )),
//         ),
//         Expanded(
//           child: Stack(
//             alignment: Alignment.bottomLeft,
//               children: [
//             Positioned(
//               bottom: 0,
//               right: animation.value,
//               child: ClipPath(
//                 clipper: BottomWaveClipper(),
//                 child: Opacity(
//                   opacity: 0.9,
//                   child: Container(
//                     color: backgroundColor,
//                     width: 250 * SizeConfig.widthMultiplier!,
//                     height: 30  * SizeConfig.heightMultiplier!,
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               left: animation.value,
//               child: ClipPath(
//                 clipper: BottomWaveClipper(),
//                 child: Opacity(
//                   opacity: 0.9,
//                   child: Container(
//                     color: backgroundColor,
//                     width: 250 * SizeConfig.widthMultiplier!,
//                     height: 30  * SizeConfig.heightMultiplier!,
//                   ),
//                 ),
//               ),
//             ),
//                 Positioned(
//                   bottom: 0,
//                   left: animation.value,
//                   child: ClipPath(
//                     clipper: BottomWaveClipper(),
//                     child: Opacity(
//                       opacity: 0.9,
//                       child: Container(
//                         color: backgroundColor,
//                         width: 250 * SizeConfig.widthMultiplier!,
//                         height: 30  * SizeConfig.heightMultiplier!,
//                       ),
//                     ),
//                   ),
//                 ),
//             Positioned(
//              bottom: 0,
//                left: 0,
//                right: 0,
//                child:  Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: [
//                    // SizedBox(width: 6.0 * SizeConfig.widthMultiplier!,),
//                    Column(
//                      children: [
//                        SizedBox(
//                          height: 10 * SizeConfig.heightMultiplier!,
//                          child: const Image(
//                              image: AssetImage(
//                                'assets/dawai.png',
//                              )),
//                        ),
//                        const Text(
//                          "Dawai",
//                          style: TextStyle(
//                              fontSize: 15,
//                              fontWeight: FontWeight.w400,
//                              color: Colors.white),
//                        )
//                      ],
//                    ),
//                    // SizedBox(width: 6.0 * SizeConfig.widthMultiplier!,),
//                    Column(
//                      children: [
//                        SizedBox(
//                          height: 10 * SizeConfig.heightMultiplier!,
//                          child: const Image(
//                              image: AssetImage(
//                                'assets/blood.png',
//                              )),
//                        ),
//                        const Text(
//                          "Blood",
//                          style: TextStyle(
//                              fontSize: 15,
//                              fontWeight: FontWeight.w400,
//                              color: Colors.white),
//                        )
//                      ],
//                    ),
//                    // SizedBox(width: 6.0 * SizeConfig.widthMultiplier!,),
//                    Column(
//                      children: [
//                        SizedBox(
//                          height: 10 * SizeConfig.heightMultiplier!,
//                          child: const Image(
//                              image: AssetImage(
//                                'assets/consultation.png',
//                              )),
//                        ),
//                        const Text(
//                          "Consultation",
//                          style: TextStyle(
//                              fontSize: 15,
//                              fontWeight: FontWeight.w400,
//                              color: Colors.white),
//                        )
//                      ],
//                    ),
//                    // SizedBox(width: 6.0 * SizeConfig.widthMultiplier!,),
//                    Column(
//                      children: [
//                        SizedBox(
//                          height: 10 * SizeConfig.heightMultiplier!,
//                          child: const Image(
//                              image: AssetImage(
//                                'assets/wiki.png',
//                              )),
//                        ),
//                        const Text(
//                          "Wikipedia",
//                          style: TextStyle(
//                              fontSize: 15,
//                              fontWeight: FontWeight.w400,
//                              color: Colors.white),
//                        )
//                      ],
//                    ),
//                  ],
//                ))
//
//           ]),
//         ),
//       ],
//     );
//   }
// }
//
//
// class BottomWaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = new Path();
//
//     path.lineTo(0.0, 40.0);
//     path.lineTo(0.0, size.height);
//     path.lineTo(size.width, size.height);
//     path.lineTo(size.width, 40.0);
//
//     for (int i = 0; i < 10; i++) {
//       if (i % 2 == 0) {
//         path.quadraticBezierTo(
//             size.width - (size.width / 16) - (i * size.width / 8),
//             0.0,
//             size.width - ((i + 1) * size.width / 8),
//             size.height - 160);
//       } else {
//         path.quadraticBezierTo(
//             size.width - (size.width / 16) - (i * size.width / 8),
//             size.height - 120,
//             size.width - ((i + 1) * size.width / 8),
//             size.height - 160);
//       }
//     }
//
//     path.lineTo(0.0, 40.0);
//     path.close();
//
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
//
//
// class MyAnimation extends StatefulWidget {
//   @override
//   _MyAnimationState createState() => _MyAnimationState();
// }
//
// class _MyAnimationState extends State<MyAnimation> with SingleTickerProviderStateMixin {
//
//   Animation<double> ?animation;
//   AnimationController ?_controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//         duration: const Duration(seconds: 11),
//         vsync: this)..repeat();
//     // Timer(
//     //     const Duration(seconds: 2),
//     //     () => Navigator.pushReplacement(
//     //         context, MaterialPageRoute(builder: (context) => const SwipeUp())));
//
//     animation = Tween<double>(begin: -500, end: 0).animate(_controller!);
//   }
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MyClipPath(
//         animation!
//     );
//   }
// }

import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:save_life_blood_doner/BloadModule/Home/Home.dart';
import 'package:vector_math/vector_math.dart' as Vector;

import '../../plugins/size_config.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();

  DemoPage({Key? key}) : super(key: key) {
    timeDilation = 3;
  }
}

class _DemoPageState extends State<DemoPage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    user != null ?
    Future.delayed(Duration.zero, () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Home()),
              (route) => false);
    }):
    Timer(
        const Duration(seconds: 2),
            () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Home()),
                    (route) => false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(MediaQuery.of(context).size.width, 200.0);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          DemoBody(size: size, xOffset: 0, yOffset: 0, color: Colors.red),
          Opacity(
            opacity: 1,
            child: DemoBody(
              size: size,
              xOffset: 70,
              yOffset: 10,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}

class DemoBody extends StatefulWidget {
  final Size size;
  final int xOffset;
  final int yOffset;
  final Color color;

  const DemoBody(
      {Key? key,
      required this.size,
      required this.xOffset,
      required this.yOffset,
      required this.color})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DemoBodyState();
  }
}

class _DemoBodyState extends State<DemoBody> with TickerProviderStateMixin {
  late AnimationController animationController;
  List<Offset> animList1 = [];

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    animationController.addListener(() {
      animList1.clear();
      for (int i = -2 - widget.xOffset;
          i <= widget.size.width.toInt() + 2;
          i++) {
        animList1.add(Offset(
            i.toDouble() + widget.xOffset,
            sin((animationController.value * 360 - i) %
                        360 *
                        Vector.degrees2Radians) *
                    20 +
                50 +
                widget.yOffset));
      }
    });
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: Column(
            children: [
              SizedBox(
                height: 5.0 * SizeConfig.heightMultiplier!,
              ),
              Padding(
                padding: EdgeInsets.all(7.0 * SizeConfig.heightMultiplier!),
                child: const Image(
                    image: AssetImage(
                  'assets/logo.png',
                )),
              ),
              Expanded(
                  child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    top: 18.0 * SizeConfig.heightMultiplier!,
                    left: 0,
                    right: 0,
                    child: AnimatedBuilder(
                      animation: CurvedAnimation(
                        parent: animationController,
                        curve: Curves.easeInOut,
                      ),
                      builder: (context, child) => ClipPath(
                        child: widget.color == null
                            ? Image.asset(
                                'images/demo5bg.jpg',
                                width: widget.size.width,
                                height: widget.size.height,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: widget.size.width,
                                height: widget.size.height,
                                color: widget.color,
                              ),
                        clipper:
                            WaveClipper(animationController.value, animList1),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // SizedBox(width: 6.0 * SizeConfig.widthMultiplier!,),
                          Column(
                            children: [
                              SizedBox(
                                height: 10 * SizeConfig.heightMultiplier!,
                                child: const Image(
                                    image: AssetImage(
                                  'assets/dawai.png',
                                )),
                              ),
                              const Text(
                                "Dawai",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              )
                            ],
                          ),
                          // SizedBox(width: 6.0 * SizeConfig.widthMultiplier!,),
                          Column(
                            children: [
                              SizedBox(
                                height: 10 * SizeConfig.heightMultiplier!,
                                child: const Image(
                                    image: AssetImage(
                                  'assets/blood.png',
                                )),
                              ),
                              const Text(
                                "Blood",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              )
                            ],
                          ),
                          // SizedBox(width: 6.0 * SizeConfig.widthMultiplier!,),
                          Column(
                            children: [
                              SizedBox(
                                height: 10 * SizeConfig.heightMultiplier!,
                                child: const Image(
                                    image: AssetImage(
                                  'assets/consultation.png',
                                )),
                              ),
                              const Text(
                                "Consultation",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              )
                            ],
                          ),
                          // SizedBox(width: 6.0 * SizeConfig.widthMultiplier!,),
                          Column(
                            children: [
                              SizedBox(
                                height: 10 * SizeConfig.heightMultiplier!,
                                child: const Image(
                                    image: AssetImage(
                                  'assets/wiki.png',
                                )),
                              ),
                              const Text(
                                "Wikipedia",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      ))
                ],
              ))
            ],
          ),
        ));
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animation;

  List<Offset> waveList1 = [];

  WaveClipper(this.animation, this.waveList1);

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.addPolygon(waveList1, false);

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      animation != oldClipper.animation;
}
