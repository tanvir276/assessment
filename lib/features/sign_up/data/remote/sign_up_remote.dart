import 'dart:convert';
import 'dart:developer';
import 'package:assessment/core/constant/api_constants.dart';
import 'package:assessment/core/exceptions/exceptions.dart';
import 'package:assessment/core/header_provider/header_provider.dart';
import 'package:assessment/features/sign_up/data/model/sign_up_request.dart';
import 'package:assessment/features/sign_up/data/model/sign_up_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class SignUpRemote {
  Future<SignUpResponse> signUp(SignUpRequest signUpRequest);
}

class SignUpRemoteImpl implements SignUpRemote {
  static const signUpEndpoint =
      ApiConstants.baseCommonApiUrl + ApiConstants.signUpUrl;
  final HeaderProvider _apiHeaderProvider;
  SignUpRemoteImpl(this._apiHeaderProvider);

  @override
  Future<SignUpResponse> signUp(SignUpRequest signUpRequest) async {
    SignUpResponse res;
    final headers = _apiHeaderProvider();
    final response = await http.post(Uri.parse(signUpEndpoint),
        body: json.encode(signUpRequest), headers: headers);

    log("rEQ out of 200: ${json.encode(signUpRequest)}");

    log("Response out of 200: ${json.decode(json.encode(response.body))}");

    if (response.statusCode == 200) {
      debugPrint("in 200");
      // final Map<String, dynamic> map = jsonDecode(response.body);
      // final code = map['header']['responseCode'];
      // log("code:$code");
      // if (code == "200") {
      //   res = signUpResponseFromJson(response.body);
      //   print("in 200 -->200");
      //   return res;
      // } else {
      //   throw ServerException(
      //     message: map['message'],
      //     statusCode: code,
      //   );
      // }
      res = signUpResponseFromJson(response.body);
      return res;
    } else {
      final errorBody = jsonDecode(response.body);
      final errorMessage = errorBody['error']['message'];

      throw ServerException(
        message: errorMessage,
        statusCode: response.statusCode,
      );
    }
  }
}
