
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../resources/color_manger.dart';
import '../view_model/session_controller.dart';

class ResourcesItem extends GetView<SessionController> {
  int index;

  ResourcesItem(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: Get.width * 0.8,
            child: TextButton(
              onPressed: () async{
                // controller.downloadFile(
               //     controller.sessionByIdModel!.resources[index].url);
                await controller.checkFile(controller.sessionByIdModel!.resources[index].url);
              },
              style: const ButtonStyle(
                alignment: Alignment.centerLeft
              ),
              child: Text(
                controller.sessionByIdModel!.resources[index].name,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: ColorManger.onBoardingColor3),
                textAlign: TextAlign.start,
                textScaleFactor: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
