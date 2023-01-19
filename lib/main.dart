import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/routes.dart';
import 'package:weather_app/features/current_weather/presentation/bloc/current_weather_bloc.dart';
import 'package:weather_app/features/five_days_weather/presentation/bloc/five_days_weather_bloc.dart';
import 'package:weather_app/features/main_ui/presentation/bloc/main_ui_bloc.dart';
import 'package:weather_app/features/settings/presentation/cubit/settings_order_cubit.dart';
import 'features/feth_location/presentation/bloc/geocoding_bloc/geocoding_bloc.dart';
import 'features/settings/presentation/cubit/settings_unit_cubit.dart';
import 'injection/locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GeoCodingBloc()),
        BlocProvider(create: (_) => UnitCubit()..getValue()),
        BlocProvider(create: (_) => OrderCubit()..getValueOrder()),
        BlocProvider(create: (_) => MainUiBloc()),
      ],
      child: MaterialApp.router(
        routerConfig: route,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
