import 'dart:io';
import 'dart:ui';

class LocaleUtils {
  static Locale? toLocale(String localeString) {
    if (localeString.isEmpty) return null;
    if (localeString.contains('_')) {
      return Locale(localeString.split('_').first);
    } else if (localeString.contains('-')) {
      return Locale(localeString.split('-').first);
    } else {
      return Locale(localeString);
    }
  }

  static bool isDefaultLocale(Locale locale) {
    final systemLocale = LocaleUtils.toLocale(Platform.localeName);

    return locale.languageCode == systemLocale?.languageCode;
  }
}
