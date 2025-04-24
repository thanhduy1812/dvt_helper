import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtd_helper/helper/custom_ui/gtd_present_view_helper.dart';
import 'package:gtd_helper/helper/helper.dart';

import '../gtd_button.dart';
import 'gtd_lunar_calendar.dart';

class GtdCalendarHelper {
  static void presentLunaCalendar(
      {required BuildContext context,
      GtdLunarDateMode lunaDateMode = GtdLunarDateMode.range,
      GtdLunaDayBehavior lunaDayBehavior = GtdLunaDayBehavior.both,
      String title = "Chọn ngày",
      String dayStartLabel = "Đi",
      String dayEndLabel = "Về",
      String selectDayViewStartLabel = "Chọn ngày đi",
      String selectDayViewEndLabel = "Chọn ngày về",
      DateTime? minDate,
      DateTime? initStartDate,
      DateTime? initEndate,
      // Color customization
      Color? mainColor,
      Color? lightMainColor,
      Color? accentColor,
      GtdCallback<({DateTime? startDate, DateTime? endDate})>? onSelected}) {
    // Default colors
    final primaryColor = Theme.of(context).primaryColor;
    final Color defaultMainColor = mainColor ?? primaryColor;
    final Color defaultAccentColor = accentColor ?? const Color(0xFFF47920);
    final Color defaultLightMainColor = lightMainColor ?? primaryColor.withOpacity(0.1);
    
    return GtdPresentViewHelper.presentView(
      title: title,
      context: context,
      useRootContext: false,
      contentPadding: EdgeInsets.zero,
      hasInsetBottom: false,
      builder: Builder(
        builder: (context) {
          return GtdLunarCalendar(
            startDateLabel: dayStartLabel,
            endDateLabel: dayEndLabel,
            lunarDateMode: lunaDateMode,
            lunaDayBehavior: lunaDayBehavior,
            startDate: initStartDate ?? DateTime.now().add(const Duration(days: 1)),
            endDate: lunaDateMode == GtdLunarDateMode.range || lunaDayBehavior == GtdLunaDayBehavior.onlyEnd
                ? initEndate
                : null,
            minDate: minDate,
            // Pass custom colors
            mainColor: defaultMainColor,
            lightMainColor: defaultLightMainColor,
            accentColor: defaultAccentColor,
            headerBuilder: (context, {endDate, startDate}) {
              return SizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: (startDate != null && endDate == null)
                                  ? defaultAccentColor
                                  : Colors.grey.shade200,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            constraints: const BoxConstraints(
                              minHeight: 61,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 16,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectDayViewStartLabel,
                                    style: TextStyle(
                                      fontSize: startDate != null ? 13 : 15,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  startDate != null
                                      ? Text(
                                          startDate.localDate("EE, dd/MM/yyy"),
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey.shade900,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (lunaDateMode == GtdLunarDateMode.range) ...[
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Card(
                            elevation: 0,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: (endDate != null) ? defaultAccentColor : Colors.grey.shade200,
                                    width: 1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Container(
                              constraints: const BoxConstraints(
                                minHeight: 61,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 16,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      selectDayViewEndLabel,
                                      style: TextStyle(
                                        fontSize: endDate != null ? 13 : 15,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    endDate != null
                                        ? Text(
                                            endDate.localDate("EE, dd/MM/yyy"),
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey.shade900,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
            bottomBuilder: (context, {endDate, resetSink, startDate}) {
              return SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: GtdButton(
                          text: "Xoá",
                          height: 50,
                          colorText: Colors.black,
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: 25,
                          onPressed: () {
                            resetSink?.add(true);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: GtdButton(
                          text: "Áp dụng",
                          isEnable: (lunaDateMode == GtdLunarDateMode.range ||
                                  (lunaDateMode == GtdLunarDateMode.single &&
                                      lunaDayBehavior == GtdLunaDayBehavior.onlyEnd))
                              ? (startDate != null && endDate != null)
                              : startDate != null,
                          colorText: Colors.white,
                          color: defaultMainColor,
                          height: 50,
                          borderRadius: 25,
                          onPressed: () {
                            context.pop();
                            onSelected?.call((startDate: startDate, endDate: endDate));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
