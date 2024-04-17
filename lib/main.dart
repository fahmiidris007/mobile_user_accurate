import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_user_accurate/injection.dart' as di;
import 'package:mobile_user_accurate/presentation/bloc/get_user/get_user_bloc.dart';
import 'package:mobile_user_accurate/presentation/pages/home_page.dart';

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
      ],
      child: MaterialApp(
        title: 'Mobile User Accurate App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Center(
          child: HomePage(),
        ),
      ),
    );
  }
}
