import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

class GlobalFunctions {
  // static String calculateHMACSHA256(String data, String key) {
  //   var key = utf8.encode('p@ssw0rd');
  //   var bytes = utf8.encode("foobar");

  //   var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
  //   var digest = hmacSha256.convert(bytes);

  //   return '$digest';
  // }

  static String encryptHmacSha256({String key = 'Gotadi', required String value}) {
    var keyHmac = utf8.encode(key);
    var bytesHmac = utf8.encode(value);

    var hmacSha256 = Hmac(sha256, keyHmac); // HMAC-SHA256
    var digest = hmacSha256.convert(bytesHmac);
    String base64 = base64Encode(digest.bytes);
    return base64;
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
