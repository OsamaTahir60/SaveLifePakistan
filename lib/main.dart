import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'BloadModule/Splash/Splash.dart';
import 'plugins/size_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = 'pk_test_51LA7pHKWzDHFbbPHnuxPoeQ52dnPMJ7Y9d8Q3FZF16dEeXXT9gbMk66BXu6o9AafwozlA1pnuvoF579LuBgnNOjz00DoMZMJpT';

  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return  MaterialApp(
              theme: ThemeData(
                textTheme: GoogleFonts.latoTextTheme(
                  Theme.of(context).textTheme,
                ),
              ),
              debugShowCheckedModeBanner: false,
              title: 'Save Life',
               home: DemoPage(),
            );
          },
        );
      },
    );
  }
}

