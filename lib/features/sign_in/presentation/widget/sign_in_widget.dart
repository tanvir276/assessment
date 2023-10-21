import 'dart:convert';
import 'dart:developer';

import 'package:assessment/common/widgets/app_dialog.dart';
import 'package:assessment/common/widgets/app_loading.dart';
import 'package:assessment/core/exceptions/exceptions.dart';
import 'package:assessment/core/navigation/route_name.dart';
import 'package:assessment/core/resources/error_msg_res.dart';
import 'package:assessment/core/utils/lang/app_localizations.dart';
import 'package:assessment/features/sign_in/data/model/sign_in_request.dart';
import 'package:assessment/features/sign_in/presentation/cubit/sign_in_cubit/cubit/sign_in_cubit.dart';
import 'package:assessment/features/sign_in/presentation/widget/signin_userinfo_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({
    Key? key,
  }) : super(key: key);

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
   Locale _selectedLocale = const Locale('bn'); // Default locale is English

  bool isLangBangla = false;
  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context).locale.languageCode;
    isLangBangla = s.contains('bn');
    final user = SignInRequest(email: "", password: "");

    final formKey = GlobalKey<FormState>();
    return BlocListener<SignInApiCubit, SignInApiState>(
      listener: (context, state) {
        if (state is SignInLoading) {
          showAppLoading(context);
        } else if (state is SignInFailed) {
          // Navigator.pop(context);

          final ex = state.exception;
          if (ex is ServerException) {
            showAppDialog(context, title: ex.message ?? '');
          } else if (ex is NoInternetException) {
            showAppDialog(context, title: ErrorMsgRes.kNoInternet);
          }
        } else if (state is SignInSucceed) {
          final responseModel = state.model;
          debugPrint("In Success");
          log("in success Response: ${json.encode(responseModel)}");
          // accessToken = responseModel.data!.accessToken!;

          // Navigator.pushNamed(context, RouteName.);
          // MotionToast.success(
          //   // title: Text("Login Successful"),
          //   description: const Text("Login Successful"),
          //   position: MotionToastPosition.bottom,
          //   toastDuration: const Duration(seconds: 4),
          // ).show(context);

          // if (responseModel.code == 200) {
          //   // Navigator.pushNamed(context, RouteName.dashboardRoute);
          // }
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar:  AppBar(
          title: const Text("Money Management"),
          actions: <Widget>[
            PopupMenuButton<Locale>(
              onSelected: (Locale selectedLocale) {
                setState(() {
                  _selectedLocale = selectedLocale;
                });
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<Locale>(
                    value: Locale('en'),
                    child: Text("English"),
                  ),
                  const PopupMenuItem<Locale>(
                    value: Locale('bn'),
                    child: Text("বাংলা"),
                  ),
                  const PopupMenuItem<Locale>(
                    value: Locale('ar'),
                    child: Text("العربية"),
                  ),
                ];
              },
            ),
          ],
        ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    // const Padding(
                    //   padding: EdgeInsets.all(0.0),
                    //   child: Image(
                    //     height: 85,
                    //     image: AssetImage('assets/images/biglogo.png'),
                    //   ),
                    // ),
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 5),
                    //   child: Image(
                    //     height: 240,
                    //     image: AssetImage("assets/images/truck.png"),
                    //   ),
                    // ),
                    const Text(
                      "Money Management",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    SignInUserInfoFormWidget(
                      formKey: formKey,
                      user: user,
                    ),

                    const SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 38),
                          child: InkWell(
                            onTap: () {
                              // Navigator.pushNamed(context, RouteName.sendOtp);
                            },
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("forgot_password"),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      // buttonName: AppLocalizations.of(context)
                      //     .translate("common_sign_in"),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate("common_sign_in"),
                      ),
                      onPressed: () async {
                        log("pressed");
                        final isValid = formKey.currentState?.validate();

                        if (isValid != null && isValid) {
                          log("validate");
                          await BlocProvider.of<SignInApiCubit>(context)
                              .signIn(user);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 2,
                      indent: 35,
                      endIndent: 35,
                      color: Color(0xff341f97),
                      height: 15,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 38),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate("Dont_have_an_account"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 38),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteName.signUpRoute);
                            },
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate("common_sign_up"),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
