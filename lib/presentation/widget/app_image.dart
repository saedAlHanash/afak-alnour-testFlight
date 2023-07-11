import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

import '../../app/constants.dart';
import '../resources/assets_manger.dart';
import '../resources/values_manger.dart';

class AppImage extends StatelessWidget {
  double? height;
  double? width;
  BoxFit? boxFit;
  String imageUrl;

  AppImage(
      {super.key,
      required this.imageUrl,
      this.width,
      this.boxFit,
      this.height});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "${Constants.imageUrl}/$imageUrl",
      height: height,
      width: width,
      fit: boxFit,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s20),
              image: DecorationImage(image: imageProvider, fit: boxFit)),
        );
      },
      errorWidget: (context, url, error) {
        if(imageUrl.startsWith("/data/user")){
          return Image.file(File(imageUrl),fit: BoxFit.cover,);
        }else {
          return
            Image.asset(ImageAssets.welcome, fit: boxFit);
        }
      },
      placeholder: (context, url) => Lottie.asset(JsonAssets.loadingImage),
    );
  }
}
