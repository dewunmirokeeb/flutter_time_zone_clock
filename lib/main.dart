import 'package:flutter/material.dart';
import 'package:flutter_time_zone_clock/main_app_page.dart';
import 'package:flutter_time_zone_clock/time_manager.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;

void main() {
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => TimeManager()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: const MainAppPage(),
      ),
    );
  }
}
