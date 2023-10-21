import 'package:assessment/common/widgets/common_textfield.dart';
import 'package:assessment/core/utils/lang/app_localizations.dart';
import 'package:assessment/features/sign_in/data/model/sign_in_request.dart';
import 'package:flutter/material.dart';

class SignInUserInfoFormWidget extends StatefulWidget {
  final SignInRequest user;

  final GlobalKey<FormState> formKey;

  const SignInUserInfoFormWidget({
    Key? key,
    required this.user,
    required this.formKey,
  }) : super(key: key);
  @override
  State<SignInUserInfoFormWidget> createState() =>
      _SignInUserInfoFormWidgetState();
}

class _SignInUserInfoFormWidgetState extends State<SignInUserInfoFormWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  late SignInRequest user;
  bool isLangBangla = false;
  @override
  void initState() {
    user = widget.user;
    emailController = TextEditingController();
    pwdController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context).locale.languageCode;
    isLangBangla = s.contains('bn');
    return Container(
        alignment: Alignment.center,
        child: Form(
            key: widget.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  _userIdTextField(),
                  const SizedBox(
                    height: 15,
                  ),
                  _passwordTextField(),
                  const SizedBox(
                    height: 15,
                  ),
                ])));
  }

  Widget _userIdTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      // child: CommonTextField(
      //   textEditingController: mobileController,
      //   hintText: "common_mobile_no",
      //   labelText: "common_mobile_no",
      //   needObscureText: false,
      //   validateMessage:
      //       AppLocalizations.of(context).translate("enter_mobile_number"),
      //   // "Enter Mobile Number",
      //   validatorValue: "mobile",
      //   onChange: (value) {
      //     user.userId = value;
      //   },
      // ),
      child: TextFormField(
        controller: emailController,
        decoration: const InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your email';
          }
          // Email regex pattern
          String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
          RegExp regex = RegExp(pattern);
          if (!regex.hasMatch(value)) {
            return 'Invalid email address';
          }
          return null;
        },
        onChanged: (value) {
          user.email = value;
        },
      ),
    );
  }

  Widget _passwordTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: CommonTextField(
        textEditingController: pwdController,
        hintText: "common_password",
        labelText: "common_password",
        needObscureText: true,
        obscureText: true,
        validateMessage:
            AppLocalizations.of(context).translate("enter_password"),
        // "Enter Password",
        validatorValue: "password",
        onChange: (value) {
          user.password = value;
        },
      ),
    );
  }
}
