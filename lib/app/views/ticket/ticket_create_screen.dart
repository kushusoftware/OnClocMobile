import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/theme/theme_controller.dart';
import 'package:on_cloc_mobile/app/controllers/ticket/ticket_create_controller.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';
import 'package:on_cloc_mobile/widgets/common_button.dart';
import 'package:table_calendar/table_calendar.dart';

class OnClocTicketCreateScreen extends StatefulWidget {
  const OnClocTicketCreateScreen({super.key});

  @override
  State<OnClocTicketCreateScreen> createState() =>
      OnClocTicketCreateScreenState();
}

class OnClocTicketCreateScreenState extends State<OnClocTicketCreateScreen> {
  OnClocTicketCreateController controller = Get.put(
    OnClocTicketCreateController(),
  );
  final OnClocThemeController themeController = Get.put(
    OnClocThemeController(),
  );
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme = Get.isDarkMode ? OnClocTheme.darkTheme : OnClocTheme.lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocTicketCreateController>(
      init: controller,
      tag: 'ticket_create',
      builder: (controller) => Scaffold(
        backgroundColor: themeController.isDarkMode
            ? servpalBgColorDark
            : servpalBgColorLight,
        appBar: onClocCommonAppBarWidget(
          context,
          titleText: onClocLocale.lblCreateServiceTicket,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                20.height,
                // Select Client Dropdown
                Obx(
                  () => Container(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: controller.clientProfileList.isEmpty
                            ? onClocGreyColor.withValues(alpha: 0.20)
                            : servpalPrimaryColor,
                      ),
                      color: Get.isDarkMode
                          ? servpalPrimaryColorDark
                          : Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        isExpanded: true,
                        value: controller.selectedClientProfile.value,
                        icon: SvgPicture.asset(
                          onClocCaretDownIcon,
                          width: 8,
                          height: 8,
                          colorFilter: ColorFilter.mode(
                            Get.isDarkMode
                                ? servpalTextColorDark
                                : servpalTextColorLight,
                            BlendMode.srcIn,
                          ),
                        ),
                        hint: Text(
                          onClocLocale.lblSelectClientProfile,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        items: controller.clientProfileList
                            .map(
                              (deskItem) => DropdownMenuItem<String>(
                                value: deskItem.value.toString(),
                                child: Text(
                                  deskItem.text,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (String? newValue) {
                          controller.updateSelectedClientProfile(newValue);
                        },
                      ),
                    ),
                  ),
                ),
                10.height,
                // Select Category Dropdown
                Obx(
                  () => Container(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: controller.ticketCategoryList.isEmpty
                            ? onClocGreyColor.withValues(alpha: 0.20)
                            : servpalPrimaryColor,
                      ),
                      color: Get.isDarkMode
                          ? servpalPrimaryColorDark
                          : Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        isExpanded: true,
                        value: controller.selectedTicketCategory.value,
                        icon: SvgPicture.asset(
                          onClocCaretDownIcon,
                          width: 8,
                          height: 8,
                          colorFilter: ColorFilter.mode(
                            Get.isDarkMode
                                ? servpalTextColorDark
                                : servpalTextColorLight,
                            BlendMode.srcIn,
                          ),
                        ),
                        hint: Text(
                          onClocLocale.lblSelectTicketCategory,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        items: controller.ticketCategoryList
                            .map(
                              (deskItem) => DropdownMenuItem<String>(
                                value: deskItem.value.toString(),
                                child: Text(
                                  deskItem.text,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (String? newValue) {
                          controller.updateSelectedTicketCategory(newValue);
                        },
                      ),
                    ),
                  ),
                ),
                10.height,
                // Select Priority Dropdown
                Obx(
                  () => Container(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: controller.ticketPriorityList.isEmpty
                            ? onClocGreyColor.withValues(alpha: 0.20)
                            : servpalPrimaryColor,
                      ),
                      color: Get.isDarkMode
                          ? servpalPrimaryColorDark
                          : Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        isExpanded: true,
                        value: controller.selectedTicketPriority.value,
                        icon: SvgPicture.asset(
                          onClocCaretDownIcon,
                          width: 8,
                          height: 8,
                          colorFilter: ColorFilter.mode(
                            Get.isDarkMode
                                ? servpalTextColorDark
                                : servpalTextColorLight,
                            BlendMode.srcIn,
                          ),
                        ),
                        hint: Text(
                          onClocLocale.lblSelectTicketPriority,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        items: controller.ticketPriorityList
                            .map(
                              (deskItem) => DropdownMenuItem<String>(
                                value: deskItem.value.toString(),
                                child: Text(
                                  deskItem.text,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (String? newValue) {
                          controller.updateSelectedTicketPriority(newValue);
                        },
                      ),
                    ),
                  ),
                ),
                10.height,
                // Select Due Date and Time
                inputTitleText(onClocLocale.lblTicketInformation, theme),
                12.height,
                onClocCommonTextField(
                  onClocLocale.lblDueDateAndTime,
                  null,
                  onClocCalendarIcon,
                  TextInputType.datetime,
                  TextInputAction.next,
                  1,
                  controller.dueDateController,
                  controller.dueDateFocusNode,
                  (value) {
                    return controller.validateDueDate(value);
                  },
                  () {
                    showDateSelectionBottomSheet(context, controller);
                  },
                ),
                10.height,
                // Subject Field
                onClocCommonTextField(
                  onClocLocale.lblSubject,
                  null,
                  null,
                  TextInputType.text,
                  TextInputAction.next,
                  1,
                  controller.subjectController,
                  controller.subjectFocusNode,
                  (value) {
                    return controller.validateSubject(value);
                  },
                  () {},
                ),
                10.height,
                // Description Field
                onClocCommonTextField(
                  onClocLocale.lblDescription,
                  null,
                  null,
                  TextInputType.text,
                  TextInputAction.next,
                  2,
                  controller.descriptionController,
                  controller.descriptionFocusNode,
                  (value) {
                    return controller.validateDescription(value);
                  },
                  () {},
                ),
                10.height,
                // Task Field
                onClocCommonTextField(
                  onClocLocale.lblTaskInstruction,
                  null,
                  null,
                  TextInputType.text,
                  TextInputAction.next,
                  5,
                  controller.taskController,
                  controller.taskFocusNode,
                  (value) {
                    return controller.validateTask(value);
                  },
                  () {},
                ),
                20.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: OnClocCommonButton(
                        bgColor: onClocDarkBlueColor.withValues(alpha: 0.30),
                        borderColor: Get.isDarkMode
                            ? onClocGreyColor.withValues(alpha: 0.10)
                            : onClocGreyColor.withValues(alpha: 0.05),
                        onPressed: () => controller.clearForm(),
                        textColor: Get.isDarkMode
                            ? Colors.white
                            : servpalPrimaryColor,
                        text: onClocLocale.lblReset,
                      ),
                    ),
                    10.width,
                    Expanded(
                      child: OnClocCommonButton(
                        onPressed: () => controller.createServiceTicket(),
                        text: onClocLocale.lblSubmit,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget onClocCommonTextField(
    String hintText,
    suffixIcon,
    prefixIcon,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    int? maxLines,
    TextEditingController? controller,
    FocusNode? focusNode,
    String? Function(String?)? validator,
    void Function()? onTap,
  ) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      validator: validator,
      textAlign: TextAlign.left,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: Get.isDarkMode ? onClocDividerColor : onClocHintColorLight,
        ),
        fillColor: Get.isDarkMode ? onClocHintColorLight : onClocWhiteColor,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        suffixIcon: suffixIcon == null
            ? Container(width: 0)
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(suffixIcon),
              ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 10, // Adjust width
          minHeight: 0, // Adjust height
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 10, // Adjust width
          minHeight: 20, // Adjust height
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all(prefixIcon == null ? 0 : 15.0),
          child: prefixIcon == null
              ? const SizedBox(width: 0, height: 0)
              : SvgPicture.asset(
                  prefixIcon,
                  colorFilter: ColorFilter.mode(
                    Get.isDarkMode ? onClocWhiteColor : onClocDarkBlueColor,
                    BlendMode.srcIn,
                  ),
                ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: servpalPrimaryColor),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void showDateSelectionBottomSheet(
    BuildContext context,
    OnClocTicketCreateController controller,
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
              color: Get.isDarkMode
                  ? servpalCardBgColorDark
                  : servpalCardBgColorLight,
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
                        color: Get.isDarkMode
                            ? servpalTertiaryColor
                            : onClocWhiteColor,
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
                                  text: onClocLocale.lblDate,
                                  height: 40,
                                  bgColor:
                                      0 == controller.selectedButtonIndex.value
                                      ? Get.isDarkMode
                                            ? onClocHintColorDark
                                            : onClocDarkBlueColor
                                      : Colors.transparent,
                                  textColor:
                                      0 == controller.selectedButtonIndex.value
                                      ? onClocWhiteColor
                                      : Get.isDarkMode
                                      ? onClocHintColorDark
                                      : onClocHintColorLight,
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
                                  text: onClocLocale.lblTime,
                                  height: 40,
                                  bgColor:
                                      1 == controller.selectedButtonIndex.value
                                      ? Get.isDarkMode
                                            ? onClocHintColorDark
                                            : onClocDarkBlueColor
                                      : Colors.transparent,
                                  textColor:
                                      1 == controller.selectedButtonIndex.value
                                      ? onClocWhiteColor
                                      : Get.isDarkMode
                                      ? onClocHintColorDark
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
                      text: onClocLocale.lblDone,
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
            firstDay: DateTime.utc(DateTime.now().year - 1, 1, 1),
            lastDay: DateTime.utc(DateTime.now().year + 4, 12, 31),
            selectedDayPredicate: (day) {
              return isSameDay(controller.selectedDay.value, day);
            },
            calendarStyle: CalendarStyle(
              rangeHighlightColor: Colors.green.withValues(alpha: 0.30),
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
                      color: Get.isDarkMode
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
                    color: Get.isDarkMode
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
              backgroundColor: Get.isDarkMode
                  ? onClocHintColorDark
                  : onClocWhiteColor,
              dialTextColor: WidgetStateColor.resolveWith(
                (states) => states.contains(WidgetState.selected)
                    ? Get.isDarkMode
                          ? onClocDarkBlueColor
                          : onClocWhiteColor
                    : Get.isDarkMode
                    ? onClocWhiteColor
                    : onClocDarkBlueColor,
              ),
              hourMinuteTextColor: WidgetStateColor.resolveWith(
                (states) => states.contains(WidgetState.selected)
                    ? Get.isDarkMode
                          ? onClocDarkBlueColor
                          : onClocWhiteColor
                    : Get.isDarkMode
                    ? onClocWhiteColor
                    : onClocDarkBlueColor,
              ),
              hourMinuteColor: WidgetStateColor.resolveWith(
                (states) => states.contains(WidgetState.selected)
                    ? Get.isDarkMode
                          ? onClocWhiteColor
                          : onClocDarkBlueColor
                    : Colors.transparent,
              ),
              entryModeIconColor: Colors.transparent,
              dayPeriodTextColor: WidgetStateColor.resolveWith(
                (states) => states.contains(WidgetState.selected)
                    ? onClocWhiteColor
                    : onClocDarkBlueColor,
              ),
              dayPeriodColor: WidgetStateColor.resolveWith(
                (states) => states.contains(WidgetState.selected)
                    ? onClocDarkBlueColor
                    : Colors.grey.shade200,
              ),
              dialBackgroundColor: theme.scaffoldBackgroundColor,
              dialHandColor: Get.isDarkMode
                  ? onClocWhiteColor
                  : onClocDarkBlueColor,
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
