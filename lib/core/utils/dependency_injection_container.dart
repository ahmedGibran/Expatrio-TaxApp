import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

final getIt = GetIt.instance;
void initDIC() {
  //state
  getIt.registerFactory(() => AuthState(authUseCases: getIt()));
  getIt.registerFactory(() => TaxState(taxUseCases: getIt()));

  //use cases
  getIt.registerLazySingleton(() => AuthUseCases(authRepository: getIt()));
  getIt.registerLazySingleton(() => TaxUseCases(taxRepository: getIt()));
  getIt.registerSingleton<AuthModel>(AuthModel());

  //repositories
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(networkInfo: getIt(), authRemoteData: getIt(), authLocalData: getIt()));
  getIt.registerLazySingleton<TaxRepository>(
      () => TaxRepositoryImpl(networkInfo: getIt(), taxRemoteData: getIt(), taxLocalData: getIt()));

  //data resource
  getIt.registerLazySingleton<AuthRemoteData>(() => AuthRemoteDataImpl(httpClient: getIt()));
  getIt.registerLazySingleton<AuthLocalData>(() => AuthLocalDataImpl(storage: getIt()));
  getIt.registerLazySingleton<TaxRemoteData>(() => TaxRemoteDataImpl(httpClient: getIt()));
  getIt.registerLazySingleton<TaxLocalData>(() => TaxLocalDataImpl(storage: getIt()));

  //core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnectionChecker: getIt()));

  //External
  getIt.registerLazySingleton(() => const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      ));
  getIt.registerLazySingleton(() => http.Client());
  getIt.registerFactory(() => InternetConnectionChecker());
}
