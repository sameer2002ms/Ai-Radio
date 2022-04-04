import 'package:ai_radio/model/radio.dart';
import 'package:ai_radio/utils/ai_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  late List <MyRadio> radios;
  @override
  void initState() {
    super.initState();
    fetchRadios();
  }
  fetchRadios()  async {
    final radioJson = await rootBundle.loadString("assets/radio.json");
    radios = MyRadioList.fromJson(radioJson).radios;
    print(radios);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: Stack(
        children: [
          //this has been used for color gradient
          // by mixing the two color primarycolor1 and primarycolor2
          VxAnimatedBox()
              .size(context.screenWidth, context.screenHeight)
              .withGradient(
                LinearGradient(
                  colors: [
                    AIUtil.primaryColor1,
                    AIUtil.PrimaryColor2,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              )
              .make(),
          //here we have added the transparent app bar
          //shimmer is used for effect
          AppBar(
            title: "AI Radio".text.xl2.bold.white.make().shimmer(
              primaryColor: Vx.purple300, secondaryColor: Colors.white
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
          ).h(80).p8()
        ],
      ),


    );
  }
}
