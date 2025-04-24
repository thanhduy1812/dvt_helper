import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

bool get isAndroid => !kIsWeb && Platform.isAndroid;
bool get isiOS => !kIsWeb && Platform.isIOS;
bool get isWeb => kIsWeb;

class GlobalFunctions {
  // static String calculateHMACSHA256(String data, String key) {
  //   var key = utf8.encode('p@ssw0rd');
  //   var bytes = utf8.encode("foobar");

  //   var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
  //   var digest = hmacSha256.convert(bytes);

  //   return '$digest';
  // }

  static String encryptHmacSha256({String key = 'VNLook', required String value}) {
    var keyHmac = utf8.encode(key);
    var bytesHmac = utf8.encode(value);

    var hmacSha256 = Hmac(sha256, keyHmac); // HMAC-SHA256
    var digest = hmacSha256.convert(bytesHmac);
    String base64 = base64Encode(digest.bytes);
    return base64;
  }
  
  /// Returns the original value used to create the HMAC-SHA256 hash.
  /// 
  /// This function accepts an encrypted base64 string and attempts to
  /// decode it back to its original form.
  /// 
  /// Note: This doesn't decrypt the actual HMAC-SHA256 hash (which is one-way),
  /// but it decodes the base64 representation back to the bytes of the hash.
  /// 
  /// Parameters:
  /// - encryptedValue: The Base64 encoded string to decode
  /// 
  /// Returns: The decoded string representation of the hash value
  static String decryptHmacSha256({required String encryptedValue}) {
    try {
      // Decode the base64 string back to bytes
      List<int> bytes = base64Decode(encryptedValue);
      
      // Convert the bytes to a hexadecimal string representation
      return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
    } catch (e) {
      // Return empty string if decoding fails
      return '';
    }
  }
  
  /// Verifies if the provided value generates the same hash when encrypted with the same key.
  /// 
  /// Parameters:
  /// - encryptedValue: The Base64 encoded HMAC-SHA256 hash to verify against
  /// - key: The secret key used for encryption (default: 'VNLook')
  /// - valueToCheck: The plaintext value to check against the encrypted hash
  /// 
  /// Returns: True if the valueToCheck would produce the same hash as encryptedValue when encrypted
  static bool verifyHmacSha256({
    required String encryptedValue, 
    String key = 'VNLook', 
    required String valueToCheck
  }) {
    // Generate hash for the value to check
    String generatedHash = encryptHmacSha256(key: key, value: valueToCheck);
    
    // Compare the generated hash with the encrypted value
    return generatedHash == encryptedValue;
  }

  static Offset getPositionBottomLeft(GlobalKey parentKey, GlobalKey childKey) {
    final parentBox = parentKey.currentContext!.findRenderObject() as RenderBox?;
    if (parentBox == null) {
      throw Exception();
    }
    final childBox = childKey.currentContext!.findRenderObject() as RenderBox?;
    if (childBox == null) {
      throw Exception();
    }

    final parentPosition = parentBox.localToGlobal(Offset.zero);
    final parentHeight = parentBox.size.height;

    final childPosition = childBox.localToGlobal(Offset.zero);
    final childHeight = childBox.size.height;

    final x = childPosition.dx - parentPosition.dx;
    final y = (childPosition.dy + childHeight - parentPosition.dy - parentHeight).abs();

    return Offset(x, y);
  }

  
}

// For iOS 16 and below, set the status bar color to match the app's theme.
// https://github.com/flutter/flutter/issues/41067
Brightness? _lastBrightness;
void fixStatusBarOniOS16AndBelow(BuildContext context) {
  if (!isiOS) {
    return;
  }
  final brightness = Theme.of(context).brightness;
  if (_lastBrightness != brightness) {
    _lastBrightness = brightness;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: brightness,
        systemStatusBarContrastEnforced: true,
      ),
    );
  }
}

/// Get Widget bounding
Rect? getWidgetBoundingBox(BuildContext context) {
  try {
    final renderBox = context.findRenderObject() as RenderBox?;
    return renderBox!.localToGlobal(Offset.zero) & renderBox.size;
  } catch (_) {
    return null;
  }
}

T valueOrDefault<T>(T? value, T defaultValue) =>
    (value is String && value.isEmpty) || value == null ? defaultValue : value;

Future launchURL(String url) async {
  var uri = Uri.parse(url);
  try {
    await launchUrl(uri);
  } catch (e) {
    throw 'Could not launch $uri: $e';
  }
}

//Validation Reg Text
const kTextValidatorUsernameRegex = r'^[a-zA-Z][a-zA-Z0-9_-]{2,16}$';
// https://stackoverflow.com/a/201378
const kTextValidatorEmailRegex =
    "^(?:[a-zA-Z0-9!#\$%&\'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#\$%&\'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])\$";
const kTextValidatorWebsiteRegex =
    r'(https?:\/\/)?(www\.)[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,10}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)|(https?:\/\/)?(www\.)?(?!ww)[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,10}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)';

void showSnackbar(
  BuildContext context,
  String message, {
  bool loading = false,
  int duration = 4,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          if (loading)
            const Padding(
              padding: EdgeInsetsDirectional.only(end: 10.0),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          Text(message),
        ],
      ),
      duration: Duration(seconds: duration),
    ),
  );
}