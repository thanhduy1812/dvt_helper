import 'package:gtd_helper/helper/helpers/extension/date_time_extension.dart';
import 'package:intl/intl.dart';

extension GtdString on String {
  // packages/resource/vib_assets/images/logo_b2c.svg
  static pathForAsset(String? package, String assetName) {
    if (package != null) {
      return 'packages/$package/$assetName';
    } else {
      return assetName;
    }
  }

  static urlForAssetAirlineLogo(String fileName, String assetName) {
    return 'https://750bc7d3dc6109b.cmccloud.com.vn/Booking/AirBooking/images/AirLogos/$assetName.$fileName';
  }

  static pathForAssetGlobal(String? package, String assetName) {
    if (package != null) {
      return 'packages/$package/$assetName';
    } else {
      return assetName;
    }
  }

  String removeDiacritics() {
    // Sử dụng biểu thức chính quy để loại bỏ dấu
    return replaceAll(RegExp(r'[àáạảãâầấậẩẫăằắặẳẵ]'), 'a')
        .replaceAll(RegExp(r'[èéẹẻẽêềếệểễ]'), 'e')
        .replaceAll(RegExp(r'[ìíịỉĩ]'), 'i')
        .replaceAll(RegExp(r'[òóọỏõôồốộổỗơờớợởỡ]'), 'o')
        .replaceAll(RegExp(r'[ùúụủũưừứựửữ]'), 'u')
        .replaceAll(RegExp(r'[ỳýỵỷỹ]'), 'y')
        .replaceAll(RegExp(r'đ'), 'd')
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), ' '); // Loại bỏ ký tự đặc biệt và thay thế bằng dấu cách
  }

  String capitalize() {
    if (isEmpty) return '';
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  bool containsCharacters() {
    return RegExp(r"[^a-z]", caseSensitive: false).hasMatch(this);
  }

  bool isNumeric() {
    if (isNotEmpty) {
      final value = double.tryParse(this);
      return value != null;
    }
    return false;
  }

  bool isPhoneNumber() {
    return (length == 10 && length == 11) && startsWith('0');
  }

  bool isEmailAddress() {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);
  }

  DateTime toDateTime(String pattern) {
    return DateFormat(pattern).parse(this);
  }

  String toDateString({
    required String inputPattern,
    required String outputPattern,
  }) {
    final dateTime = toDateTime(inputPattern);
    return DateFormat(outputPattern).format(dateTime);
  }
}

extension GtdStringNull on String? {
  bool isNullOrEmpty() {
    if (this == null) {
      return true;
    } else {
      if (this!.isEmpty) {
        return true;
      }
      return false;
    }
  }

  String? formatDateStringFull(String outputPattern) {
    if (isNullOrEmpty()) {
      return null;
    } else {
      final date = DateTime.parse(this!);
      return date.localDate(pattern1);
    }
  }
}
