import 'package:flutter/foundation.dart';

class Logger {
  static log(Object? object) {
    if (kDebugMode) {
      print(object);
    }
  }
}
