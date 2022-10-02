import 'package:flutter/material.dart';
import 'package:save_life_blood_doner/BloadModule/Home/Home.dart';
import 'package:save_life_blood_doner/BloadModule/Map/CurrentLocationMap.dart';
import 'package:save_life_blood_doner/plugins/size_config.dart';

class BloodOrder extends StatefulWidget {
  const BloodOrder({Key? key}) : super(key: key);

  @override
  _BloodOrderState createState() => _BloodOrderState();
}

class _BloodOrderState extends State<BloodOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton (
          icon: const Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()
                ));
          },
        ),
        elevation: 0,
        title: Text("You can now donate and save life",style: TextStyle(
            color: const Color(0xff00ACB1),
            fontWeight: FontWeight.bold,
            fontSize: 2.5 * SizeConfig.textMultiplier!),
        ),
      ),
        body: SafeArea(
            left: true,
            top: true,
            right: true,
            bottom: true,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffFF193B),
                    Colors.white
                  ]),
            ),
            child: ListView(
              children: [
                SizedBox(
                  height: 50.0 * SizeConfig.heightMultiplier!,
                  child:Image.asset('assets/Artboard 1@2x.png'),

                ),
                Container(
                    margin: EdgeInsets.only(
                        left: 4.0 * SizeConfig.heightMultiplier!,right: 4.0 * SizeConfig.heightMultiplier!
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xfff00000),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextButton(
                      onPressed: ()  {
                      },
                      child: Text("Nearby Location",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 2.5 * SizeConfig.textMultiplier!),),
                    )
                ),
                SizedBox(height: 2.0* SizeConfig.heightMultiplier!,),
                Container(
                    margin: EdgeInsets.only(
                        left: 5.0 * SizeConfig.heightMultiplier!,right: 5.0 * SizeConfig.heightMultiplier!
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xfff00000),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextButton(
                      onPressed: ()  {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const CurrentLocationMap()
                            ));
                      },
                      child: Text("Blood Group",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 2.5 * SizeConfig.textMultiplier!),),
                    )
                ),
                SizedBox(height: 2.0* SizeConfig.heightMultiplier!,),
                Container(
                    margin: EdgeInsets.only(
                        left: 5.0 * SizeConfig.heightMultiplier!,right: 5.0 * SizeConfig.heightMultiplier!
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xfff00000),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextButton(
                      onPressed: ()  {
                      },
                      child: Text("Show Requests",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 2.5 * SizeConfig.textMultiplier!),),
                    )
                ),
                SizedBox(height: 2.0* SizeConfig.heightMultiplier!,),
                Container(
                    margin: EdgeInsets.only(
                        left: 5.0 * SizeConfig.heightMultiplier!,right: 5.0 * SizeConfig.heightMultiplier!
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xfff00000),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextButton(
                      onPressed: ()  {
                      },
                      child: Text("Compain",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 2.5 * SizeConfig.textMultiplier!),),
                    )
                ),
                SizedBox(height: 2.0* SizeConfig.heightMultiplier!,),

              ],
            ),
          )
        )
    );
  }
}
