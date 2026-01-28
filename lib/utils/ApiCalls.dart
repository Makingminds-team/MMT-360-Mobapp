import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makingmindstechnologies_360/config/Api.dart';
import 'package:makingmindstechnologies_360/screens/dashboard/model/DashboardEmployeeSummaryModel.dart';
import 'package:makingmindstechnologies_360/screens/login/model/AdminInfoModel.dart';
import 'package:makingmindstechnologies_360/screens/login/model/LoginModel.dart';
import 'package:makingmindstechnologies_360/utils/Generic.dart';


//LOGIN
final loginPostProvider = FutureProvider.autoDispose
    .family<LoginModel?, Map<String, dynamic>>((ref, formData) async {
  return ref.watch(apiServiceProvider).LoginApi(formData);
});

// ADMIN INFO
final adminInfoProvider =
    FutureProvider.autoDispose<AdminInfoModel?>((ref) async {
  return ref.watch(apiServiceProvider).adminInfoDetailsApi();
});

// dashboard summary
final dasboardEmployeeSummary = FutureProvider<DashboardEmployeeSummaryModel?>((ref) async {
  return ref.watch(apiServiceProvider).dasboardSummaryApi();
});



final refereshTokenProvider = FutureProvider<bool?>((ref) async {
  return ref.watch(apiServiceProvider).refreshToken();
});

Timer? _refreshTokenTimer;
bool _isLoggedIn = false;


final refreshNotifier = FutureProvider<void>((ref) async {
  // Call your token refresh API here
  final routesData = await getRoutes();
  _isLoggedIn = routesData;

  _refreshTokenTimer?.cancel();
  _refreshTokenTimer = Timer.periodic(Duration(minutes: 25), (timer) async {
    if (_isLoggedIn){
      await ref.read(refereshTokenProvider.future);
    } else {
      stopRefreshTokenTimer();
    }
  });
});

void stopRefreshTokenTimer() {
  _refreshTokenTimer?.cancel();
}

