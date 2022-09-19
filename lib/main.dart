import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_demo/position_list.dart';
import 'package:hive_flutter/adapters.dart';
import 'boxes.dart';
import 'home_screen.dart';
import 'model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(LocationDataAdapter());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void hiveBoxOpening() async {
    await Hive.openBox<LocationData>("location");
  }

  @override
  void initState() {
    super.initState();
    hiveBoxOpening();
  }

  @override
  void dispose() {
    final box = Boxes.getBox();
    box.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          '/': (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
          '/list': (context) => const LocationList(),
        },
        theme: ThemeData(primarySwatch: Colors.blue));
  }
}
