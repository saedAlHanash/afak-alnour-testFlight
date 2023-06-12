import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: HexColor('#fcfcff'),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.3,
          ),
          Image.asset('image/Logo-Afaq.gif',fit: BoxFit.fitHeight,width: width,height: height * 0.4,),
          SizedBox(
            height: height * 0.03,
          ),
          AutoSizeText(
            'Afaq-Alnour Academy',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.bold),
            textScaleFactor: 1,
            minFontSize: 24,
            maxFontSize: 26,
          ),
          Spacer(),
          AutoSizeText(
            'Powerd BY CHI Co',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.bold),
            textScaleFactor: 1,
            minFontSize: 16,
            maxFontSize: 18,
          ),
          SizedBox(
            height: height * 0.02,
          ),
        ],
      ),
    );
  }
}
