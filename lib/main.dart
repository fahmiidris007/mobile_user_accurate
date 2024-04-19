import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_user_accurate/common/router.dart';
import 'package:mobile_user_accurate/injection.dart' as di;
import 'package:mobile_user_accurate/presentation/bloc/add_user/add_user_bloc.dart';
import 'package:mobile_user_accurate/presentation/bloc/get_city/get_city_bloc.dart';
import 'package:mobile_user_accurate/presentation/bloc/get_user/get_user_bloc.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<GetUserBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<AddUserBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<GetCityBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Mobile User Accurate App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }
}
