import 'package:assessment/common/cubit/locale/locale_cubit.dart';
import 'package:assessment/common/data/data_source/local/locale_source.dart';
import 'package:assessment/common/data/data_source/local/token_source.dart';
import 'package:assessment/common/data/repository_impl/locale_repo_impl.dart';
import 'package:assessment/common/domain/repository/locale_repository.dart';
import 'package:assessment/common/domain/usecase/locale_usecase.dart';
import 'package:assessment/core/header_provider/header_provider.dart';
import 'package:assessment/core/network/connection_checker.dart';
import 'package:assessment/features/sign_in/data/remote/sign_in_remote.dart';
import 'package:assessment/features/sign_in/data/repository_impl/sign_in_repository_impl.dart';
import 'package:assessment/features/sign_in/domain/repository/sign_in_repository.dart';
import 'package:assessment/features/sign_in/domain/usecase/sign_in_usecase.dart';
import 'package:assessment/features/sign_in/presentation/cubit/sign_in_cubit/cubit/sign_in_cubit.dart';
import 'package:assessment/features/sign_up/data/remote/sign_up_remote.dart';
import 'package:assessment/features/sign_up/data/repository_impl/sign_up_repository_impl.dart';
import 'package:assessment/features/sign_up/domain/repository/sign_up_repository.dart';
import 'package:assessment/features/sign_up/domain/usecase/sign_up_usecase.dart';
import 'package:assessment/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dependency {
  static final sl = GetIt.instance;
  Dependency._init();

  static Future<void> init() async {
    sl.registerLazySingleton<LocaleSource>(() => LocaleSourceImpl(sl()));

    sl.registerLazySingleton<LocaleRepository>(
        () => LocaleRepositoryImpl(sl()));
    sl.registerLazySingleton(() => ReadLocaleUsecase(sl()));
    sl.registerLazySingleton(() => SaveLocaleUsecase(sl()));
    sl.registerLazySingleton(() => LocaleCubit(
          readLocaleUsecase: sl(),
          saveLocaleUsecase: sl(),
        ));
    final sharedPref = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPref);
    sl.registerLazySingleton(() => Client());

    sl.registerLazySingleton<ConnectionChecker>(
      () => ConnectionCheckerImpl(),
    );
    sl.registerLazySingleton<HeaderProvider>(() => HeaderProviderImpl());
    sl.registerLazySingleton<TokenSource>(() => TokenSourceImpl(sl()));

//---------------------------Sign In Start-------------------------------//

    sl.registerLazySingleton<SignInRemote>(
      () => SignInRemoteImpl(sl()),
    );

    sl.registerLazySingleton<SignInRepository>(
      () => SignInRepositoryImpl(
        sl(),
        sl(),
        sl(),
      ),
    );
    sl.registerLazySingleton(() => SignInUsecase(sl()));
    sl.registerFactory(() => SignInApiCubit(signInUsecase: sl()));

//---------------------------Sign In End-------------------------------//

// ---------------------------Sign Up Start-------------------------------//

    sl.registerLazySingleton<SignUpRemote>(
      () => SignUpRemoteImpl(sl()),
    );

    sl.registerLazySingleton<SignUpRepository>(
      () => SignUpRepositoryImpl(
        sl(),
        sl(),
        sl(),
      ),
    );
    sl.registerLazySingleton(() => SignUpUsecase(sl()));
    sl.registerFactory(() => SignUpCubit(signUpUsecase: sl()));

// ---------------------------Sign Up End-------------------------------//
  }

  static final providers = <BlocProvider>[
    BlocProvider<LocaleCubit>(
      create: (context) => Dependency.sl<LocaleCubit>(),
    ),
    BlocProvider<SignInApiCubit>(
      create: (context) => Dependency.sl<SignInApiCubit>(),
    ),
    BlocProvider<SignUpCubit>(
      create: (context) => Dependency.sl<SignUpCubit>(),
    ),
  ];
}
