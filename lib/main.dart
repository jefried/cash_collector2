import 'package:cash_collector/pages/client_list.dart';
import 'package:cash_collector/pages/connexion.dart';
import 'package:cash_collector/pages/home.dart';
import 'package:cash_collector/provider/app_bar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:here_sdk/core.dart';

//for pre-loading images
final List _allAsset = [
  'assets/connexion/ellipse.png',
  'assets/connexion/forêt.png',
  'assets/details_compte/photo_indisponible.jpg',
  'assets/details_compte/profil.jpg',
  'assets/encaissement/cash.png',
  'assets/encaissement/check.png',
  'assets/encaissement/mtn.png',
  'assets/encaissement/orange.png',
  'assets/encaissement/yup.png',
  'assets/images/map/poi.png',
  'assets/images/payment_ways/mtnmomo.png',
  'assets/images/payment_ways/orangemoney.png',
  'assets/images/payment_ways/yup.png',
  'assets/images/asset1.jpg',
  'assets/images/drawer_background.png',
];

void main() {
  //pre-load the assets images
  final binding = WidgetsFlutterBinding.ensureInitialized();

  binding.addPostFrameCallback((_) async {
    BuildContext context = binding.renderViewElement as BuildContext;
    if(context != null)
    {
      for(var asset in _allAsset)
      {
        precacheImage(AssetImage(asset), context);
      }
    }
  });
  // init the sdk here
  SdkContext.init(IsolateOrigin.main);
  // make the top app transparent
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
