import 'package:cash_collector/pages/client_list.dart';
import 'package:cash_collector/pages/connexion.dart';
import 'package:cash_collector/pages/home.dart';
import 'package:cash_collector/provider/app_bar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:here_sdk/core.dart';

void main() {
  // make the top app transparent
  SdkContext.init(IsolateOrigin.main);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        //color set to transperent or set your own color
        statusBarIconBrightness: Brightness.dark,
        //set brightness for icons, like dark background light icons
      )
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppBarModel(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cash Collector',
      home: Connexion(),
    );
  }
}
