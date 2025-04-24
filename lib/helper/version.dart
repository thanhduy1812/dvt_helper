/// GTD Helper package version information
class GtdVersion {
  /// Current version of the package
  static const String version = '1.0.11';
  
  /// Package release date
  static final DateTime releaseDate = DateTime.now();
  
  /// Returns the current package version
  static String get packageVersion => version;
  
  /// Check if current version is newer than the provided version
  static bool isNewerThan(String otherVersion) {
    final current = version.split('.');
    final other = otherVersion.split('.');
    
    for (int i = 0; i < current.length && i < other.length; i++) {
      final currentNum = int.parse(current[i]);
      final otherNum = int.parse(other[i]);
      
      if (currentNum > otherNum) {
        return true;
      } else if (currentNum < otherNum) {
        return false;
      }
    }
    
    return current.length > other.length;
  }
} 