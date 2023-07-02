import 'package:emotion/getObjects.dart';
import 'package:emotion/record.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'screen/nav.dart';


void main() async {
  ObjectCreater.setRecord(Record());

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        appBarTheme: const AppBarTheme(
          // Add this line to set the app bar color
          color: Colors.purple,
        ),
        useMaterial3: true,
      ),
      home: const Navigationdrawer(),
    );
  }
}
