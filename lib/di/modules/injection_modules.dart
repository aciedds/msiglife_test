import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:msiglife_test/utils/dio_utils.dart';

@module
abstract class InjectionModules {
  @lazySingleton
  @preResolve
  Future<Dio> get client async => DioUtils.client();
}
