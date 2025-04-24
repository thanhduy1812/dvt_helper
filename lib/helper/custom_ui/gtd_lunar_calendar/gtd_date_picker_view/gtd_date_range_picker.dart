import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../gtd_lunar_calendar.dart';

typedef GtdDatePickerCellBuilder = Widget Function(BuildContext context, DateTime dateTime);

class GtdDateRangePicker extends StatefulWidget {
  final ValueChanged<GtdRangeDate>? onDateChanged;
  final GtdRangeDate? rangeDate;
  final GtdDatePickerCellBuilder cellBuilder;
  final GtdLunarDateMode lunarDateMode;
  final GtdLunaDayBehavior lunaDayBehavior;

  const GtdDateRangePicker(
      {super.key,
      this.onDateChanged,
      required this.cellBuilder,
      this.rangeDate,
      this.lunarDateMode = GtdLunarDateMode.range,
      this.lunaDayBehavior = GtdLunaDayBehavior.both});

  @override
  GtdDateRangePickerState createState() => GtdDateRangePickerState();
}

class GtdDateRangePickerState extends State<GtdDateRangePicker> {
  late DateTime? startDate;
  late DateTime? endDate;
  late GtdRangeDate rangeDate;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    GtdRangeDate defaultRangeDate = (startDate: null, endDate: null);
    rangeDate = widget.rangeDate ?? defaultRangeDate;
    startDate = rangeDate.startDate;
    endDate = rangeDate.endDate;
    //250 is monthView height (estimate)
    _scrollController = ScrollController(initialScrollOffset: 250.0 * ((startDate ?? DateTime.now()).month - 2));
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _scrollToInitialDate();
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   scrollToInitialOffset();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _buildMonthlyCalendars(context, widget.cellBuilder),
    );
  }

  Widget _buildMonthlyCalendars(BuildContext context, GtdDatePickerCellBuilder builder) {
    final months = Iterable.generate(12).mapIndexed((index, element) {
      int sub = index - 1;
      DateTime now = DateTime.now();
      return DateTime(now.year, now.month + sub, 1);
    }).toList();

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.only(bottom: 200),
      itemBuilder: (context, index) {
        final month = months[index];
        return _buildMonthlyCalendar(context, builder, month);
      },
      itemCount: months.length,
    );
  }

  Widget _buildMonthlyCalendar(BuildContext context, GtdDatePickerCellBuilder builder, DateTime month) {
    int dayInMonth = 1;
    List<String> dayOfWeekLabels = ["Th 2", "Th 3", "Th 4", "Th 5", "Th 6", "Th 7", "CN"];
    // final numberDayInMonth = getDaysInMonth(month).length;
    // int numberDayDisplayInMonthView = month.weekday == 0 ? 42 : 35; // first day in month in column "CN"
    // if (numberDayInMonth == 31 && (month.weekday <= 6 && month.weekday != 0)) {
    //   numberDayDisplayInMonthView = 35;
    // } else {
    //   numberDayDisplayInMonthView = month.weekday == 0 ? 42 : 35;
    // }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            DateFormat('MMMM yyyy', 'vi').format(month).toUpperCase(),
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: dayOfWeekLabels.map((e) {
              if (e == "CN") {
                return Text(e, style: const TextStyle(color: Colors.red));
              } else {
                return Text(e);
              }
            }).toList(),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1.0,
          ),
          itemCount: 42,
          itemBuilder: (context, index) {
            final currentColumn = index % 7;
            final day = DateTime(month.year, month.month, dayInMonth);
            if (day.weekday - 1 == currentColumn) {
              dayInMonth++;
            } else {
              return const SizedBox.shrink();
            }

            final isInMonth = day.month == month.month;
            if (!isInMonth) {
              return const SizedBox.shrink();
            }

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (widget.lunaDayBehavior == GtdLunaDayBehavior.onlyStart) {
                    startDate = day;
                    rangeDate = (startDate: startDate, endDate: endDate);
                    return;
                  }
                  if (widget.lunaDayBehavior == GtdLunaDayBehavior.onlyEnd) {
                    if (startDate != null && day.isBefore(startDate!)) {
                      return;
                    } else {
                      endDate = day;
                    }
                    rangeDate = (startDate: startDate, endDate: endDate);
                    return;
                  }
                  if (widget.lunarDateMode == GtdLunarDateMode.single) {
                    startDate = day;
                    endDate = null;
                    rangeDate = (startDate: startDate, endDate: endDate);
                    return;
                  }

                  //Logic for hande both range
                  if (startDate == null && endDate == null) {
                    startDate = day;
                  } else if (startDate != null && endDate == null) {
                    if (day.isAfter(startDate!)) {
                      endDate = day;
                    } else {
                      startDate = day;
                    }
                  } else if (startDate != null && endDate != null) {
                    startDate = day;
                    endDate = null;
                  }
                  rangeDate = (startDate: startDate, endDate: endDate);
                });
                if (widget.onDateChanged != null) {
                  widget.onDateChanged!(rangeDate);
                }
              },
              child: builder(context, day),
            );
          },
        ),
      ],
    );
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  List<DateTime> getDaysInMonth(DateTime month) {
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    return List.generate(
      daysInMonth,
      (index) => DateTime(month.year, month.month, index + 1),
    );
  }

  void scrollToInitialOffset() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        1000,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}
