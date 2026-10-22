import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynet_app/history/history_storage.dart';
import 'package:paynet_app/widgets/navigation_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadHistory();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 923),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'App',
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: const NavigationPage(),
    );
    }
}
