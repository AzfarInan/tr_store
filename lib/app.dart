import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/src/core/route/route_generator.dart';

GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(393, 852),
      builder: (context, _) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          title: 'TR Store',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.generateRoute,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                child!,
                // ValueListenableBuilder(
                //   valueListenable: showLoading,
                //   builder: (context, value, child) {
                //     return showLoading.value
                //         ? SpinKitFadingCircle(
                //             color: context.theme.color.burntSienna,
                //             size: 60.sp,
                //           )
                //         : Container();
                //   },
                // ),
              ],
            );
          },
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
        );
      },
    );
  }
}
