import 'package:dvt_helper/helper/dvt_error_constant.dart';

class GtdUtilError implements Exception {
  String message = "";
  String code = "";
  String localizeMessage = "";
  GtdUtilError({this.message = "", this.code = "", this.localizeMessage = ""});
  GtdUtilError.fromError({this.message = "", this.code = ""});

  static GtdUtilError fromErrorConstant(GtdErrorConstant errorConstant) {
    return GtdUtilError(message: errorConstant.message, code: errorConstant.code);
  }
}
