import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/store/main_store.dart';
import 'package:snp/ui/store/user.dart';
import 'package:snp/ui/splash_page.dart';
import 'package:uuid/uuid.dart';

GlobalKey<NavigatorState> rootKey;

void main() async {
  runZoned(
    () async {
      if (rootKey == null) rootKey = GlobalKey<NavigatorState>();
      _initAsync();
      final botToastBuilder = BotToastInit();
      final builder = (context, child) => Scaffold(
            body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus &&
                    currentFocus.focusedChild != null) {
                  FocusManager.instance.primaryFocus.unfocus();
                }
              },
              child: child,
            ),
          );
      runApp(
        MultiProvider(
          providers: [
            Provider<UserStore>(
              create: (_) => UserStore(),
            ),
            Provider<MainStore>(
              create: (_) => MainStore()
                ..setAllianceId(SpUtil.getInt(
                  Config.sp_key_alliance_id,
                  defValue: -1,
                )),
            ),
          ],
          child: MaterialApp(
            navigatorKey: rootKey,
            //UI Debug模式
            showSemanticsDebugger: false,
            //性能监视器
            showPerformanceOverlay: false,
            //网格
            debugShowMaterialGrid: false,
            //角标
            debugShowCheckedModeBanner: false,
//          builder: BotToastInit(),
            builder: (context, child) {
              child = builder(context, child);
              child = botToastBuilder(context, child);
              return child;
            },
            navigatorObservers: [BotToastNavigatorObserver()],
            title: 'SNP',
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: CColor.mainColor,
              accentColor: CColor.mainColor,
              backgroundColor: CColor.bgColor,
              scaffoldBackgroundColor: CColor.bgColor,
              pageTransitionsTheme: PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                },
              ),
              textTheme: TextTheme(
                bodyText2: Font.normal,
              ),
              appBarTheme: AppBarTheme(
                  elevation: 0.0,
                  color: CColor.appBarColor,
                  brightness: Brightness.light,
                  centerTitle: true,
                  textTheme: TextTheme(
                    headline6: Font.title,
                  ),
                  iconTheme: IconThemeData(
                    color: CColor.iconColor,
                    size: sFontSize(24),
                  )),
              dividerTheme: DividerThemeData(
                color: CColor.lineColor,
                space: 0.6,
                thickness: 0.6,
              ),
            ),
            home: SplashPage(2),
//          home: new SplashScreen(
//            seconds: 2,
//            navigateAfterSeconds: new MainPage(),
//            imageBackground: AssetImage('assets/images/bg_loading.jpg'),
//            backgroundColor: Colors.white,
//          ),
          ),
        ),
      );
    },
    // catch all application exception
    onError: (error, stack) {
      print(error.toString());
      if (isSessionError(error)) {
//        EventBusUtil.instance.eventBus.fire(SingleLoginEvent());
      } else if (error is DioError || error is NetException) {
        if (error is DioError &&
            (error.type == DioErrorType.RECEIVE_TIMEOUT ||
                error.type == DioErrorType.CONNECT_TIMEOUT ||
                error.type == DioErrorType.SEND_TIMEOUT)) throw error;
        toast('网络请求超时');
        // throw error;
      } else {
        // toast(error.toString());
        // throw error;
      }
    },
  );
}

//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or simply save your changes to "hot reload" in a Flutter IDE).
//        // Notice that the counter didn't reset back to zero; the application
//        // is not restarted.
//        primarySwatch: Colors.blue,
//        // This makes the visual density adapt to the platform that you run
//        // the app on. For desktop platforms, the controls will be smaller and
//        // closer together (more dense) than on mobile platforms.
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
//    );
//  }
//}

void _initAsync() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();

  if (SpUtil.getString(Config.sp_key_client_id).isEmpty) {
    String plant = Uuid().v4() + DateTime.now().millisecond.toString();
    String clientId = await Future.sync(() => EncryptUtil.encodeMd5(plant));
    SpUtil.putString(Config.sp_key_client_id, clientId);
  }
  // await AliOSSFlutter().init(
  //   Config.oss_sts_server,
  //   Config.oss_endpoint,
  //   cryptkey: Config.oss_crypt_key,
  // );
}
