import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

class WorkAttendanceComponent extends StatelessWidget {
  const WorkAttendanceComponent({super.key});

  @override
  Widget build(BuildContext context) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: white.withValues(alpha: 0.8),
            shape: buildRoundedCorner(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.cyan.shade800,
                    shape: buildRoundedCorner(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            onClocLocale.lblAttendanceStatus,
                            style: primaryTextStyle(color: white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  5.height,
                  Obx(() => mainStore.getCurrentStatus!.status != 'new'
                          ? Column(
                              children: [
                                Text(
                                    '${onClocLocale.lblAttendanceInAt} : ${mainStore.getCurrentStatus!.checkInAt!.toString()}'),
                                mainStore.getCurrentStatus!.checkOutAt != null
                                    ? Text(
                                        '${onClocLocale.lblAttendanceOutAt} : ${mainStore.getCurrentStatus!.checkOutAt!.toString()}')
                                    : Container()
                              ],
                            )
                          : Text(onClocLocale.lblCheckInToBegin)),
                ],
              ),
            ),
          )
        ],
      ),
    );
}