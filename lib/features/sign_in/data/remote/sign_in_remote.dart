import 'dart:convert';
import 'dart:developer';
import 'package:assessment/core/constant/api_constants.dart';
import 'package:assessment/core/exceptions/exceptions.dart';
import 'package:assessment/core/header_provider/header_provider.dart';
import 'package:assessment/features/sign_in/data/model/sign_in_request.dart';
import 'package:assessment/features/sign_in/data/model/sign_in_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class SignInRemote {
  Future<SignInResponse> signIn(SignInRequest signInRequest);
}

class SignInRemoteImpl implements SignInRemote {
  static const signInEndpoint =
      ApiConstants.baseCommonApiUrl + ApiConstants.signInUrl;
  final HeaderProvider _apiHeaderProvider;
  SignInRemoteImpl(this._apiHeaderProvider);

  @override
  Future<SignInResponse> signIn(SignInRequest signInRequest) async {
    SignInResponse res;
    final headers = _apiHeaderProvider();
    final response = await http.post(Uri.parse(signInEndpoint),
        body: json.encode(signInRequest), headers: headers);

    log("rEQ out of 200: ${json.encode(signInRequest)}");

    log("Response out of 200: ${json.decode(json.encode(response.body))}");

    if (response.statusCode == 200) {
      debugPrint("in 200");
      // final Map<String, dynamic> map = jsonDecode(response.body);
      // final code = map['header']['responseCode'];
      // log("code:$code");
      // if (code == "200") {
      //   res = signInResponseFromJson(response.body);
      //   print("in 200 -->200");
      //   return res;
      // } else {
      //   throw ServerException(
      //     message: map['message'],
      //     statusCode: code,
      //   );
      // }
      res = signInResponseFromJson(response.body);
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
