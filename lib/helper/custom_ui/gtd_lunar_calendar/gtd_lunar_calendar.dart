import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gtd_helper/helper/extension/build_context_extension.dart';
import 'package:gtd_helper/helper/helper.dart';
import 'gtd_date_picker_view/gtd_date_range_picker.dart';
import 'gtd_date_picker_view/gtd_lunar_date.dart';
import 'gtd_luna_converter/gtd_lunar_converter.dart';

enum GtdLunarDayType { start, end, inRange, invisible, visible, currentDate }

enum GtdLunaDayBehavior { both, onlyStart, onlyEnd }

enum GtdLunarDateMode { single, range }

typedef GtdRangeDate = ({DateTime? startDate, DateTime? endDate});

class GtdLunarCalendar extends StatefulWidget {
  final String startDateLabel;
  final String endDateLabel;
  late final DateTime? minDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final GtdLunarDateMode lunarDateMode;
  final GtdLunaDayBehavior lunaDayBehavior;
  final Widget Function(BuildContext context, {DateTime? startDate, DateTime? endDate})? headerBuilder;
  final Widget Function(BuildContext context, {DateTime? startDate, DateTime? endDate, Sink<bool>? resetSink})?
      bottomBuilder;
  
  // Color customization parameters
  final Color mainColor;
  final Color lightMainColor;
  final Color accentColor;
  final Color dayTextColor;
  final Color selectedDayTextColor;
  final Color disabledDayTextColor;
  final Color lunarDayTextColor;
  final Color selectedLunarDayTextColor;

  // final StatefulBuilder? bottomBuilder;
  GtdLunarCalendar(
      {super.key,
      this.headerBuilder,
      required this.bottomBuilder,
      this.startDate,
      this.endDate,
      DateTime? minDate,
      this.lunarDateMode = GtdLunarDateMode.range,
      this.lunaDayBehavior = GtdLunaDayBehavior.both,
      this.startDateLabel = "Vào",
      this.endDateLabel = "Ra",
      this.mainColor = const Color(0xFF1AA260),         // Default primary color
      this.lightMainColor = const Color(0xFFE5F8F0),    // Default light primary color
      this.accentColor = const Color(0xFFF47920),       // Default accent color
      this.dayTextColor = Colors.black,                 // Default day text color
      this.selectedDayTextColor = Colors.black,         // Default selected day text color
      this.disabledDayTextColor = Colors.grey,          // Default disabled day text color
      this.lunarDayTextColor = Colors.grey,             // Default lunar day text color
      this.selectedLunarDayTextColor = Colors.black,    // Default selected lunar day text color
      }) {
    if (lunaDayBehavior == GtdLunaDayBehavior.onlyEnd) {
      this.minDate = startDate;
    } else {
      this.minDate = minDate;
    }
  }

  @override
  State<GtdLunarCalendar> createState() => _GtdLunarCalendarState();
}

class _GtdLunarCalendarState extends State<GtdLunarCalendar> {
  DateTime? _startDate;
  DateTime? _endDate;
  StreamController<bool> resetController = StreamController();
  @override
  void initState() {
    _startDate = widget.startDate;
    _endDate = widget.endDate;
    super.initState();
    resetController.stream.listen((event) {
      if (event == true) {
        setState(() {
          _startDate = null;
          _endDate = null;
        });
      }
    });
  }

  void _onSelectionRangeDate(GtdRangeDate rangeDate) {
    setState(() {
      _startDate = rangeDate.startDate;
      _endDate = rangeDate.endDate;
    });
  }

  Widget rightShapeSide() {
    return Center(
      child: Row(
        children: [
          const Expanded(child: SizedBox()),
          Expanded(
            child: ColoredBox(
              color: (_endDate != null && _startDate != _endDate) ? widget.lightMainColor : Colors.transparent,
              child: const SizedBox(
                height: 48,
                width: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget leftShapeSide() {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: ColoredBox(
              color: (_endDate != null && _startDate != _endDate) ? widget.lightMainColor : Colors.transparent,
              child: const SizedBox(
                height: 48,
                width: double.infinity,
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  Widget subLabel(Alignment alignment, String label) {
    return Align(
      alignment: alignment,
      child: Material(
        color: widget.accentColor,
        shape: CircleBorder(side: BorderSide(color: widget.accentColor)),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget customDayView(
      {required String sunDay,
      required GtdLunarDate lunarDay,
      bool hasCircleRound = false,
      bool isVisible = true,
      bool iSelected = false}) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          sunDay,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: isVisible 
                ? (iSelected ? widget.mainColor : widget.dayTextColor) 
                : widget.disabledDayTextColor),
        ),
        Text(
          lunarDay.lunarDay != 1 ? "${lunarDay.lunarDay}" : "${lunarDay.lunarDay}/${lunarDay.lunarMonth}",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: lunarDay.lunarDay == 1
                  ? Colors.red
                  : isVisible
                      ? (iSelected ? widget.selectedLunarDayTextColor : widget.lunarDayTextColor)
                      : widget.disabledDayTextColor),
        ),
      ],
    );
  }

  Widget buildDayView(
      {required DateTime sunDay,
      required GtdLunarDate lunarDay,
      GtdLunarDayType lunarDayType = GtdLunarDayType.visible}) {
    if (lunarDayType == GtdLunarDayType.currentDate) {
      return Stack(
        children: [
          const SizedBox(),
          Center(
            child: ColoredBox(
              color: Colors.transparent,
              child: SizedBox(
                height: 48,
                width: 48,
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2, color: Colors.grey.shade200), borderRadius: BorderRadius.circular(24)),
                  child: Center(
                    child: customDayView(sunDay: sunDay.day.toString(), lunarDay: lunarDay),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    }
    if (lunarDayType == GtdLunarDayType.invisible) {
      return Center(
        child: ColoredBox(
          color: Colors.transparent,
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: customDayView(sunDay: sunDay.day.toString(), lunarDay: lunarDay, isVisible: false),
          ),
        ),
      );
    }
    if (lunarDayType == GtdLunarDayType.inRange) {
      return Center(
        child: ColoredBox(
          color: widget.lightMainColor,
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: customDayView(sunDay: sunDay.day.toString(), lunarDay: lunarDay),
          ),
        ),
      );
    }
    if (lunarDayType == GtdLunarDayType.start) {
      return Stack(
        children: [
          rightShapeSide(),
          Center(
            child: ColoredBox(
              color: Colors.transparent,
              child: SizedBox(
                height: 48,
                width: 48,
                child: Card(
                  elevation: 1,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2, color: widget.mainColor), borderRadius: BorderRadius.circular(24)),
                  child: Center(
                    child: customDayView(sunDay: sunDay.day.toString(), lunarDay: lunarDay, iSelected: true),
                  ),
                ),
              ),
            ),
          ),
          if (widget.startDateLabel.isNotEmpty) subLabel(Alignment.topLeft, widget.startDateLabel),
        ],
      );
    }

    if (lunarDayType == GtdLunarDayType.end) {
      return Stack(
        children: [
          leftShapeSide(),
          Center(
            child: ColoredBox(
              color: Colors.transparent,
              child: SizedBox(
                height: 48,
                width: 48,
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2, color: widget.mainColor), borderRadius: BorderRadius.circular(24)),
                  child: Center(
                    child: customDayView(sunDay: sunDay.day.toString(), lunarDay: lunarDay, iSelected: true),
                  ),
                ),
              ),
            ),
          ),
          if (widget.endDateLabel.isNotEmpty) subLabel(Alignment.bottomRight, widget.endDateLabel),
        ],
      );
    }
    return Center(
      child: ColoredBox(
        color: Colors.transparent,
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: customDayView(sunDay: sunDay.day.toString(), lunarDay: lunarDay),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.headerBuilder?.call(context, startDate: _startDate, endDate: _endDate) ?? const SizedBox(),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return SizedBox(
                height: context.mediaQuery.size.height - 140,
                child: GtdDateRangePicker(
                  cellBuilder: (context, dateTime) {
                    return customCellBuilder(context, dateTime);
                  },
                  rangeDate: (startDate: widget.startDate, endDate: widget.endDate),
                  lunarDateMode: widget.lunarDateMode,
                  lunaDayBehavior: widget.lunaDayBehavior,
                  onDateChanged: _onSelectionRangeDate,
                ),
              );
            },
          ),
        ),
        widget.bottomBuilder
                ?.call(context, startDate: _startDate, endDate: _endDate, resetSink: resetController.sink) ??
            const SizedBox(),
      ],
    );
  }

  Widget customCellBuilder(BuildContext context, DateTime date) {
    var lunarDate = GtdLunarConverter.convertSolar2Lunar(date);
    if (date.isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
      return buildDayView(sunDay: date, lunarDay: lunarDate, lunarDayType: GtdLunarDayType.invisible);
    }
    if (date.isSameDate(_startDate)) {
      return buildDayView(sunDay: date, lunarDay: lunarDate, lunarDayType: GtdLunarDayType.start);
    }

    if (date.isSameDate(_endDate)) {
      return buildDayView(sunDay: date, lunarDay: lunarDate, lunarDayType: GtdLunarDayType.end);
    }
    if (_startDate != null && _endDate != null && date.isAfter(_startDate!) && date.isBefore(_endDate!)) {
      return buildDayView(sunDay: date, lunarDay: lunarDate, lunarDayType: GtdLunarDayType.inRange);
    }

    if (date.day == DateTime.now().day && date.month == DateTime.now().month && date.year == DateTime.now().year) {
      return buildDayView(sunDay: date, lunarDay: lunarDate, lunarDayType: GtdLunarDayType.currentDate);
    }
    return buildDayView(sunDay: date, lunarDay: lunarDate, lunarDayType: GtdLunarDayType.visible);
  }

  @override
  void dispose() {
    resetController.close();
    super.dispose();
  }
}
