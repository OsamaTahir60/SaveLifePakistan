import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:save_life_blood_doner/Signup/Signup.dart';
import 'package:save_life_blood_doner/plugins/size_config.dart';

import 'BloadModule/Home/Home.dart';
import 'ForgetPassword/ForgetPassword.dart';

class SwipeUp extends StatefulWidget {
  const SwipeUp({Key? key}) : super(key: key);

  @override
  _SwipeUpState createState() => _SwipeUpState();
}

class _SwipeUpState extends State<SwipeUp> with SingleTickerProviderStateMixin {
  bool isnew = true;
  double position = 0;
  TextEditingController search = TextEditingController();
  bool isFinished = false;
  bool isVisible = false;

  void showWidget() {
    setState(() {
      isVisible = true;
    });
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isHidden = true;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  User? user = FirebaseAuth.instance.currentUser;

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Home())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "Field Cannot Be Empty.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  void hideWidget() {
    setState(() {
      isVisible = false;
    });
  }

  late AnimationController _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: .7, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _controller.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _controller.forward();
          }
        },
      );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        left: true,
        bottom: true,
        right: true,
        child: PageView(
          scrollDirection: Axis.vertical,
          children: [
            Stack(
              children: [
                Container(
                  height: 27.0 * SizeConfig.heightMultiplier!,
                  color: const Color(0xffFF1313),
                  child: Container(
                    height: 5.0 * SizeConfig.heightMultiplier!,
                    margin: EdgeInsets.only(
                        top: 2 * SizeConfig.heightMultiplier!,
                        bottom: 18 * SizeConfig.heightMultiplier!,
                        left: 4 * SizeConfig.heightMultiplier!,
                        right: 4 * SizeConfig.heightMultiplier!),
                    decoration: BoxDecoration(
                      color: const Color(0xffEFEFEF),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      autofillHints: const [AutofillHints.name],
                      // controller: name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Name Cannot Empty"),
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          return null;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            isVisible == true ? hideWidget() : showWidget();
                          },
                          child: SizedBox(
                            height: 1.5 * SizeConfig.heightMultiplier!,
                            width: 0 * SizeConfig.widthMultiplier!,
                            child: const FittedBox(
                              child: Image(
                                  height: 3.0,
                                  width: 5.0,
                                  image: AssetImage(
                                    'assets/search.png',
                                  )),
                            ),
                          ),
                        ),
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 2.5 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w400),
                        filled: true,
                        fillColor: const Color(0xffEFEFEF),
                        contentPadding:
                            EdgeInsets.all(2.5 * SizeConfig.heightMultiplier!),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffEFEFEF)),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffEFEFEF)),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                    visible: isVisible,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                height: 4 * SizeConfig.heightMultiplier!,
                                width: 25.0 * SizeConfig.widthMultiplier!,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xffEFEFEF),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                margin: EdgeInsets.only(
                                  top: 11.0 * SizeConfig.heightMultiplier!,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 5 * SizeConfig.heightMultiplier!,
                                      width: 7 * SizeConfig.widthMultiplier!,
                                      margin: EdgeInsets.only(
                                          left:
                                              1 * SizeConfig.heightMultiplier!),
                                      child: const Image(
                                          image: AssetImage(
                                        'assets/bload2.png',
                                      )),
                                    ),
                                    Text(
                                      "Blood",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              2.2 * SizeConfig.textMultiplier!,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                )),
                            Container(
                                height: 4 * SizeConfig.heightMultiplier!,
                                width: 25.0 * SizeConfig.widthMultiplier!,
                                decoration: BoxDecoration(
                                  color: const Color(0xffEFEFEF),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                margin: EdgeInsets.only(
                                  top: 11.0 * SizeConfig.heightMultiplier!,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 6 * SizeConfig.heightMultiplier!,
                                      width: 7 * SizeConfig.widthMultiplier!,
                                      margin: EdgeInsets.only(
                                          left: 1.8 *
                                              SizeConfig.heightMultiplier!),
                                      child: const Image(
                                          image: AssetImage(
                                        'assets/medicine.png',
                                      )),
                                    ),
                                    Text(
                                      "Dawai",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              2.2 * SizeConfig.textMultiplier!,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                )),
                            FittedBox(
                              child: Container(
                                  height: 4 * SizeConfig.heightMultiplier!,
                                  width: 35.0 * SizeConfig.widthMultiplier!,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffEFEFEF),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  margin: EdgeInsets.only(
                                    top: 11.0 * SizeConfig.heightMultiplier!,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height:
                                            6 * SizeConfig.heightMultiplier!,
                                        width: 7 * SizeConfig.widthMultiplier!,
                                        margin: EdgeInsets.only(
                                            left: 1.8 *
                                                SizeConfig.heightMultiplier!),
                                        child: const Image(
                                            image: AssetImage(
                                          'assets/doctor.png',
                                        )),
                                      ),
                                      Text(
                                        "Consultant",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 2.2 *
                                                SizeConfig.textMultiplier!,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  )),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Container(
                                  height: 4 * SizeConfig.heightMultiplier!,
                                  width: 26.0 * SizeConfig.widthMultiplier!,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffEFEFEF),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  margin: EdgeInsets.only(
                                    top: 1 * SizeConfig.heightMultiplier!,
                                    left: 2 * SizeConfig.heightMultiplier!,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height:
                                            6 * SizeConfig.heightMultiplier!,
                                        width: 7 * SizeConfig.widthMultiplier!,
                                        margin: EdgeInsets.only(
                                            left: 1 *
                                                SizeConfig.heightMultiplier!),
                                        child: const Image(
                                            image: AssetImage(
                                          'assets/dictionary.png',
                                        )),
                                      ),
                                      Text(
                                        "Wikipedia",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 2.2 *
                                                SizeConfig.textMultiplier!,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ],
                    )),
                Center(
                  child: Container(
                      width: 75.0 * SizeConfig.widthMultiplier!,
                      height: 50.0 * SizeConfig.heightMultiplier!,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      ),
                      child: Container(
                          height: 50.0 * SizeConfig.heightMultiplier!,
                          width: 70.0 * SizeConfig.widthMultiplier!,
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(24.0)),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.5, 0.9],
                                colors: [Colors.white, Color(0xffFF6666)]),
                          ),
                          margin: EdgeInsets.only(
                            left: 0.0 * SizeConfig.heightMultiplier!,
                          ),
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 5.0 * SizeConfig.heightMultiplier!,
                                left: 9.0 * SizeConfig.heightMultiplier!,
                                right: 9.0 * SizeConfig.heightMultiplier!),
                            child: const Image(
                                image: AssetImage(
                              'assets/save life logo icon.png',
                            )),
                          ))),
                ),
                Center(
                    child: Container(
                  margin:
                      EdgeInsets.only(top: 48.0 * SizeConfig.heightMultiplier!),
                  height: 14.0 * SizeConfig.heightMultiplier!,
                  child: const Image(
                      image: AssetImage(
                    'assets/arrawup.png',
                  )),
                )),
                Center(
                  child: Container(
                    height: 25.0 * SizeConfig.heightMultiplier!,
                    width: 25.0 * SizeConfig.widthMultiplier!,
                    margin:
                        EdgeInsets.only(top: 20 * SizeConfig.heightMultiplier!),
                    child: Lottie.asset("assets/lottie/arrowUp.json"),
                  ),
                ),
                Center(
                    child: Container(
                  margin:
                      EdgeInsets.only(top: 30.0 * SizeConfig.heightMultiplier!),
                  child: const Text(
                    "Swipe up to Sign in ",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                )),
                // const AnimateImage(),
              ],
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.4,
                        0.8
                      ],
                      colors: [
                        Colors.white,
                        Color(0xffFF6666),
                      ]),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.0 * SizeConfig.heightMultiplier!,
                    ),
                    SlideFadeTransition(
                      curve: Curves.elasticOut,
                      delayStart: const Duration(milliseconds: 500),
                      animationDuration: const Duration(milliseconds: 1200),
                      offset: 0.2,
                      direction: Direction.horizontal,
                      child: Container(
                          height: 15.0 * SizeConfig.heightMultiplier!,
                          margin: EdgeInsets.only(
                              left: 2.0 * SizeConfig.heightMultiplier!),
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(
                                3.0 * SizeConfig.heightMultiplier!),
                            child: const Image(
                                image: AssetImage(
                                  'assets/save life logo icon.png',
                                )),
                          )),
                    ),

                    SizedBox(
                      height: 1.0 * SizeConfig.heightMultiplier!,
                    ),
                    SlideFadeTransition(
                      curve: Curves.elasticOut,
                      delayStart: const Duration(milliseconds: 500),
                      animationDuration: const Duration(milliseconds: 1200),
                      offset: 0.2,
                      direction: Direction.horizontal,
                      child: Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(
                            left: 5.0 * SizeConfig.heightMultiplier!),
                        child: Text(
                          "Hi There!",
                          style: TextStyle(
                              color: const Color(0xffFF193B),
                              fontSize: 2.5 * SizeConfig.textMultiplier!),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.0 * SizeConfig.heightMultiplier!,
                    ),
                    SlideFadeTransition(
                      curve: Curves.elasticOut,
                      delayStart: const Duration(milliseconds: 500),
                      animationDuration: const Duration(milliseconds: 1200),
                      offset: -0.2,
                      direction: Direction.vertical,
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                height: 8.0 * SizeConfig.heightMultiplier!,
                                margin: EdgeInsets.only(
                                    left: 4 * SizeConfig.heightMultiplier!,
                                    right: 4 * SizeConfig.heightMultiplier!),
                                decoration: BoxDecoration(
                                  color: const Color(0xffEFEFEF),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: email,
                                  style: TextStyle(
                                    fontSize:
                                    2.0 * SizeConfig.textMultiplier!,
                                    color: Colors.grey,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Save-life id,Email,Phone No',
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                        2 * SizeConfig.textMultiplier!,
                                        fontWeight: FontWeight.w400),
                                    filled: true,
                                    fillColor: const Color(0xffEFEFEF),
                                    contentPadding: EdgeInsets.all(
                                        2.5 * SizeConfig.heightMultiplier!),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffEFEFEF)),
                                      borderRadius:
                                      BorderRadius.circular(50.0),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffEFEFEF)),
                                      borderRadius:
                                      BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.0 * SizeConfig.heightMultiplier!,
                              ),
                              Container(
                                height: 8.0 * SizeConfig.heightMultiplier!,
                                margin: EdgeInsets.only(
                                    left: 4 * SizeConfig.heightMultiplier!,
                                    right: 4 * SizeConfig.heightMultiplier!),
                                decoration: BoxDecoration(
                                  color: const Color(0xffEFEFEF),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: _isHidden,
                                  controller: password,
                                  style: TextStyle(
                                    fontSize:
                                    2.0 * SizeConfig.textMultiplier!,
                                    color: Colors.grey,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                        2 * SizeConfig.textMultiplier!,
                                        fontWeight: FontWeight.w400),
                                    suffixIcon: InkWell(
                                      onTap: _togglePasswordView,
                                      child: Icon(
                                        _isHidden
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xffEFEFEF),
                                    contentPadding: EdgeInsets.all(
                                        2.5 * SizeConfig.heightMultiplier!),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffEFEFEF)),
                                      borderRadius:
                                      BorderRadius.circular(50.0),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffEFEFEF)),
                                      borderRadius:
                                      BorderRadius.circular(50.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 2.0 * SizeConfig.heightMultiplier!,
                    ),

                    SlideFadeTransition(
                      curve: Curves.elasticOut,
                      delayStart: const Duration(milliseconds: 500),
                      animationDuration: const Duration(milliseconds: 1200),
                      offset: 0.2,
                      direction: Direction.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 5.0 * SizeConfig.heightMultiplier!,
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: 'Forgotten password!',
                                style: TextStyle(
                                    color: const Color(0xffFF193B),
                                    fontSize:
                                    1.6 * SizeConfig.textMultiplier!),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    HapticFeedback.lightImpact();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const ForgetPassword()));
                                  },
                              ),
                            ),
                          ),
                          SizedBox(width: 0 * SizeConfig.widthMultiplier!),
                          Container(
                            margin: EdgeInsets.only(
                              right: 5.0 * SizeConfig.heightMultiplier!,
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: 'Create a new Account',
                                style: TextStyle(
                                    color: const Color(0xffFF193B),
                                    fontSize:
                                    1.6 * SizeConfig.textMultiplier!),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    HapticFeedback.lightImpact();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const SignUp()));
                                  },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 5.0 * SizeConfig.heightMultiplier!,
                    ),
                    // buildAuthenticate(context),

                    Container(
                        width: 40 * SizeConfig.widthMultiplier!,
                        decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: TextButton(
                          onPressed: () {signIn(email.text, password.text);  },
                          child: Text("SIGN-IN",
                            style: TextStyle(
                                color:Colors.white,
                                fontSize: 1.9 *SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.w400
                            ),),
                        )
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

}

class AnimateImage extends StatefulWidget {
  const AnimateImage({Key? key}) : super(key: key);

  @override
  _AnimateImageState createState() => _AnimateImageState();
}

class _AnimateImageState extends State<AnimateImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat(reverse: true);
  late final Animation<Offset> _animation = Tween(
    begin: Offset.zero,
    end: const Offset(0, 0.08),
  ).animate(controller);

  @override
  void initState() {
    controller.dispose();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: _animation,
        child: InkWell(onTap: () {}, child: Image.asset('assets/arrawup.png')));
  }
}

enum Direction { vertical, horizontal }

class SlideFadeTransition extends StatefulWidget {
  final Widget child;

  final double offset;

  final Curve curve;

  final Direction direction;

  final Duration delayStart;

  final Duration animationDuration;

  const SlideFadeTransition({
    required this.child,
    this.offset = 1.0,
    this.curve = Curves.easeIn,
    this.direction = Direction.vertical,
    this.delayStart = const Duration(seconds: 0),
    this.animationDuration = const Duration(milliseconds: 800),
  });

  @override
  _SlideFadeTransitionState createState() => _SlideFadeTransitionState();
}

class _SlideFadeTransitionState extends State<SlideFadeTransition>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _animationSlide;

  late AnimationController _animationController;

  late Animation<double> _animationFade;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    if (widget.direction == Direction.vertical) {
      _animationSlide =
          Tween<Offset>(begin: Offset(0, widget.offset), end: const Offset(0, 0))
              .animate(CurvedAnimation(
        curve: widget.curve,
        parent: _animationController,
      ));
    } else {
      _animationSlide =
          Tween<Offset>(begin: Offset(widget.offset, 0), end: const Offset(0, 0))
              .animate(CurvedAnimation(
        curve: widget.curve,
        parent: _animationController,
      ));
    }

    _animationFade =
        Tween<double>(begin: -1.0, end: 1.0).animate(CurvedAnimation(
      curve: widget.curve,
      parent: _animationController,
    ));

    Timer(widget.delayStart, () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _animationFade,
        child: SlideTransition(
          position: _animationSlide,
          child: widget.child,
        ));
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
