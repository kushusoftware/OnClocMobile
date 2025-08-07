import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/ticket/ticket_handling_controller.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
//import 'package:on_cloc_mobile/utilities/routes.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';
import 'package:on_cloc_mobile/widgets/common_button.dart';
import 'package:on_cloc_mobile/widgets/form_fields.dart';
import 'package:on_cloc_mobile/widgets/view_widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class OnClocTicketHandlingScreen extends StatefulWidget {
  const OnClocTicketHandlingScreen({super.key});

  @override
  State<OnClocTicketHandlingScreen> createState() =>
      OnClocTicketHandlingScreenState();
}

class OnClocTicketHandlingScreenState
    extends State<OnClocTicketHandlingScreen> {
  final OnClocTicketHandlingController controller = Get.put(
    OnClocTicketHandlingController(),
  );
  late ThemeData theme;

  ScrollController listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    theme = Get.isDarkMode ? OnClocTheme.darkTheme : OnClocTheme.lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocTicketHandlingController>(
      init: controller,
      tag: 'ticket_handling',
      builder:
          (_) => Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: onClocCommonAppBarWidget(
              context,
              titleText: onClocLocale.lblHandleTicket,
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom:
                    GetPlatform.isIOS
                        ? MediaQuery.of(context).padding.bottom
                        : 20,
              ),
              child: Obx(() {
                return controller.currentStep.value == 0
                    ? OnClocCommonButton(
                      text: onClocLocale.lblNext,
                      onPressed: () {
                        controller.currentStep++;
                      },
                    )
                    : Row(
                      children: [
                        Expanded(
                          child: OnClocCommonButton(
                            text: onClocLocale.lblPrevious,
                            height: 56,
                            bgColor:
                                Get.isDarkMode
                                    ? servpalCardBgColorDark
                                    : servpalCardBgColorLight,
                            textColor:
                                Get.isDarkMode
                                    ? servpalTextColorDark
                                    : servpalTextColorLight,
                            onPressed: () {
                              controller.currentStep--;
                            },
                            fontSize: 17,
                          ),
                        ),
                        7.width,
                        Expanded(
                          child: OnClocCommonButton(
                            text: onClocLocale.lblCloseTicket,
                            onPressed: () {
                              confirmHandleTicketBottomSheet();
                            },
                          ),
                        ),
                      ],
                    );
              }),
            ),
            body: SingleChildScrollView(
              controller: listScrollController,
              child: Form(
                key: controller.formKey,
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      30.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:
                            controller.steps.asMap().entries.map((entry) {
                              int index = entry.key;
                              String step = entry.value;

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          //controller.currentStep.value = index;
                                          if (controller.currentStep.value ==
                                              0) {
                                            if (controller.formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              controller.currentStep.value++;
                                            } else {
                                              Get.snackbar(
                                                onClocLocale.lblError,
                                                onClocLocale
                                                    .lblFillAllRequiredFields,
                                                snackPosition:
                                                    SnackPosition.TOP,
                                                backgroundColor: Colors.red,
                                                colorText: Colors.white,
                                              );
                                            }
                                          } else if (controller
                                                  .currentStep
                                                  .value ==
                                              1) {
                                            return;
                                          }
                                        },
                                        child: Container(
                                          height: 48,
                                          width: 48,
                                          decoration: BoxDecoration(
                                            color:
                                                controller.currentStep.value >=
                                                        index
                                                    ? servpalPrimaryColor
                                                    : Get.isDarkMode
                                                    ? onClocHintColorLight
                                                    : onClocGreyColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Container(
                                              height: 24,
                                              width: 24,
                                              decoration: BoxDecoration(
                                                color:
                                                    controller
                                                                .currentStep
                                                                .value >=
                                                            index
                                                        ? onClocWhiteColor
                                                        : Colors.transparent,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color:
                                                      controller
                                                                  .currentStep
                                                                  .value >=
                                                              index
                                                          ? Colors.transparent
                                                          : Get.isDarkMode
                                                          ? onClocHintColorLight
                                                          : onClocGreyColor,
                                                  width: 1.5,
                                                ),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.check,
                                                  size: 15,
                                                  color:
                                                      controller
                                                                  .currentStep
                                                                  .value >=
                                                              index
                                                          ? servpalPrimaryColor
                                                          : Colors.transparent,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (index != controller.steps.length - 1)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                              15,
                                              (index) => Text(
                                                '-',
                                                style: TextStyle(
                                                  color:
                                                      controller
                                                                  .currentStep
                                                                  .value ==
                                                              1
                                                          ? onClocBlueGreyColor
                                                          : onClocHintColorLight,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 010,
                                      top: 07,
                                    ),
                                    child: Text(
                                      step,
                                      style: theme.textTheme.displayMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11,
                                            color:
                                                controller.currentStep.value >=
                                                        index
                                                    ? Get.isDarkMode
                                                        ? onClocWhiteColor
                                                        : onClocBlueGreyColor
                                                    : onClocHintColorLight,
                                          ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                      ),
                      25.height,
                      controller.currentStep.value !=
                              controller.steps.length - 1
                          ? Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  onClocLocale.lblTicketInformation,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                30.height,
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        Get.isDarkMode
                                            ? servpalCardBgColorDark
                                            : servpalCardBgColorLight,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        controller.ticket.tasksList.isNotEmpty
                                            ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                inputTitleText(
                                                  onClocLocale
                                                      .lblTechnicalRemarks,
                                                  theme,
                                                ),
                                                12.height,
                                                onClocCommonTextField(
                                                  theme,
                                                  () {},
                                                  controller
                                                          .ticket
                                                          .tasksList[controller
                                                              .currentStep
                                                              .value]
                                                          .technicalRemarks ??
                                                      '',
                                                  null,
                                                  null,
                                                  TextInputAction.next,
                                                  4,
                                                  controller
                                                      .technicianRemarksController,
                                                  controller
                                                      .technicianRemarksFocusNode,
                                                ),
                                                15.height,
                                              ],
                                            )
                                            : Center(
                                              child: Text(
                                                'No tasks available',
                                                style: theme
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          Get.isDarkMode
                                                              ? onClocWhiteColor
                                                              : onClocBlueGreyColor,
                                                    ),
                                              ),
                                            ),
                                        10.height,
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          : finalStepView(),
                      25.height,
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }

  void confirmHandleTicketBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.scaffoldBackgroundColor,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            decoration: BoxDecoration(
              color:
                  Get.isDarkMode ? onClocHintColorDark : onClocHintColorLight,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(35),
                topLeft: Radius.circular(35),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 18,
                right: 18,
                top: 18,
                bottom:
                    GetPlatform.isIOS
                        ? MediaQuery.of(context).padding.bottom
                        : 18,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  20.height,
                  Lottie.asset(
                    onClocSuccessfullyAnimation,
                    height: 100,
                    width: 100,
                  ),
                  30.height,
                  Text(
                    onClocLocale.lblConfirmCloseTicket,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  15.height,
                  Text(
                    onClocLocale.lblConfirmCloseTicketDescription,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      color:
                          Get.isDarkMode
                              ? onClocDividerColor
                              : onClocHintColorLight,
                    ),
                  ),
                  20.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 12,
                        backgroundColor: servpalPrimaryColor,
                        child: Center(
                          child: Icon(
                            Icons.check,
                            color: onClocWhiteColor,
                            size: 15,
                          ),
                        ),
                      ),
                      10.width,
                      Expanded(
                        child: Text(
                          onClocLocale.lblConfirmCloseTicketTerms,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color:
                                Get.isDarkMode
                                    ? onClocDividerColor
                                    : onClocHintColorLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  35.height,
                  Row(
                    children: [
                      Expanded(
                        child: OnClocCommonButton(
                          text: onClocLocale.lblCancel,
                          height: 56,
                          bgColor:
                              Get.isDarkMode
                                  ? onClocHintColorDark
                                  : onClocHintColorLight,
                          textColor:
                              Get.isDarkMode
                                  ? onClocWhiteColor
                                  : onClocBlueGreyColor,
                          onPressed: () {
                            Get.back();
                          },
                          fontSize: 17,
                        ),
                      ),
                      7.width,
                      Expanded(
                        child: OnClocCommonButton(
                          text: onClocLocale.lblConfirmCloseTicket,
                          onPressed: () {
                            controller.currentStep.value = 0;
                            controller.handleTicketClose().then((result) {
                              Get.back();
                            });
                            if (listScrollController.hasClients) {
                              final position =
                                  listScrollController.position.minScrollExtent;
                              listScrollController.animateTo(
                                position,
                                duration: const Duration(seconds: 2),
                                curve: Curves.easeOut,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget finalStepView() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          5.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: onClocPortalCachedImageWidget(
                  controller.ticket.clientsList[0].avatarUrl,
                  90,
                  width: 80,
                ),
              ),
              15.width,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.ticket.subject,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    7.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${onClocLocale.lblDate}:',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            color:
                                Get.isDarkMode
                                    ? onClocHintColorDark
                                    : onClocHintColorLight,
                          ),
                        ),
                        Obx(() {
                          return Text(
                            controller.selectedDate.value != null
                                ? controller.formatDate(
                                  controller.selectedDate.value!,
                                )
                                : 'No date selected',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        }),
                      ],
                    ),
                    7.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${onClocLocale.lblTime}:',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            color:
                                Get.isDarkMode
                                    ? onClocHintColorDark
                                    : onClocHintColorLight,
                          ),
                        ),
                        Text(
                          controller.selectedTime.value,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          20.height,
          commonHorizontalDivider(),
          20.height,
          Text(
            onClocLocale.lblServiceTicketDetails,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          20.height,
          Container(
            decoration: BoxDecoration(
              color: Get.isDarkMode ? onClocHintColorDark : onClocFillColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      leadingText(onClocLocale.lblTicket, theme),
                      trailingText(
                        controller.ticket.number,
                        Get.isDarkMode ? onClocWhiteColor : onClocBlueGreyColor,
                        theme,
                      ),
                    ],
                  ),
                  15.height,
                  onClocDottedLine(
                    Get.isDarkMode ? onClocHintColorDark : onClocDividerColor,
                  ),
                  15.height,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          controller.ticket.description,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  15.height,
                  onClocDottedLine(
                    Get.isDarkMode ? onClocHintColorDark : onClocDividerColor,
                  ),
                  15.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      leadingText(onClocLocale.lblTasks, theme),
                      Obx(
                        () => trailingText(
                          controller.ticket.tasksList.length.toString(),
                          Get.isDarkMode
                              ? onClocHintColorDark
                              : onClocHintColorLight,
                          theme,
                        ),
                      ),
                    ],
                  ),
                  15.height,
                  Row(
                    children: [
                      controller.ticket.tasksList.isNotEmpty
                          ? Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.ticket.tasksList.length,
                              itemBuilder: (context, index) {
                                final task = controller.ticket.tasksList[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        task.taskInstructions,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Get.isDarkMode
                                                      ? onClocWhiteColor
                                                      : onClocBlueGreyColor,
                                            ),
                                      ),
                                      5.height,
                                      Text(
                                        task.technicalRemarks ?? '',
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  Get.isDarkMode
                                                      ? onClocHintColorDark
                                                      : onClocHintColorLight,
                                            ),
                                      ),
                                      5.height,
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                          : Text(
                            onClocLocale.lblNoDataAvailable,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color:
                                  Get.isDarkMode
                                      ? onClocHintColorDark
                                      : onClocHintColorLight,
                            ),
                          ),
                    ],
                  ),
                  15.height,
                  onClocDottedLine(
                    Get.isDarkMode ? onClocHintColorDark : onClocDividerColor,
                  ),
                  15.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          onClocLocale.lblTechnicalRemarks,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color:
                                Get.isDarkMode
                                    ? onClocHintColorDark
                                    : onClocHintColorLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  15.height,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          controller.ticket.remarks ?? '',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color:
                                Get.isDarkMode
                                    ? servpalPrimaryColorDark
                                    : servpalPrimaryColorLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          20.height,
          Text(
            onClocLocale.lblClientFeedback,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          15.height,
          if (controller.ticket.feedbackList.isEmpty)
            Text(
              onClocLocale.lblNoClientFeedbackAvailable,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color:
                    Get.isDarkMode ? onClocHintColorDark : onClocHintColorLight,
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.ticket.feedbackList.length,
              itemBuilder: (context, index) {
                final feedback = controller.ticket.feedbackList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    feedback.comment,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color:
                          Get.isDarkMode
                              ? onClocHintColorDark
                              : onClocHintColorLight,
                    ),
                  ),
                );
              },
            ),
          10.height,
        ],
      ),
    );
  }

  void showDateSelectionBottomSheet(
    BuildContext context,
    OnClocTicketHandlingController controller,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.scaffoldBackgroundColor,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            decoration: BoxDecoration(
              color: Get.isDarkMode ? onClocHintColorDark : onClocWhiteColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(35),
                topLeft: Radius.circular(35),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          onClocLocale.lblDateAndTime,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(
                            onClocCloseSquareIcon,
                            colorFilter: ColorFilter.mode(
                              Get.isDarkMode
                                  ? onClocDividerColor
                                  : onClocHintColorLight,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                    25.height,
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color:
                            Get.isDarkMode
                                ? onClocHintColorDark
                                : onClocFillColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            // Date and Time Buttons
                            Expanded(
                              child: Obx(
                                () => OnClocCommonButton(
                                  height: 40,
                                  text: onClocLocale.lblDate,
                                  bgColor:
                                      0 == controller.selectedButtonIndex.value
                                          ? Get.isDarkMode
                                              ? onClocHintColorDark
                                              : onClocHintColorLight
                                          : Colors.transparent,
                                  textColor:
                                      0 == controller.selectedButtonIndex.value
                                          ? onClocWhiteColor
                                          : Get.isDarkMode
                                          ? servpalCardBgColorDark
                                          : onClocHintColorLight,
                                  // borderColor: 0 ==
                                  //         controller.selectedButtonIndex.value
                                  //     ? serviceDarkBlue
                                  //     : Colors.transparent,
                                  onPressed: () {
                                    controller.selection(0);
                                  },
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Obx(
                                () => OnClocCommonButton(
                                  height: 40,
                                  text: onClocLocale.lblTime,
                                  bgColor:
                                      1 == controller.selectedButtonIndex.value
                                          ? Get.isDarkMode
                                              ? onClocHintColorDark
                                              : onClocBlueGreyColor
                                          : Colors.transparent,
                                  textColor:
                                      1 == controller.selectedButtonIndex.value
                                          ? onClocWhiteColor
                                          : Get.isDarkMode
                                          ? servpalCardBgColorDark
                                          : onClocHintColorLight,
                                  onPressed: () async {
                                    Get.back(); // Close the bottom sheet before opening the time picker
                                    await _openTimePicker();
                                  },
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    25.height,
                    Obx(() {
                      return controller.selectedButtonIndex.value == 0
                          ? dateView()
                          : Container();
                    }),
                    7.height,
                    OnClocCommonButton(
                      text: onClocLocale.lblAccept,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget dateView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return TableCalendar(
            focusedDay: controller.focusedDay.value,
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            selectedDayPredicate: (day) {
              return isSameDay(controller.selectedDay.value, day);
            },
            calendarStyle: CalendarStyle(
              rangeHighlightColor: greenColor.withValues(alpha: 0.30),
              rangeStartDecoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.rectangle,
              ),
              rangeEndDecoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.rectangle,
              ),
              todayDecoration: const BoxDecoration(color: servpalPrimaryColor),
              selectedDecoration: const BoxDecoration(
                color: servpalPrimaryColor, // Change selected color
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              leftChevronIcon: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  border: Border.all(color: onClocHintColorLight, width: 1.5),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                      color:
                          Get.isDarkMode
                              ? servpalIconColorDark
                              : servpalIconColorLight,
                    ),
                  ),
                ),
              ),
              rightChevronIcon: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  border: Border.all(color: onClocHintColorLight, width: 1.5),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color:
                        Get.isDarkMode
                            ? servpalIconColorDark
                            : servpalIconColorLight,
                  ),
                ),
              ),
              titleCentered: true,
              headerPadding: const EdgeInsets.only(bottom: 15),
              titleTextStyle: theme.textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w700,
              ),
              formatButtonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              formatButtonShowsNext: false,
              formatButtonVisible: false,
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: theme.textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w500,
              ),
              weekendStyle: theme.textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                if (day.day >= 4 && day.day <= 10) {
                  // Green for dates 4 to 10
                  return Text(
                    '${day.day}',
                    style: theme.textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: onClocGreenColor,
                    ),
                  );
                } else {
                  // Pink for all other dates
                  return Text(
                    '${day.day}',
                    style: theme.textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }
              },
            ),
            onDaySelected: (selectedDay, focusedDay) {
              controller.setSelectedDay(selectedDay, focusedDay);
            },
          );
        }),
      ],
    );
  }

  Future<void> _openTimePicker() async {
    TimeOfDay? time = await getTime(context: context, title: '');

    if (time != null) {
      String formattedTime = time.format(Get.context!);
      controller.updateTime(formattedTime);
    } else {
      if (kDebugMode) {
        print('Time selection was canceled');
      }
    }
  }

  Future<TimeOfDay?> getTime({
    required BuildContext context,
    String? title,
    TimeOfDay? initialTime,
    String? cancelText,
    String? confirmText,
  }) async {
    TimeOfDay? time = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      cancelText: cancelText ?? 'Cancel',
      confirmText: confirmText ?? 'Save',
      helpText: title ?? '',
      builder: (context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor:
                  Get.isDarkMode ? onClocHintColorDark : onClocWhiteColor,
              dialTextColor: WidgetStateColor.resolveWith(
                (states) =>
                    states.contains(WidgetState.selected)
                        ? Get.isDarkMode
                            ? onClocDarkBlueColor
                            : onClocWhiteColor
                        : Get.isDarkMode
                        ? onClocWhiteColor
                        : onClocDarkBlueColor,
              ),
              hourMinuteTextColor: WidgetStateColor.resolveWith(
                (states) =>
                    states.contains(WidgetState.selected)
                        ? Get.isDarkMode
                            ? onClocDarkBlueColor
                            : onClocWhiteColor
                        : Get.isDarkMode
                        ? onClocWhiteColor
                        : onClocDarkBlueColor,
              ),
              hourMinuteColor: WidgetStateColor.resolveWith(
                (states) =>
                    states.contains(WidgetState.selected)
                        ? Get.isDarkMode
                            ? onClocWhiteColor
                            : onClocDarkBlueColor
                        : Colors.transparent,
              ),
              entryModeIconColor: Colors.transparent,
              dayPeriodTextColor: WidgetStateColor.resolveWith(
                (states) =>
                    states.contains(WidgetState.selected)
                        ? onClocWhiteColor
                        : onClocDarkBlueColor,
              ),
              dayPeriodColor: WidgetStateColor.resolveWith(
                (states) =>
                    states.contains(WidgetState.selected)
                        ? onClocDarkBlueColor
                        : Colors.grey.shade200,
              ),
              dialBackgroundColor: theme.scaffoldBackgroundColor,
              dialHandColor:
                  Get.isDarkMode ? onClocWhiteColor : onClocDarkBlueColor,
              dayPeriodTextStyle: const TextStyle(color: Colors.yellow),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: onClocWhiteColor,
                backgroundColor: onClocDarkBlueColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    return time;
  }
}
