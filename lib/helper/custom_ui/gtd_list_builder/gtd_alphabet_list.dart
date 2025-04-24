import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';

// class ContactModel extends AlphaModel {
//   final String name;
//   ContactModel(super.key, {required this.name});
// }
abstract class GtdAlphabetModel<T> extends ISuspensionBean {
  final T model;
  String groupName;
  bool hasHeader;
  bool hasFooter;
  GtdAlphabetModel({required this.model, required this.groupName, this.hasHeader = false, this.hasFooter = false});

  @override
  String getSuspensionTag() {
    return groupName;
  }

  @override
  bool get isShowSuspension => !hasHeader;
}

class ContactModel extends GtdAlphabetModel<String> {
  ContactModel({required super.model, required super.groupName, super.hasHeader, super.hasFooter});
  // final String name;
  // String? tagIndex;
  // String? subname;
  // bool hasHeader;
  // bool hasFooter;
  // ContactModel({required this.name, this.tagIndex, this.subname, this.hasHeader = false, this.hasFooter = false});
}

class GtdAlphabetList<T extends GtdAlphabetModel> extends StatelessWidget {
  final List<T> data;
  final Widget Function(BuildContext context, T item)? headerBuilder;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Widget Function(BuildContext context, T item)? footerBuilder;
  const GtdAlphabetList(
      {super.key, required this.data, this.headerBuilder, this.footerBuilder, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return AzListView(
      data: data,
      itemCount: data.length,
      itemBuilder: (context, index) {
        var model = data[index];
        return Column(
          children: [
            Offstage(
              offstage: !model.hasHeader,
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [headerBuilder?.call(context, model) ?? const SizedBox(), const Divider()],
                ),
              ),
            ),
            Offstage(
              offstage: model.hasHeader,
              child: const Divider(),
            ),
            itemBuilder.call(context, model),
            Offstage(
              offstage: !model.hasFooter,
              child: footerBuilder?.call(context, model),
            ),
          ],
        );
      },
      physics: const BouncingScrollPhysics(),
      indexBarData: SuspensionUtil.getTagIndexList(data),
      indexHintBuilder: (context, hint) {
        return Container(
          alignment: Alignment.center,
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            color: Colors.grey.shade200.withAlpha(200),
            shape: BoxShape.circle,
          ),
          child: Text(hint, style: const TextStyle(color: Colors.black, fontSize: 30.0)),
        );
      },
      indexBarMargin: const EdgeInsets.all(0),
      indexBarOptions: const IndexBarOptions(
        needRebuild: true,
        textStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFF007AFF),
        ),

        // decoration: getIndexBarDecoration(Colors.grey[50]!),
        // downDecoration: getIndexBarDecoration(Colors.grey[200]!),
      ),
    );
  }

  Decoration getIndexBarDecoration(Color color) {
    return BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.grey[300]!, width: .5));
  }
}
