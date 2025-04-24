// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class GtdHtmlView extends StatelessWidget {
  final String? htmlString;
  final bool? shrinkWrap;
  final void Function({String? url, Map<String, String>? attributes})? onLinkTap;
  const GtdHtmlView({super.key, this.htmlString, this.shrinkWrap, this.onLinkTap});

  @override
  Widget build(BuildContext context) {
    return Html(
      data: htmlString,
      shrinkWrap: shrinkWrap ?? false,
      onLinkTap: (url, attributes, element) {
        onLinkTap?.call(url: url, attributes: attributes);
      },
    );
  }
}
