import 'package:afaq_alnour_academy/bloc/home_bloc/home_cubit.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_state.dart';
import 'package:afaq_alnour_academy/constant/const.dart';
import 'package:afaq_alnour_academy/generated/l10n.dart';
import 'package:afaq_alnour_academy/model/course_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import 'categories_screen.dart';

class AllSeasonalScreen extends StatelessWidget {
  const AllSeasonalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var get = HomeCubit.get(context);
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: AutoSizeText(
              S.of(context).seasonal_course,
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
                    image: AssetImage('image/background_image/background3.jpg'),
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
                            model: get.seasonal,
                            get: get,
                            index: index),
                        separatorBuilder: (context, index) => SizedBox(
                              height: height * 0.02,
                            ),
                        itemCount: get.seasonal!.data!.length),
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
      InkWell(
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
          get.getCategories( id: model.data![index].id);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategoriesScreen(
                        index: index,
                    id: model.data![index].id,
                    name: model.data![index].name,
                        description: model.data![index].description,
                    image: model.data![index].image_url,
                      )));
        },
      );
}
