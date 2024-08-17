import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:msiglife_test/di/injection.config.dart';

final inject = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => inject.init();
