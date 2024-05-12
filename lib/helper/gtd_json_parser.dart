import 'package:dvt_helper/helper/dvt_error.dart';
import 'dvt_error_constant.dart';
import 'gtd_app_logger.dart';

class JsonParser {
  static T jsonToModel<T>(T Function(Map<String, dynamic> map) fromJson, Map response) {
    try {
      return fromJson(response.cast());
    } on TypeError catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}', tag: "JsonParser - jsonToModel");
      throw GtdUtilError.fromError(code: GtdErrorConstant.typeError.code, message: e.stackTrace.toString());
    } catch (e) {
      rethrow;
    }
  }

  static List<T> jsonArrayToModel<T>(T Function(Map<String, dynamic> map) fromJson, List data) {
    try {
      return data.map((e) => fromJson((e as Map).cast())).toList();
    } on TypeError catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}', tag: "JsonParser - jsonArrayToModel");
      throw GtdUtilError.fromError(code: GtdErrorConstant.typeError.code, message: e.stackTrace.toString());
    } catch (e) {
      rethrow;
    }
  }
}
