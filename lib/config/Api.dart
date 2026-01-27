import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makingmindstechnologies_360/utils/ApiService.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});