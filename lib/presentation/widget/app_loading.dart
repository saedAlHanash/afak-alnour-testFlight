import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../resources/color_manger.dart';

class AppLoading extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final Widget? child;
  const AppLoading({Key? key, this.width, this.height, this.borderRadius = 0, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Shimmer.fromColors(
          baseColor: ColorManger.lightGrey, //const Color(0xFFf2f2f2),
          highlightColor: ColorManger.white,
          child: Container(
            color: Colors.blue,
            width: width,
            height: height,
          ),
        ),
      ),
    );
  }
}

class AppLoadingLogo extends StatelessWidget {
  final Color? color;
  const AppLoadingLogo({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(color: color);
  }
}
