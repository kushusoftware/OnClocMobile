import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/theme/theme_controller.dart';
import 'package:on_cloc_mobile/app/models/client/client_feedback.dart';
import 'package:on_cloc_mobile/app/models/client/client_profile.dart';
import 'package:on_cloc_mobile/app/models/ticket/service_ticket.dart';
import 'package:on_cloc_mobile/app/models/ticket/ticket_task.dart';
import 'package:on_cloc_mobile/app/models/ticket/ticket_task_step.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

Widget commonVerticalDivider() {
  return const VerticalDivider(
    color: onClocDividerColor,
    thickness: 1,
    indent: 5,
  );
}

Widget commonHorizontalDivider() {
  final OnClocThemeController themeController = Get.put(OnClocThemeController());
  return Divider(
    color:
        themeController.isDarkMode ? onClocHintColorDark : onClocDividerColor,
    thickness: 1,
  );
}

Widget onClocDottedLine(Color dashColor) {
  Get.put(OnClocThemeController());
  return DottedLine(
    dashColor: dashColor,
    lineThickness: 1.0,
    dashLength: 4.0,
  );
}

Widget leadingText(String name, ThemeData theme) {
  return Text(
    name,
    style: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w500,
        color: Get.isDarkMode ? onClocHintColorDark: onClocHintColorLight),
  );
}

Widget trailingText(String name, Color? color, ThemeData theme) {
  return Text(
    name,
    style: theme.textTheme.bodyMedium
        ?.copyWith(fontWeight: FontWeight.w600, color: color),
  );
}


Widget commonTicketView(ServiceTicket data, ThemeData theme, double? width) {
  final OnClocThemeController themeController = Get.put(
    OnClocThemeController(),
  );
  return Container(
    width: width,
    decoration: BoxDecoration(
      color:
          themeController.isDarkMode
              ? onClocHintColorDark
              : onClocCardBgColorLight,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: onClocPortalCachedImageWidget(
            data.clientsList[0].avatarUrl,
            150,
            width: double.infinity,
          ),
        ),
        20.height,
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.number,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color:
                                themeController.isDarkMode
                                    ? onClocWhiteColor
                                    : onClocBlueGreyColor,
                            fontSize: 16,
                          ),
                        ),
                        5.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              color: onClocGreenColor,
                              size: 20,
                            ),
                            7.width,
                            Text(
                              data.ticketRating.toString(),
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color:
                                    themeController.isDarkMode
                                        ? onClocWhiteColor
                                        : onClocBlueGreyColor,
                              ),
                            ),
                            5.width,
                            Text(
                              data.description,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                color:
                                    themeController.isDarkMode
                                        ? onClocDividerColor
                                        : onClocHintColorLight,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: 34,
                    width: 47,
                    decoration: BoxDecoration(
                      color: servpalPrimaryColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Text(
                        data.openedOnDate.toString(),
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: onClocWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              15.height,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  onClocPortalCachedImageWidget(data.clientsList[0].avatarUrl, 35, width: 35),
                  7.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        data.subject,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color:
                              themeController.isDarkMode
                                  ? onClocWhiteColor
                                  : onClocBlueGreyColor,
                        ),
                      ),
                      7.height,
                      RichText(
                        text: TextSpan(
                          text: data.subject,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: themeController.isDarkMode
                                ? onClocWhiteColor
                                : onClocBlueGreyColor,
                          ),
                          children: [
                            WidgetSpan(child: commonVerticalDivider()),
                            TextSpan(
                              text: 'Due: ${data.dueOnDate.day.toString()}-${data.dueOnDate.month.toString()}-${data.dueOnDate.year.toString()}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: themeController.isDarkMode
                                    ? onClocDividerColor
                                    : onClocHintColorLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget commonClientView(ClientProfile data, ThemeData theme, double? width) {
  final OnClocThemeController themeController = Get.put(
    OnClocThemeController(),
  );
  return Container(
    width: width,
    decoration: BoxDecoration(
      color:
          themeController.isDarkMode
              ? servpalOptionalColor
              : onClocCardBgColorLight,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      border: Border.all(
        color:
            themeController.isDarkMode
                ? servpalCardBorderColorDark
                : servpalCardBorderColorLight,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: onClocPortalCachedImageWidget(
            data.avatarUrl,
            150,
            width: double.infinity,
          ),
        ),
        20.height,
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.clientName,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color:
                                themeController.isDarkMode
                                    ? onClocWhiteColor
                                    : onClocBlueGreyColor,
                            fontSize: 16,
                          ),
                        ),
                        5.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              color: onClocDarkYellowColor,
                              size: 20,
                            ),
                            7.width,
                            Text(
                              data.status ?? '',
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color:
                                    themeController.isDarkMode
                                        ? onClocWhiteColor
                                        : onClocBlueGreyColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    onClocProfileIcon,
                    colorFilter: ColorFilter.mode(
                      Get.isDarkMode ? onClocWhiteColor : onClocBlueGreyColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
              15.height,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        data.contactPerson ?? '',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color:
                              themeController.isDarkMode
                                  ? onClocTextColorSecondaryDark
                                  : onClocTextColorSecondaryLight,
                        ),
                      ),
                      7.height,
                      Text(
                        data.phoneNumber ?? '',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color:
                              themeController.isDarkMode
                                  ? onClocTextColorSecondaryDark
                                  : onClocTextColorSecondaryLight,
                        ),
                      ),
                      7.height,
                      Text(
                        data.city ?? '',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color:
                              themeController.isDarkMode
                                  ? onClocTextColorSecondaryDark
                                  : onClocTextColorSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget commonTicketTaskView(TicketTask data, ThemeData theme) {
  return Padding(
    padding: const EdgeInsets.only(top: 6),
    child: Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.checklist,
                  color: onClocBlueGreyColor,
                  size: 18,
                ),
                5.width,
                Text(
                  'Task',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            5.height,
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                    data.taskInstructions,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            5.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  data.taskSteps.isEmpty
                    ? Text(
                      onClocLocale.lblNoDataAvailable,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: onClocBlueGreyColor,
                      ),
                    )
                    : ListView.builder(
                      itemCount: data.taskSteps.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final TicketTaskStep step = data.taskSteps[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: onClocBlueGreyColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            step.stepsTaken,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: onClocBlueGreyColor,
                            ),
                          ),
                        );
                      },
                    ),
              ],
            ),
            18.height,
            Text(
              data.technicalRemarks ?? '',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color:
                    Get.isDarkMode ? onClocHintColorDark : onClocHintColorLight,
              ),
            ),
            18.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Due: ${data.dueDate.day.toString()}-${data.dueDate.month.toString()}-${data.dueDate.year.toString()}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                10.height,
                const Icon(
                  Icons.check_rounded,
                  color: onClocGreenColor,
                  size: 18,
                ),
                5.width,
                Text(
                  data.isCompleted ? 'Completed' : 'Pending',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget commonClientReviewView(ClientFeedback data, ThemeData theme) {
  return Padding(
    padding: const EdgeInsets.only(top: 12),
    child: Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.feedbackQuestion,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      2.height,
                      Text(
                        data.serviceTicketId,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          color:
                              Get.isDarkMode
                                  ? onClocHintColorDark
                                  : onClocHintColorLight,
                        ),
                      ),
                    ],
                  ),
                ),
                10.height,
                const Icon(Icons.star, color: onClocDarkYellowColor, size: 18),
                5.width,
                Text(
                  data.ratingScore.toString(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            18.height,
            Text(
              data.comment,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color:
                    Get.isDarkMode ? onClocHintColorDark : onClocHintColorLight,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
