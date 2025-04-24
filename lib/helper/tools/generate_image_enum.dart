import 'dart:io';

void main() {
  // Specify the root assets directory
  final directory = Directory('assets');

  // Generate enum from file names
  const enumName = 'GtdImageAssets';
  final buffer = StringBuffer('enum $enumName {\n');

  // Recursively traverse the directory to find image files
  directory.listSync(recursive: true).forEach((file) {
    if (file is File && _isImageFile(file)) {
      final fileName = _getFileName(file);
      final enumEntry = _convertToEnumEntry(fileName);
      final relativePath = file.path.replaceFirst(directory.path, 'assets').replaceFirst(RegExp(r'^[/\\]'), '');
      buffer.writeln('  $enumEntry(\'$relativePath\'),');
    }
  });

  buffer.writeln(';\n');

  // Constructor and field for the enum
  buffer.writeln('  final String path;');
  buffer.writeln('  const $enumName(this.path);');
  buffer.writeln('}');

  // Write the enum to a Dart file
  final enumFile = File('lib/image_assets.dart');
  enumFile.writeAsStringSync(buffer.toString());

  print('Enum generated in ${enumFile.path}');
}

bool _isImageFile(FileSystemEntity file) {
  final validExtensions = ['.png', '.jpg', '.jpeg', '.gif', '.svg'];
  final extension = file.path.split('.').last.toLowerCase();
  return validExtensions.contains('.$extension');
}

String _getFileName(FileSystemEntity file) {
  return file.uri.pathSegments.last;
}

String _convertToEnumEntry(String fileName) {
  return fileName.split('.').first.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_').toLowerCase();
}
