import 'package:dvt_helper/helper/dvt_error_constant.dart';

class DVTUtilError implements Exception {
  String message = "";
  String code = "";
  String localizeMessage = "";
  DVTUtilError({this.message = "", this.code = "", this.localizeMessage = ""});
  DVTUtilError.fromError({this.message = "", this.code = ""});

  static DVTUtilError fromErrorConstant(DVTErrorConstant errorConstant) {
    return DVTUtilError(message: errorConstant.message, code: errorConstant.code);
  }
}
