import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker_codetest/Screens/price_tracker.dart';
import 'package:price_tracker_codetest/constants/app_strings.dart';
import 'package:price_tracker_codetest/cubit/binary_cubit.dart';

void main() {
  runApp(const MyApp());
}
// void initLogger() {
//   Logger.init(
//     true, // isEnable ，if production ，please false
//     isShowFile: true,
//     // In the IDE, whether the file name is displayed
//     isShowTime: true,
//     // In the IDE, whether the time is displayed
//     isShowNavigation: true,
//     // In the IDE, When clicked, it jumps to the printed file details page
//     levelVerbose: 247,
//     // In the IDE, Set the color
//     levelDebug: 26,
//     levelInfo: 28,
//     levelWarn: 3,
//     levelError: 9,
//     phoneVerbose: Colors.white54,
//     // In your phone or web，, Set the color
//     phoneDebug: Colors.blue,
//     phoneInfo: Colors.green,
//     phoneWarn: Colors.yellow,
//     phoneError: Colors.redAccent,
//   );
// }
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => BinaryCubit(),
        child: const PriceTracker(),
      ),
    );
  }
}