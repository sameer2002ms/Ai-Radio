import 'package:ai_radio/model/radio.dart';
import 'package:ai_radio/utils/ai_utils.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MyRadio> radios = [];
  late MyRadio _selectedRadio;
  late Color _selectedcolor;
  bool _isPlaying = false;

  final AudioPlayer _audioPlayer = AudioPlayer();


  @override
  void initState() {
    super.initState();
    fetchRadios();
    _audioPlayer.onPlayerStateChanged.listen((event) {
      if(event == PlayerState.PLAYING)
    {
      _isPlaying == true;
    }else{
        _isPlaying == false;
      }
    });
  }

  fetchRadios() async {
    final radioJson = await rootBundle.loadString("assets/radio.json");
    radios = MyRadioList.fromJson(radioJson).radios;
    print(radios);
    setState(() {});
  }

  _playMusic(String url){
    _audioPlayer.play(url);
    _selectedRadio = radios.firstWhere((element) => element.url == url);
    print(_selectedRadio.name);
    setState(() {

    });
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
                primaryColor: Vx.purple300, secondaryColor: Colors.white),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
          ).h(80).p8(),
          //it will show the item count and show the radio output
          VxSwiper.builder(

            scrollDirection: Axis.horizontal,
            itemCount: radios.length,
            aspectRatio: 1.0,
            enlargeCenterPage: true,
            itemBuilder: (context, index) {
              final rad = radios[index];
              return VxBox(
                      child: ZStack(
                [
                  Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: VxBox(
                      child: rad.category.text.uppercase.white.make().px16(),
                    )
                        .height(40)
                        .black
                        .alignCenter
                        .withRounded(value: 10.0)
                        .make(),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: VStack(
                      [
                        rad.name.text.xl3.white.bold.make(),
                        5.heightBox,
                        rad.tagline.text.sm.semiBold.make(),
                      ],
                      crossAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: [
                        Icon(
                          CupertinoIcons.play_circle,
                          color: Colors.white,
                        ),
                        10.heightBox,
                        "Double tap to play".text.gray300.make(),
                      ].vStack())
                ],
                clip: (Clip.antiAlias),
              ))
                  .clip(Clip.antiAlias)
                  .bgImage(
                    DecorationImage(
                        image: NetworkImage(rad.image),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.darken)),
                  )
                  .border(color: Colors.black, width: 5.0)
                  .withRounded(value: 60.0)
                  .make()
                  .onInkDoubleTap(() {
                    _playMusic(rad.url);
              })
                  .p16();
            },
          ).centered(),
          Align(
            alignment: Alignment.bottomCenter,
            child: [
              if(_isPlaying)
                "Playing Now - ${_selectedRadio.name} FM" .text.makeCentered(),
              Icon(
             _isPlaying ?
             CupertinoIcons.stop_circle :
             CupertinoIcons.play_circle,
              color: Colors.white,
              size: 50.0,
            ).onInkTap(() {
              if(_isPlaying){
                _audioPlayer.stop();
              }else{
                _playMusic(_selectedRadio.url);
              }
              })

            ].vStack(),
          ).pOnly(bottom: context.percentHeight * 12)
        ],
        fit: StackFit.expand,
        clipBehavior: Clip.antiAlias,
      ),
    );
  }
}
