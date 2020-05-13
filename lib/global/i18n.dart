import 'package:i18n_extension/i18n_extension.dart';

extension GlobalLocalization on String {
  static var _t = Translations('en_us') +
      {
        "en_us": "Unexpected error. Please try later",
        "ru_ru": "Произошла ошибка. Попробуйте позже",
      } +
      {
        "en_us": "Loading... please wait",
        "ru_ru": "Подождите... идёт загрузка",
      } +
      {
        'en_us': 'PhotoLocal',
        'ru_ru': 'PhotoLocal',
      };
  String get i18n => localize(this, _t);
}
