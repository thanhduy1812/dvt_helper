enum GtdErrorConstant {
  typeError(-1001, "-1001_TYPE_ERROR", "Type cast error"),
  unknown(-1, "unknown", "Đã có lỗi xảy ra, vui lòng thử lại");

  final int id;
  final String code;
  final String message;
  const GtdErrorConstant(this.id, this.code, this.message);

  static GtdErrorConstant findByCode({String? id, String? code}) {
    GtdErrorConstant? error = GtdErrorConstant.values
        .where((element) => "${element.id}" == id || element.code.toLowerCase() == code?.toLowerCase())
        .firstOrNull;
    return error ?? GtdErrorConstant.unknown;
  }
}
