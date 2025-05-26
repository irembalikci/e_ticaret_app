import 'package:e_ticaret_app/ui/components/my_bottom_bar.dart';
import 'package:e_ticaret_app/ui/cubits/details_cubit.dart';
import 'package:e_ticaret_app/ui/cubits/fav_cubit.dart';
import 'package:e_ticaret_app/ui/cubits/main_cubit.dart';
import 'package:e_ticaret_app/ui/cubits/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) => OrderCubit()),
        BlocProvider(create: (context) => DetailsCubit()),
        BlocProvider(create: (context) => FavCubit())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        //home: const MainScreen(),
         home: const MyBottomBar(),
      ),
    );
  }
}

