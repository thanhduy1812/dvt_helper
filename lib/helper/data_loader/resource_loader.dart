import 'package:flutter/services.dart';

class GtdResourceLoader {
  // static const String gotadiInvoicePath = "gotadi_data/gotadi_invoice_term.html";
  static Future<String> loadContentFromResource({required String pathResource}) {
    // final loader = rootBundle.loadString("packages/gtd_utils/lib/data/resource/$pathResource");
    final loader = rootBundle.loadString(pathResource);
    return loader;
  }
  
  /// Loads a string from a file within a package
  /// 
  /// Parameters:
  /// - packageName: Name of the package (e.g., 'gtd_utils')
  /// - filePath: Path to the file within the package (e.g., 'lib/data/resource/file.txt')
  /// 
  /// Returns a Future<String> containing the file contents
  static Future<String> loadFromPackage({
    required String packageName,
    required String filePath,
  }) {
    final fullPath = 'packages/$packageName/$filePath';
    return rootBundle.loadString(fullPath);
  }
}
