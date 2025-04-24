import 'package:flutter/material.dart';

import '../gtd_call_back.dart';


class GtdPresentViewHelper {
  // GtdPopoverUtils._();
  // static final shared = GtdPopoverUtils._();

  static void presentView<T>({
    String title = "Popup",
    bool isFullScreen = true,
    bool useRootContext = false,
    bool hasInsetBottom = true,
    bool enableDrag = true,
    Color? contentColor,
    EdgeInsets? contentPadding,
    Function(T result)? onChanged,
    GtdCallback<T?>? onCompleted,
    required BuildContext context,
    required Builder builder,
  }) async {
    final result = await showModalBottomSheet<T>(
        context: context,
        useSafeArea: true,
        enableDrag: enableDrag,
        isScrollControlled: isFullScreen,
        // backgroundColor: contentColor,
        builder: (BuildContext context) {
          return SafeArea(
            bottom: hasInsetBottom,
            child: LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AppBar(
                              title: Padding(
                                padding: const EdgeInsets.all(0),
                                child: Text(
                                  title,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ),
                              automaticallyImplyLeading: false,
                              actions: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(Icons.close))
                              ],
                            ),
                            Expanded(
                              child: ColoredBox(
                                color: contentColor ?? Colors.white,
                                child: Padding(
                                  padding: contentPadding ?? const EdgeInsets.all(16),
                                  child: useRootContext ? builder.build(context) : builder,
                                ),
                              ),
                              // child:
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.viewInsetsOf(context).bottom,
                  )
                ],
              );
            }),
          );
        }).then((result) {
      onCompleted?.call(result);
    });
    if (result != null && onChanged != null) {
      onChanged(result);
    }
  }

  static void presentScrollView<T>({
    String title = "Popup",
    bool isFullScreen = true,
    ScrollPhysics? physics,
    Function(T result)? onChanged,
    required BuildContext context,
    required List<Widget> slivers,
  }) async {
    final result = await showModalBottomSheet<T>(
        context: context,
        useSafeArea: true,
        isScrollControlled: isFullScreen,
        builder: (BuildContext context) {
          return SafeArea(
            child: LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: [
                  AppBar(
                    title: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    automaticallyImplyLeading: false,
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  Expanded(
                    child: CustomScrollView(
                      physics: physics,
                      // slivers: <Widget>[
                      //   SliverToBoxAdapter(
                      //     child: builder,
                      //   ),
                      // ],

                      slivers: slivers,
                    ),
                  ),
                ],
              );
            }),
          );
        });
    if (result != null && onChanged != null) {
      onChanged(result);
    }
  }

  static Future<void> presentSheet<T>({
    String title = "Popup",
    bool isFullScreen = true,
    bool useRootContext = false,
    Color? contentColor,
    EdgeInsets? contentPadding,
    Function(T result)? onChanged,
    required BuildContext context,
    required Builder builder,
  }) async {
    final result = await showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.85),
        child: Padding(
          padding: MediaQuery.viewInsetsOf(context),
          child: IntrinsicHeight(
            child: Column(
              children: [
                AppBar(
                  title: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight:
                          MediaQuery.sizeOf(context).height * 0.85 - 64 - MediaQuery.viewInsetsOf(context).bottom),
                  child: SizedBox(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: contentPadding ?? EdgeInsets.zero,
                        child: Column(
                          children: [
                            useRootContext ? builder.build(context) : builder,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (result != null && onChanged != null) {
      onChanged(result);
    }
  }
}
