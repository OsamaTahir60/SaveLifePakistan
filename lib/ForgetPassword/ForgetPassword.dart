import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:save_life_blood_doner/Login/login.dart';
import 'package:save_life_blood_doner/plugins/size_config.dart';

import '../SwipeUp.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword>  with SingleTickerProviderStateMixin{
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late AnimationController _controller;
  Animation<double> ?_animation;

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
    )..addListener(
          () {
        setState(() {});
      },
    )..addStatusListener(
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.red,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 88* SizeConfig.heightMultiplier!,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.4,0.8],
                  colors: [
                    Colors.white,
                    Color(0xffFF6666),

                  ]),
            ),
            child: Column(
              children: [
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
                      height: 15.0 * SizeConfig.heightMultiplier!,
                      margin:
                      EdgeInsets.only(left: 2.0 * SizeConfig.heightMultiplier!),
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(3.0 * SizeConfig.heightMultiplier!),
                        child: const Image(
                            image: AssetImage(
                              'assets/save life logo icon.png',
                            )),
                      )),
                ),
                SizedBox(
                  height: 4.0 * SizeConfig.heightMultiplier!,
                ),
                SlideFadeTransition(
                  curve: Curves.elasticOut,
                  delayStart: const Duration(milliseconds: 500),
                  animationDuration: const Duration(milliseconds: 1200),
                  offset: 0.2,
                  direction: Direction.horizontal,
                  child: Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 5.0 * SizeConfig.heightMultiplier!),
                    child: Text(
                      "Reset Your Password!",
                      style: TextStyle(
                          color: const Color(0xffFF193B),
                          fontSize: 2.5 * SizeConfig.textMultiplier!
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.0 * SizeConfig.heightMultiplier!,
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
                    autofillHints: const [AutofillHints.email],
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 2.0  * SizeConfig.textMultiplier!,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Please Enter Your Email"),
                          backgroundColor: Colors.red,
                        ));
                      }
                      // reg expression for email validation
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Please Enter a valid email"),
                          backgroundColor: Colors.red,
                        ));
                      }
                      return null;
                    },
                    onSaved: (value) {
                      email.text = value!;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 2.0 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w400),
                      filled: true,
                      fillColor: const Color(0xffEFEFEF),
                      contentPadding: EdgeInsets.all(
                          2.5 * SizeConfig.heightMultiplier!),
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
                SizedBox(
                  height: 8.0 * SizeConfig.heightMultiplier!,
                ),
                Container(
                    width: 80 * SizeConfig.widthMultiplier!,
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: TextButton(
                      onPressed: () {
                        const CircularProgressIndicator();
                        resetPassword(email.text);
                        email.clear();
                      },
                      child: Text("Submit",
                        style: TextStyle(
                            color:Colors.white,
                            fontSize: 1.9 *SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w400
                        ),),
                    )
                ),

              ],
            ),
          ),
        )
    );
  }

  @override
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Email Has Been Send To Your Register Email"),
      backgroundColor: Colors.red,
    ));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SwipeUp()));
  }
}
