import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basic/providers/statenotifier_provider.dart';
import 'package:riverpod_basic/screens/home_screen.dart';
import 'package:riverpod_basic/screens/second_screen.dart';

import 'models/user_model.dart';

final nameProvider = StateNotifierProvider<UserNotifier,User>((ref) => UserNotifier());

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context)=>HomePage(),
        '/second': (context)=> Second(),

      },
    );
  }
}

