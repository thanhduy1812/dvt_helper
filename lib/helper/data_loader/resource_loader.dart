import 'package:flutter/services.dart';

class DVTResourceLoader {
  // static const String gotadiInvoicePath = "gotadi_data/gotadi_invoice_term.html";
  static Future<String> loadContentFromResource({required String pathResource}) {
    // final loader = rootBundle.loadString("packages/gtd_utils/lib/data/resource/$pathResource");
    final loader = rootBundle.loadString(pathResource);
    return loader;
  }
}
