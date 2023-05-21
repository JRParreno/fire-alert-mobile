import 'package:fire_alert_mobile/src/core/bloc/common/common_event.dart';
import 'package:fire_alert_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:fire_alert_mobile/src/core/local_storage/local_storage.dart';
import 'package:fire_alert_mobile/src/core/provider/custom_notification.dart';
import 'package:fire_alert_mobile/src/core/routes/app_route.dart';
import 'package:fire_alert_mobile/src/features/account/profile/data/models/profile.dart';
import 'package:fire_alert_mobile/src/features/account/profile/data/repositories/profile_repository_impl.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/presentation/bloc/media_bloc.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/screen/home_screen.dart';
import 'package:fire_alert_mobile/src/features/onboarding/onboarding_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> firebaseNotificationHandler(RemoteMessage message) async {
  CustomNotification.show(message);
}

class FireAlertApp extends StatefulWidget {
  const FireAlertApp({super.key});

  @override
  State<FireAlertApp> createState() => _FireAlertAppState();
}

class _FireAlertAppState extends State<FireAlertApp> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> initFirebaseMessaging() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message == null) return;
      // CustomNotification.onSelectNotification(jsonEncode(message.data), ref);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // CustomNotification.onSelectNotification(jsonEncode(message.data), ref);
    });

    FirebaseMessaging.onMessage.listen(firebaseNotificationHandler);
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      return;
    });
  }

  Future<void> registerFcmToken() async {
    final token = await FirebaseMessaging.instance.getToken();
  }

  void initialization(BuildContext ctx) async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    final user = await LocalStorage.readLocalStorage('_user');
    if (user != null) {
      final userProfile = await ProfileRepositoryImpl().fetchProfile();
      setProfileBloc(profile: userProfile, ctx: ctx);
    } else {
      await LocalStorage.deleteLocalStorage('_user');
      await LocalStorage.deleteLocalStorage('_refreshToken');
      await LocalStorage.deleteLocalStorage('_token');
      setProfileBloc(profile: null, ctx: ctx);
    }
    Future.delayed(const Duration(seconds: 2), () {
      FlutterNativeSplash.remove();
    });
  }

  void setProfileBloc({
    Profile? profile,
    required BuildContext ctx,
  }) {
    if (profile != null) {
      BlocProvider.of<ProfileBloc>(ctx).add(
        SetProfileEvent(profile: profile),
      );
    } else {
      BlocProvider.of<ProfileBloc>(ctx).add(
        const InitialEvent(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => ProfileBloc()),
        BlocProvider(create: (ctx) => MediaBloc()),
      ],
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (ctx, state) {
          initialization(ctx);

          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            builder: ((context, child) {
              return MaterialApp(
                builder: EasyLoading.init(),
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                onGenerateRoute: generateRoute,
                home: state is ProfileLoaded
                    ? const HomeScreen()
                    : const OnBoardingScreen(),
              );
            }),
          );
        },
      ),
    );
  }
}
