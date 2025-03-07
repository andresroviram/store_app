part of 'extension.dart';

extension NullableStringExtension on String? {
  String? toParamUrl(Map<String, dynamic> params) {
    if (this != null) {
      return params.replaceUrlParams(this!);
    }
    return null;
  }

  bool get toBool => this == 'true';

  num? get toNumeric => num.tryParse(this!);

  double? get toDouble => num.tryParse(this!)?.toDouble();

  int? get toInt => num.tryParse(this!)?.toInt();

  DateTime? get toDateTime {
    if (this == null) {
      return null;
    }
    return DateTime.tryParse(this!)!;
  }
}
