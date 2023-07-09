
import 'package:flutter/material.dart';

import '../../../../resources/color_manger.dart';
import '../../../../resources/values_manger.dart';

class SectionWidget extends StatelessWidget {
  String sectionName;
  IconData sectionIcon;
  SectionWidget(this.sectionName,this.sectionIcon, {super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: height * 0.03),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                  width: AppSize.s35,
                  height: AppSize.s35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s14),
                    color: ColorManger.purple,
                  ),
                  child:  Center(child: Icon(sectionIcon,color: ColorManger.primary,size: AppSize.s20,))),
              const SizedBox(
                width: AppSize.s18,
              ),
              Text(sectionName,style: Theme.of(context).textTheme.titleLarge,),
              const Spacer(),
              Icon(Icons.arrow_forward_ios_outlined,color: ColorManger.purple)
            ],
          ),
          Divider(
            color: ColorManger.primary,
            thickness: AppSize.s2,
          )
        ],
      ),
    );
  }
}
