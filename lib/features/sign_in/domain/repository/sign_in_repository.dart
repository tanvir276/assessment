import 'package:assessment/features/sign_in/data/model/sign_in_request.dart';
import 'package:assessment/features/sign_in/data/model/sign_in_response.dart';

abstract class SignInRepository {
  Future<SignInResponse> signin(SignInRequest signInRequest);
}
