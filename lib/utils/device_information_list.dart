
import 'dart:io';

class DeviceInfo{
  static Future<String> getPhoneInfo() async {
    if(Platform.isAndroid) {
    return "Android";
    } else if(Platform.isIOS) {
      return "iOS";
    }
    return "";
  }

}

