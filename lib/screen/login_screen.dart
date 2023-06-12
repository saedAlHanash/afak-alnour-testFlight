import 'package:afaq_alnour_academy/adaptive_widget/adabtive_filed.dart';
import 'package:afaq_alnour_academy/adaptive_widget/adabtive_indecator.dart';
import 'package:afaq_alnour_academy/bloc/child_bloc/child_cubit.dart';
import 'package:afaq_alnour_academy/bloc/home_bloc/home_cubit.dart';
import 'package:afaq_alnour_academy/bloc/login_bloc/login_cubit.dart';
import 'package:afaq_alnour_academy/bloc/login_bloc/login_state.dart';
import 'package:afaq_alnour_academy/constant/const.dart';
import 'package:afaq_alnour_academy/data/local/cache_helper.dart';
import 'package:afaq_alnour_academy/generated/l10n.dart';
import 'package:afaq_alnour_academy/screen/child_view/child_screen.dart';
import 'package:afaq_alnour_academy/screen/child_view/main_screen.dart';
import 'package:afaq_alnour_academy/screen/parent_view/afaq_layout.dart';
import 'package:afaq_alnour_academy/widget/toast.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<LoginCubit,LoginState>(
      listener: (context, state) {
        var get = LoginCubit.get(context);
        if(state is LoginSuccessState){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AfaqLayout(),),(route) => false,);
          CacheHelper.setData(key: 'token_student', value: get.model!.token);
          HomeCubit.get(context).getCourses();
          // HomeCubit.get(context).getPackages();
          HomeCubit.get(context).getMyChildren();
          HomeCubit.get(context).sendFireBaseToken();
        }
        if(state is LoginChildSuccessState){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainScreen(),),(route) => false,);
          CacheHelper.setData(key: 'token_child', value: get.childModel!.token);
          ChildCubit.get(context).getMyCourses();
          ChildCubit.get(context).sendFireBaseToken();
        }
      },
      builder: (context, state) {
        var get = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Center(
                child: AutofillGroup(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.2,
                      ),
                      AutoSizeText(S.of(context).name_company,style: Theme.of(context).textTheme.bodyText2,
                        textScaleFactor: 1,
                        minFontSize: 26,
                        maxFontSize: 28,
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      Container(
                        height: height * 0.09,
                        width: width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.3)),
                        child: AdabtiveTextFormFiled(
                          context,
                          action: TextInputAction.next,
                          hint: [
                            get.user == 'parent'? AutofillHints.email : AutofillHints.username
                          ],
                          os: getOS(),
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return S.of(context).val;
                            }
                            return null;
                          },
                          ispassword: false,
                          type: TextInputType.emailAddress,
                          label: get.user == 'child' ? S.of(context).user_name : S.of(context).email,
                          prefixicon: Icons.person,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        height: height * 0.09,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.3)),
                        width: width * 0.9,
                        child: AdabtiveTextFormFiled(
                          context,
                          hint: [
                            AutofillHints.password
                          ],
                          action: TextInputAction.done,
                          os: getOS(),
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return S.of(context).val;
                            }
                            return null;
                          },
                          ispassword: get.password,
                          type: TextInputType.visiblePassword,
                          label: S.of(context).password,
                          prefixicon: Icons.lock_outline_rounded,
                          suffixIcon: get.password ? Icons.visibility : Icons.visibility_off,
                          onSuffixPressid: (){
                            get.onPassword();
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      ConditionalBuilder(
                        condition:state is !LoginLoadingState,
                        builder: (context)=> Container(
                          width: width * 0.9,
                          height: height * 0.07,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: HexColor('#c0e1f4')),
                          child: TextButton(
                            onPressed: () {
                              if(_formKey.currentState!.validate()){
                                if(get.user == 'parent'){
                                  get.loginUser(context, email: emailController.text, password: passwordController.text);
                                }else{
                                  get.loginChild(userName: emailController.text, password: passwordController.text);
                                }
                              }else{
                                toast(msg: 'Login Error', color: Colors.red);
                              }
                            },
                            child: AutoSizeText(
                              S.of(context).login,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5,
                              textScaleFactor: 1,
                              minFontSize: 20,
                              maxFontSize: 22,
                            ),
                          ),
                        ),
                        fallback: (context)=> AdabtiveIndecator(os: getOS()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
