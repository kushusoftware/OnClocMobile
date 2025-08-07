import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/ticket/ticket_detail_controller.dart';
import 'package:on_cloc_mobile/app/models/client/client_feedback.dart';
import 'package:on_cloc_mobile/app/models/client/client_profile.dart';
import 'package:on_cloc_mobile/app/models/ticket/ticket_task.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/utilities/routes.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';
import 'package:on_cloc_mobile/widgets/common_button.dart';
import 'package:on_cloc_mobile/widgets/view_widgets.dart';

class OnClocTicketDetailScreen extends StatefulWidget {
  const OnClocTicketDetailScreen({super.key});

  @override
  State<OnClocTicketDetailScreen> createState() =>
      OnClocTicketDetailScreenState();
}

class OnClocTicketDetailScreenState extends State<OnClocTicketDetailScreen> {
  final OnClocTicketDetailController controller = Get.put(
    OnClocTicketDetailController(),
  );

  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme = Get.isDarkMode ? OnClocTheme.darkTheme : OnClocTheme.lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocTicketDetailController>(
      init: controller,
      tag: 'ticket_detail',
      builder: (_) => Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: onClocCommonAppBarWidget(
              context,
              titleText: onClocLocale.lblServiceTicketDetails,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Card(
                      color:
                          Get.isDarkMode
                              ? servpalBgColorDark
                              : onClocWhiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: BorderSide(
                          color:
                              Get.isDarkMode
                                  ? servpalCardBgColorDark
                                  : onClocBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: onClocPortalCachedImageWidget(
                                    controller.ticket.clientsList[0].avatarUrl,
                                    60,
                                    width: 60,
                                  ),
                                ),
                                10.width,
                                Text(
                                  controller.ticket.number,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: onClocHintColorLight,
                                  ),
                                ),
                              ],
                            ),
                            23.height,
                            ticketDetailCard(),
                            25.height,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 18,
                                    right: 18,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          Get.isDarkMode
                                              ? onClocHintColorDark
                                              : onClocHintColorLight,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          commonButtons(
                                            0,
                                            onClocLocale.lblDescription,
                                          ),
                                          5.width,
                                          commonButtons(
                                            1,
                                            onClocLocale.lblTasks,
                                          ),
                                          5.width,
                                          commonButtons(
                                            2,
                                            onClocLocale.lblReviews,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                25.height,
                                Obx(() {
                                  return (controller.selectedIndex.value == 0 ||
                                          controller.selectedIndex.value == 1)
                                      ? descriptionAndTasksView()
                                      : reviewView();
                                }),
                                25.height,
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 18,
                                    right: 18,
                                    bottom:
                                        GetPlatform.isIOS
                                            ? MediaQuery.of(
                                              context,
                                            ).padding.bottom
                                            : 15,
                                  ),
                                  child: OnClocCommonButton(
                                    text: onClocLocale.lblHandleTicket,
                                    bgColor: Get.isDarkMode
                                        ? servpalSecondaryColorDark
                                        : servpalPrimaryColor,
                                    onPressed:
                                        () => Navigator.of(context).pushNamed(
                                          OnClocRoutes.onClocTicketHandlingScreen,
                                          arguments: controller.ticket,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget reviewView() => Padding(
    padding: const EdgeInsets.only(left: 18, right: 18),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              onClocLocale.lblReviews,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            5.width,
            Expanded(
              child: Text(
                '(${controller.ticket.feedbackList.length.toString()})',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color:
                      Get.isDarkMode
                          ? onClocHintColorDark
                          : onClocHintColorLight,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(
                  OnClocRoutes.onClocFeedbackHomeScreen,
                  arguments: controller.ticket,
                );
              },
              child: Text(
                onClocLocale.lblViewAll,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color:
                      Get.isDarkMode
                          ? onClocHintColorDark
                          : onClocHintColorLight,
                ),
              ),
            ),
          ],
        ),
        12.height,
        ListView.builder(
          itemCount: controller.ticket.feedbackList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final ClientFeedback data = controller.ticket.feedbackList[index];
            return commonClientReviewView(data, theme);
          },
        ),
      ],
    ),
  );

  Widget descriptionAndTasksView() => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child:
            controller.selectedIndex.value == 0
                ? Text(
                  controller.ticket.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color:
                        Get.isDarkMode
                            ? onClocHintColorDark
                            : onClocHintColorLight,
                  ),
                )
                : Container(
                  decoration: BoxDecoration(
                    color:
                        Get.isDarkMode
                            ? servpalCardBgColorDark
                            : servpalCardBgColorLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.ticket.tasksList.isEmpty
                            ? Text(
                              onClocLocale.lblNoDataAvailable,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                color:
                                    Get.isDarkMode
                                        ? onClocHintColorDark
                                        : onClocHintColorLight,
                              ),
                            )
                            : Text(
                              '${controller.ticket.tasksList.length} ${onClocLocale.lblTasks}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color:
                                    Get.isDarkMode
                                        ? onClocHintColorDark
                                        : onClocHintColorLight,
                              ),
                            ),
                        10.height,
                        ListView.builder(
                          itemCount: controller.ticket.tasksList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final TicketTask data =
                                controller.ticket.tasksList[index];
                            return commonTicketTaskView(data, theme);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
      ),
      25.height,
      Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Text(
          onClocLocale.lblRelatedClients,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color:
                Get.isDarkMode
                    ? onClocTextColorSecondaryDark
                    : onClocTextColorSecondaryLight,
          ),
        ),
      ),
      15.height,
      HorizontalList(
        itemCount: controller.ticket.clientsList.length,
        padding: const EdgeInsets.only(left: 18, right: 12),
        itemBuilder: (context, index) {
          final ClientProfile data = controller.ticket.clientsList[index];
          return Padding(
            padding: const EdgeInsets.only(right: 7),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(
                  OnClocRoutes.onClocClientProfileScreen,
                  arguments: data,
                );
              },
              child: commonClientView(data, theme, 245),
            ),
          );
        },
      ),
    ],
  );

  Widget commonButtons(int index, String name) {
    return Expanded(
      child: Obx(
        () => InkWell(
          onTap: () {
            controller.updateSelection(index);
          },
          child: Container(
            height: 38,
            decoration: BoxDecoration(
              color:
                  index == controller.selectedIndex.value
                      ? servpalPrimaryColor
                      : Get.isDarkMode
                      ? servpalTertiaryColor
                      : servpalSecondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                name,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color:
                      index == controller.selectedIndex.value
                          ? onClocWhiteColor
                          : Get.isDarkMode
                          ? servpalTextColorLight
                          : servpalTextColorDark,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ticketDetailCard() => Padding(
    padding: const EdgeInsets.only(left: 0, right: 0),
    child: Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode 
        ? servpalSecondaryColorDark 
        : onClocWhiteColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Get.isDarkMode ? 
          servpalSecondaryColor : 
          onClocBorderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: onClocShadowColor.withValues(alpha: 0.09),
            offset: const Offset(0, 12),
            blurRadius: 30,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: '${controller.ticket.ticketCategory} >',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color:
                              Get.isDarkMode
                                  ? onClocHintColorDark
                                  : onClocHintColorLight,
                        ),
                        children: [
                          const WidgetSpan(child: SizedBox(width: 3)),
                          TextSpan(
                            text: '${controller.ticket.tasksList.length.toString()} tasks',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    6.height,
                    Text(
                      '${controller.ticket.ticketPriority} priority',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      color:
                        controller.ticket.ticketPriority == 'High'
                          ? onClocRedColor
                            : controller.ticket.ticketPriority ==
                              'Standard'
                            ? servpalSecondaryColor
                            : servpalTertiaryColor,
                      ),
                    ),
                    12.height,
                    Text(
                      controller.ticket.subject,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  onClocRepairIcon,
                  colorFilter: ColorFilter.mode(
                    Get.isDarkMode ? onClocWhiteColor : onClocBlueGreyColor,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
            23.height,
            onClocDottedLine(onClocDividerColor),
            23.height,
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        onClocLocale.lblStatus,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color:
                              Get.isDarkMode
                                  ? onClocHintColorDark
                                  : onClocHintColorLight,
                        ),
                      ),
                      10.height,
                      Text(
                        controller.ticket.ticketStatus ?? 'new',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  commonVerticalDivider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        onClocLocale.lblDuration,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color:
                              Get.isDarkMode
                                  ? onClocHintColorDark
                                  : onClocHintColorLight,
                        ),
                      ),
                      10.height,
                      Text(
                        '${controller.ticket.ticketAge.days.inDays} days',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  commonVerticalDivider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        onClocLocale.lblRating,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color:
                              Get.isDarkMode
                                  ? onClocHintColorDark
                                  : onClocHintColorLight,
                        ),
                      ),
                      10.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star,
                            color: onClocDarkYellowColor,
                            size: 18,
                          ),
                          2.width,
                          Text(
                            controller.ticket.ticketRating.toString(),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
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
      ),
    ),
  );
}
