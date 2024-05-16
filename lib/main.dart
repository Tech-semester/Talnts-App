import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talnts_app/common/helpers/bindings.dart';
import 'package:talnts_app/features/splash_screen/splash_screen.dart';

Future<void> main() async {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  await GetStorage.init();
  //await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final introdata = GetStorage();

  @override
  void initState() {
    super.initState();
    introdata.writeIfNull("display", false);
    introdata.write("access", '');
    introdata.write("user_id", '');
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        initialBinding: AuthBinding(),
        title: 'TalntsApp',
        themeMode: ThemeMode.light,
        home: const SplashScreen());
  }
}
