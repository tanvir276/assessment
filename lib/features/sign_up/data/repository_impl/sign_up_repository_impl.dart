

import 'package:assessment/common/data/data_source/local/token_source.dart';
import 'package:assessment/core/exceptions/exceptions.dart';
import 'package:assessment/core/network/connection_checker.dart';
import 'package:assessment/features/sign_up/data/model/sign_up_request.dart';
import 'package:assessment/features/sign_up/data/model/sign_up_response.dart';
import 'package:assessment/features/sign_up/data/remote/sign_up_remote.dart';
import 'package:assessment/features/sign_up/domain/repository/sign_up_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final ConnectionChecker _connectionChecker;
  final SignUpRemote signUpRemote;
  final TokenSource tokenSource;

  SignUpRepositoryImpl(
      this._connectionChecker, this.signUpRemote, this.tokenSource);

  @override
  Future<SignUpResponse> signUp(SignUpRequest signUpRequest) async {
    if (!await _connectionChecker.isConnected()) throw NoInternetException();
    SignUpResponse signUpResponse = await signUpRemote.signUp(signUpRequest);
    await tokenSource.saveToken(signUpResponse.data!.accessToken!);
  
    return signUpResponse;
  }
}
