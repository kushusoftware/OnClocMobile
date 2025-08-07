import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/ticket/ticket_home_controller.dart';
import 'package:on_cloc_mobile/app/models/ticket/service_ticket.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/utilities/routes.dart';
import 'package:on_cloc_mobile/widgets/button_with_icon.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';
import 'package:on_cloc_mobile/widgets/common_button.dart';

class OnClocTicketHomeScreen extends StatefulWidget {
  const OnClocTicketHomeScreen({super.key});

  @override
  OnClocTicketHomeScreenState createState() => OnClocTicketHomeScreenState();
}

class OnClocTicketHomeScreenState extends State<OnClocTicketHomeScreen> {
  final OnClocTicketHomeController controller = Get.put(
    OnClocTicketHomeController(),
  );
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme = Get.isDarkMode ? OnClocTheme.darkTheme : OnClocTheme.lightTheme;
  }

  final scollContoller = ScrollController();
  final appBarHeight = AppBar().preferredSize.height;
  double horizontalPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocTicketHomeController>(
      init: controller,
      tag: 'ticket_home',
      builder: (_) => Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: onClocCommonAppBarWidget(
          context,
          leadingWidth: 0,
          leadingWidget: const Wrap(),
          isback: false,
          isTitleCenter: false,
          titleText: onClocLocale.lblServiceTicketScreenTitle,
          actionWidget: InkWell(
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: SvgPicture.asset(onClocFilterIcon),
            ),
            onTap: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (BuildContext context) {
                return buildFilterBottomSheetItem();
              },
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    boxShadow: [
                      if (!Get.isDarkMode)
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                    ],
                  ),
                  child: TextField(
                    decoration: onClocInputDecoration(
                      context,
                      prefixIcon: onClocSearchIcon,
                      prefixIconColor: Get.isDarkMode
                          ? servpalTextColorDark
                          : servpalTextColorLight,
                      hintText: onClocLocale.lblSearch,
                      borderRadius: 10,
                      hintColor: onClocGreyColor,
                      fillColor: Get.isDarkMode
                          ? onClocGreyColor.withValues(alpha: 0.05)
                          : Colors.white,
                      borderColor: Get.isDarkMode
                          ? onClocGreyColor.withValues(alpha: 0.10)
                          : Colors.transparent,
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                  ),
                ),
                20.height,
                getServiceTicketsList(),
                50.height,
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Visibility(
          visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
          child: Padding(
            padding: EdgeInsets.only(
              left: horizontalPadding,
              right: horizontalPadding,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: OnClocButtonWithIcon(
              iconName: onClocAddSquareIcon,
              text: onClocLocale.lblAddServiceTicket,
              bgColor: Get.isDarkMode
                  ? servpalSecondaryColor.withValues(alpha: 0.9)
                  : servpalSecondaryColor.withValues(alpha: 0.9),
              onPressed: () {
                Get.toNamed(OnClocRoutes.onClocTicketCreateScreen);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget getServiceTicketsList() {
    return FutureBuilder<List<ServiceTicket>>(
      future: controller.getServiceTickets(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: servpalPrimaryColor),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return buildServiceTicketListView();
        } else {
          return Center(child: Text(onClocLocale.lblNoDataAvailable));
        }
      },
    );
  }

  Widget buildServiceTicketListView() {
    return Obx(
      () => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        itemCount: controller.serviceTicketsList.length,
        itemBuilder: (context, index) {
          final ServiceTicket data = controller.serviceTicketsList[index];
          return GestureDetector(
            onTap: () => Navigator.of(
              context,
            ).pushNamed(OnClocRoutes.onClocTicketDetailScreen, arguments: data),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  iconColor: Get.isDarkMode
                      ? servpalTertiaryColor
                      : servpalPrimaryColor,
                  contentPadding: EdgeInsets.zero,
                  leading: ClipOval(
                    child: onClocPortalCachedImageWidget(
                      data.clientsList[0].avatarUrl,
                      44,
                      width: 44,
                    ),
                  ),
                  title: Text(
                    data.clientsList[0].clientName,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    data.subject,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w300,
                      color: Get.isDarkMode ? Colors.white : onClocGreyColor,
                    ),
                  ),
                  trailing: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Get.isDarkMode
                            ? servpalPrimaryColor
                            : Colors.white,
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                buildBottomSheetItem(
                                  onClocCallIcon,
                                  onClocLocale.lblCall,
                                  () {
                                    // Handle camera option
                                  },
                                  Get.isDarkMode
                                      ? Colors.white
                                      : servpalTextColorLight,
                                ),
                                buildBottomSheetItem(
                                  onClocTrashIcon,
                                  onClocLocale.lblDelete,
                                  () {
                                    // Handle gallery option
                                  },
                                  servpalTertiaryColor,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: SvgPicture.asset(
                      onClocMoreIcon,
                      colorFilter: ColorFilter.mode(
                        Get.isDarkMode
                            ? servpalTextColorDark
                            : servpalTextColorLight,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                if (!Get.isDarkMode)
                  Divider(color: onClocGreyColor.withValues(alpha: 0.10)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildBottomSheetItem(
    String icon,
    String text,
    VoidCallback onTap,
    Color color,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            12.width,
            Text(
              text,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w300,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilterBottomSheetItem() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Get.isDarkMode ? servpalPrimaryColor : Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  onClocLocale.lblFilter,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    onClocCloseSquareIcon,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Get.isDarkMode
                          ? servpalTextColorDark
                          : servpalTextColorLight,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
            // Ticket Catgory
            20.height,
            Text(
              onClocLocale.lblTicketCategoryTitle,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            10.height,
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
                          (item) => DropdownMenuItem<String>(
                            value: item.value.toString(),
                            child: Text(
                              item.text,
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
            // Ticket Priority
            15.height,
            Text(
              onClocLocale.lblTicketPriorityTitle,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            10.height,
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
                          (item) => DropdownMenuItem<String>(
                            value: item.value.toString(),
                            child: Text(
                              item.text,
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
            20.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: OnClocCommonButton(
                    bgColor: onClocGreyColor.withValues(alpha: 0.05),
                    borderColor: Get.isDarkMode
                        ? onClocGreyColor.withValues(alpha: 0.10)
                        : onClocGreyColor.withValues(alpha: 0.05),
                    onPressed: () {
                      for (
                        int i = 0;
                        i < controller.ticketCategoryList.length;
                        i++
                      ) {
                        controller.ticketCategoryList[i].isSelected.value =
                            false;
                      }
                      controller.selectedTicketCategory.value = null;
                      for (
                        int i = 0;
                        i < controller.ticketPriorityList.length;
                        i++
                      ) {
                        controller.ticketPriorityList[i].isSelected.value =
                            false;
                      }
                      controller.selectedTicketPriority.value = null;
                    },
                    textColor: Get.isDarkMode
                        ? Colors.white
                        : servpalPrimaryColor,
                    text: onClocLocale.lblReset,
                  ),
                ),
                10.width,
                Expanded(
                  child: OnClocCommonButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: onClocLocale.lblApply,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
