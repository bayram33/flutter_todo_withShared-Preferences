import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo2/models/items_data.dart';
import 'homepage.dart';
import './models/color_theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ColorThemeData().createPrefObject();
  await ItemData().createPrefObject();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ItemData>(
        create: (BuildContext context) => ItemData()),
    ChangeNotifierProvider<ColorThemeData>(
        create: (BuildContext context) => ColorThemeData())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Provider.of<ColorThemeData>(context).loadThemeFromSharedPref();
    Provider.of<ItemData>(context).loadItemsFromSharedPref();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ColorThemeData>(context).selectedTheme,
      home: HomePage(),
    );
  }
}
