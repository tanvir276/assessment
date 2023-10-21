

import 'package:assessment/features/sign_up/data/model/sign_up_request.dart';
import 'package:assessment/features/sign_up/data/model/sign_up_response.dart';
import 'package:assessment/features/sign_up/domain/repository/sign_up_repository.dart';

class SignUpUsecase {
  final SignUpRepository _signUpRepository;

  SignUpUsecase(this._signUpRepository);

  Future<SignUpResponse> call(SignUpRequest signUpRequest) =>
      _signUpRepository.signUp(signUpRequest);
}
