import 'dart:ffi';

import 'package:encryption_drift/domain/di/di.dart';
import 'package:encryption_drift/presentation/screen/person_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:sqlite3/open.dart';

void setupSqlCipher() {
  open.overrideFor(
      OperatingSystem.android, () => DynamicLibrary.open('libsqlcipher.so'));
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupSqlCipher();
  await configureDependencies(Environment.dev);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drift encryption',
      initialRoute: PersonListScreen.routeName,
      routes: {        
        PersonListScreen.routeName:(BuildContext context) => const PersonListScreen(),
      },
    );
  }
}
