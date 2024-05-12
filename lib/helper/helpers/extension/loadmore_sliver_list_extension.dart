// import 'dart:async';
// import 'package:flutter/widgets.dart';
// import 'package:rxdart/rxdart.dart';

// typedef LoadMore = Future Function();

// typedef OnLoadMore = void Function();

// typedef ItemCount = int Function();

// typedef HasMore = bool Function();

// typedef OnLoadMoreFinished = void Function();

// class GtdLoadMoreSliverExtention extends StatefulWidget {
//   /// A callback that indicates if the collection associated with the ListView has more items that should be loaded
//   final HasMore hasMore;
//   final LoadMore loadMore;

//   final int loadMoreOffsetFromBottom;

//   final IndexedWidgetBuilder itemBuilder;
//   final IndexedWidgetBuilder separatorBuilder;
//   final ItemCount itemCount;
//   final bool addAutomaticKeepAlives;
//   final bool addRepaintBoundaries;

//   /// A callback that is triggered when more items are being loaded
//   final OnLoadMore? onLoadMore;

//   /// A callback that is triggered when items have finished being loaded
//   final OnLoadMoreFinished? onLoadMoreFinished;

//   const GtdLoadMoreSliverExtention({
//     super.key,
//     required this.hasMore,
//     required this.loadMore,
//     this.loadMoreOffsetFromBottom = 0,
//     required this.itemBuilder,
//     required this.itemCount,
//     required this.separatorBuilder,
//     this.addAutomaticKeepAlives = true,
//     this.addRepaintBoundaries = true,
//     this.onLoadMore,
//     this.onLoadMoreFinished,
//   });

//   @override
//   GtdLoadMoreSliverExtentionState createState() {
//     return GtdLoadMoreSliverExtentionState();
//   }
// }

// class GtdLoadMoreSliverExtentionState extends State<GtdLoadMoreSliverExtention> {
//   bool _loadingMore = false;
//   final PublishSubject<bool> _loadingMoreSubject = PublishSubject<bool>();
//   Stream<bool>? _loadingMoreStream;

//   GtdLoadMoreSliverExtentionState() {
//     _loadingMoreStream = _loadingMoreSubject.switchMap((shouldLoadMore) => loadMore());
//   }

//   Widget _buildItem(BuildContext context, int index) {
//     if (!_loadingMore && index == widget.itemCount() - widget.loadMoreOffsetFromBottom - 1 && widget.hasMore()) {
//       _loadingMore = true;
//       _loadingMoreSubject.add(true);
//     }

//     return widget.itemBuilder(context, index);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: _loadingMoreStream,
//         builder: (context, snapshot) {
//           return SliverList.separated(
//             key: widget.key,
//             itemBuilder: _buildItem,
//             itemCount: widget.itemCount(),
//             addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
//             addRepaintBoundaries: widget.addRepaintBoundaries,
//             separatorBuilder: widget.separatorBuilder,
//           );
//         });
//   }

//   Stream<bool> loadMore() async* {
//     yield _loadingMore;
//     if (widget.onLoadMore != null) {
//       widget.onLoadMore!();
//     }
//     await widget.loadMore();
//     _loadingMore = false;
//     yield _loadingMore;
//     if (widget.onLoadMoreFinished != null) {
//       widget.onLoadMoreFinished!();
//     }
//   }

//   @override
//   void dispose() {
//     _loadingMoreSubject.close();
//     super.dispose();
//   }
// }
