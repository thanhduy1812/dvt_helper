import 'package:flutter/material.dart';

//- Implement later!!!
class GtdCustomAlphabetList extends StatelessWidget {
  final ScrollController _scrollController = ScrollController(initialScrollOffset: 0, keepScrollOffset: true);
  GtdCustomAlphabetList({super.key});
  final List<String> testItems = [
    'Apple', 'Yanana', 'Banana', 'Cherry', 'Durian', 'Elderberry', 'Fig', 'Grape',
    'Honeydew', 'Kiwi', 'Lemon', 'Mango', 'Mange', 'Mangs', 'Menog', 'Moog', 'Nectarine', 'Orange', 'Peach',
    'Quince', 'Raspberry', 'Rasuiis', 'Strawberry', 'Tomato', 'Ugli Fruit', 'Watermelon',
    // Add more items as needed
  ];
  @override
  Widget build(BuildContext context) {
    List<String> alphabet = List.generate(26, (index) => String.fromCharCode('a'.codeUnitAt(0) + index));
    testItems.sort(((a, b) => a.toLowerCase().compareTo(b.toLowerCase())));
    // var groups = testItems.groupListsBy((element) => element.characters.first.toUpperCase());
    return Row(
      children: [
        Expanded(
          child: Scrollbar(
            thumbVisibility: false,
            controller: _scrollController,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: testItems.length,
              // physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 56,
                  child: ListTile(
                    title: Text(testItems[index]),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          width: 30.0,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onLongPressMoveUpdate: (details) {
              // print(details.localPosition);
              int index = details.localPosition.dy ~/ 19.5;
              if (index <= 0) {
                index = 0;
              }
              if (index >= alphabet.length) {
                index = alphabet.length - 1;
              }
              // print(alphabet[index]);
              _scrollToSection(alphabet[index]);
            },
            onTapDown: (details) {
              // print(details.localPosition);
              int index = details.localPosition.dy ~/ 19.5;
              if (index <= 0) {
                index = 0;
              }
              if (index >= alphabet.length) {
                index = alphabet.length - 1;
              }
              // print(alphabet[index]);
              _scrollToSection(alphabet[index]);
            },
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: alphabet.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _scrollToSection(alphabet[index]);
                  },
                  child: Container(
                    width: 30.0,
                    alignment: Alignment.center,
                    child: Text(alphabet[index]),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _scrollToSection(String section) {
    final index = testItems.indexWhere((item) => item.startsWith(section.toUpperCase()));
    if (index != -1) {
      _scrollController.animateTo(
        index * 56.0, // Assuming each item has a height of 56.0
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}
