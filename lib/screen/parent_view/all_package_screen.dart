
import 'package:afaq_alnour_academy/bloc/home_bloc/home_cubit.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_state.dart';
import 'package:afaq_alnour_academy/constant/const.dart';
import 'package:afaq_alnour_academy/generated/l10n.dart';
import 'package:afaq_alnour_academy/model/course_model.dart';
import 'package:afaq_alnour_academy/screen/parent_view/pacage_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class AllPackageScreen extends StatelessWidget {
  const AllPackageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if(state is GetPackageByIdSuccessState){

        }
      },
      builder: (context, state) {
        var get = HomeCubit.get(context);
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: AutoSizeText(
              S.of(context).all_packages,
              style: Theme.of(context)
                  .textTheme
                  .headline3,
              textScaleFactor: 1,
              minFontSize: 24,
              maxFontSize: 26,
            ),
          ),
          body: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('image/background_image/background2.jpg'),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => Course(context,
                            width: width,
                            height: height,
                            model: get.packages,
                            get: get,
                            index: index),
                        separatorBuilder: (context, index) => SizedBox(
                          height: height * 0.02,
                        ),
                        itemCount: get.packages!.data!.length),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget Course(context,
      {double? width,
        double? height,
        CourseModel? model,
        int? index,
        var get}) =>
      BlocConsumer<HomeCubit,HomeState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width! * 0.3,
                  height: height! * 0.18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.teal,
                    image: DecorationImage(
                        image: NetworkImage(
                            '${ImageUrl}${model!.data![index!].image_url}'),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  width: width * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.025),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AutoSizeText(
                            '${model.data![index].name}',
                            style: Theme.of(context)
                                .textTheme
                                .headline3,
                            textScaleFactor: 1,
                            minFontSize: 19,
                            maxFontSize: 21,
                          )
                        ],
                      ),
                      Container(
                        width: width * 0.55,
                        child: AutoSizeText('${model.data![index].description}',
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline3!.copyWith(
                                fontWeight: FontWeight.normal),
                          textScaleFactor: 1,
                          minFontSize: 16,
                          maxFontSize: 18,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            onTap: () {
              get.packageModel = null;
              Navigator.push(context, MaterialPageRoute(builder: (context) => PackageScreen(),));
              get.getPackageById( id: model.data![index].id);
            },
          );
        },
      );
}
