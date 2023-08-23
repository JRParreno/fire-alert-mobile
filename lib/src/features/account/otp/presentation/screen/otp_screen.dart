import 'dart:async';

import 'package:fire_alert_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:fire_alert_mobile/src/core/common_widget/common_widget.dart';
import 'package:fire_alert_mobile/src/core/common_widget/custom_appbar.dart';
import 'package:fire_alert_mobile/src/core/config/app_constant.dart';
import 'package:fire_alert_mobile/src/core/local_storage/local_storage.dart';
import 'package:fire_alert_mobile/src/core/utils/input_utils.dart';
import 'package:fire_alert_mobile/src/core/utils/size_config.dart';
import 'package:fire_alert_mobile/src/features/account/otp/presentation/widgets/otp_body.dart';
import 'package:fire_alert_mobile/src/features/account/profile/data/models/profile.dart';
import 'package:fire_alert_mobile/src/features/account/profile/data/repositories/profile_repository_impl.dart';
import 'package:fire_alert_mobile/src/features/account/signup/data/repositories/signup_repository_impl.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPArgs {
  final String userId;
  final String email;

  OTPArgs({
    required this.userId,
    required this.email,
  });
}

class OTPSCreen extends StatefulWidget {
  static const String routeName = '/otp';
  final OTPArgs args;

  const OTPSCreen({super.key, required this.args});

  @override
  State<OTPSCreen> createState() => _OTPSCreenState();
}

class _OTPSCreenState extends State<OTPSCreen> {
  double w = 0;
  double h = 0;
  late Timer _timer;
  final int timerDuration = 30;
  int _resendCtr = 1;
  ValueNotifier<String> duration = ValueNotifier("00:30");
  StreamController<ErrorAnimationType>? errorController;
  TextEditingController otp = TextEditingController();
  bool validForSubmit = false;
  late List<FocusNode> focus = [];

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();

    startTimer(isStartLoad: true);

    focus = [
      FocusNode(),
      FocusNode(),
      FocusNode(),
      FocusNode(),
    ];

    super.initState();
  }

  void startTimer({bool isStartLoad = false}) {
    if (!isStartLoad) {
      _timer.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick >= timerDuration) timer.cancel();
      // get minutes
      final iMinutes = (timerDuration - timer.tick) ~/ 60;
      // get seconds
      final iSeconds = (timerDuration - timer.tick) % 60;
      final sMinutes = iMinutes < 10
          ? iMinutes.toString().padLeft(2, "0")
          : iMinutes.toString();
      final sSeconds = iSeconds < 10
          ? iSeconds.toString().padLeft(2, "0")
          : iSeconds.toString();
      duration.value = '$sMinutes:$sSeconds';
    });
  }

  void verifyEmpty() {
    if (otp.text.length == 4) {
      validForSubmit = true;
    } else {
      validForSubmit = false;
    }
    setState(() {});
  }

  Future<void> handleVerifyOTP() async {
    LoaderDialog.show(context: context);

    await SignupImpl()
        .verifyOTP(userId: widget.args.userId, otp: otp.value.text)
        .then((value) {
      LocalStorage.storeLocalStorage('_token', value['accessToken']);
      LocalStorage.storeLocalStorage('_refreshToken', value['refreshToken']);

      handleGetProfile();
    }).catchError((onError) {
      Future.delayed(const Duration(milliseconds: 500), () {
        CommonDialog.showMyDialog(
          context: context,
          title: "FireGuard",
          body: onError['data']['error_message'],
          isError: true,
        );
      });
    });
    LoaderDialog.hide(context: context);
  }

  Future<void> handleResendOTP() async {
    LoaderDialog.show(context: context);

    await SignupImpl().generateOTP(widget.args.userId).then((value) {
      setState(() {
        _resendCtr += 1;
      });
      startTimer();
    }).catchError((onError) {
      LoaderDialog.hide(context: context);

      Future.delayed(const Duration(milliseconds: 500), () {
        CommonDialog.showMyDialog(
          context: context,
          title: "FireGuard",
          body: onError['data']['error_message'],
          isError: true,
        );
      });
    });
  }

  void handleGetProfile() async {
    ProfileRepositoryImpl().fetchProfile().then((profile) async {
      if (profile.otpVerified) {
        await LocalStorage.storeLocalStorage('_user', profile.toJson());

        handleSetProfileBloc(profile);
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            HomeScreen.routeName,
            (route) => false,
          );
        });
      }
    }).catchError((onError) {
      LoaderDialog.hide(context: context);

      Future.delayed(const Duration(milliseconds: 500), () {
        CommonDialog.showMyDialog(
          context: context,
          title: "FireGuard",
          body: onError['data']['error_message'],
          isError: true,
        );
      });
    });
  }

  void handleSetProfileBloc(Profile profile) {
    BlocProvider.of<ProfileBloc>(context).add(
      SetProfileEvent(profile: profile),
    );
  }

  void handleBackPress() {
    CommonDialog.showMyDialog(
      context: context,
      body: "Exit OTP Verification?",
      buttons: [
        TextButton(
          child: const Text("Yes"),
          onPressed: () async {
            Navigator.of(context).pop();

            Future.delayed(const Duration(milliseconds: 300), () {
              Navigator.of(context).pop();
            });
          },
        ),
        TextButton(
          child: const Text("No"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    w = AppConstant.kMockupWidth / SizeConfig.screenWidth;
    h = AppConstant.kMockupHeight / SizeConfig.screenHeight;

    return WillPopScope(
      onWillPop: () async {
        handleBackPress();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: buildAppBar(
          context: context,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 25,
            ),
            onPressed: handleBackPress,
          ),
        ),
        bottomNavigationBar: buildBottomNavigation(),
        body: SingleChildScrollView(
          child: SizedBox(
            child: OTPBody(
              duration: duration,
              email: widget.args.email,
              otp: otp,
              resendCtr: _resendCtr,
              verifyEmpty: verifyEmpty,
              errorController: errorController,
              timer: _timer,
              resendOTP: handleResendOTP,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomNavigation() {
    return BottomAppBar(
      color: Colors.white,
      elevation: 0,
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(
                      top: 16,
                      bottom: 16,
                    ).r,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    )),
                onPressed: validForSubmit
                    ? () {
                        InputUtils.unFocus();
                        handleVerifyOTP();
                      }
                    : null,
                child: Text(
                  "Verify",
                  style: TextStyle(
                    fontSize: 16.sp,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
