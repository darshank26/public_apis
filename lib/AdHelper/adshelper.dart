import 'dart:io';

class AdHelper {

  static String get bannerAdUnitIdOfHomeScreen {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2180535035689124/8318641705';
    }  else {
      throw UnsupportedError('Unsupported platform');
    }
  }


  static String get appOpenAd {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2180535035689124/6147257019';
    }  else {
      throw UnsupportedError('Unsupported platform');
    }
  }

}