import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:save_life_blood_doner/BloadModule/Home/Home.dart';
import 'package:save_life_blood_doner/ForgetPassword/ForgetPassword.dart';
import 'package:save_life_blood_doner/Signup/Signup.dart';
import 'package:save_life_blood_doner/SwipeUp.dart';
import 'package:save_life_blood_doner/plugins/size_config.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _isHidden = true;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String? errorMessage;

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
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.red,
          ),
        ),
      ),
      body: Container(
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
          child: ListView(
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
                          )
                      ),
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
                margin: EdgeInsets.only(left: 5.0 * SizeConfig.heightMultiplier!,right: 5.0 * SizeConfig.heightMultiplier!),
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
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
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
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
