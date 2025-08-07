import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/project/job_card_detail_controller.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/widgets/button_with_icon.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

class OnClocJobCardDetailScreen extends StatefulWidget {
  const OnClocJobCardDetailScreen({super.key});

  @override
  State<OnClocJobCardDetailScreen> createState() => OnClocJobCardDetailScreenState();
}

class OnClocJobCardDetailScreenState extends State<OnClocJobCardDetailScreen> {
  final OnClocJobCardDetailController controller = Get.put(OnClocJobCardDetailController());
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    // Initialize any data or state here
    theme =
        Get.isDarkMode
            ? OnClocTheme.darkTheme
            : OnClocTheme.lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocJobCardDetailController>(
      init: controller,
      tag: 'on_cloc_job_card_details',
      builder:
          (controller) => Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: onClocCommonAppBarWidget(
              context,
              titleText: onClocLocale.lblJobCardDetails,
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 15,
                  bottom: GetPlatform.isIOS
                      ? MediaQuery.of(context).padding.bottom
                      : 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: OnClocButtonWithIcon(
                      filter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      bgColor: servpalTertiaryColor,
                      onPressed: () {},
                      text: onClocLocale.lblReject,
                      iconName: onClocCloseSquareIcon,
                      borderRadius: 8,
                      textStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400, color: Colors.white),
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: OnClocButtonWithIcon(
                      filter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      bgColor: servpalOptionalColor,
                      onPressed: () {},
                      text: onClocLocale.lblAccept,
                      borderRadius: 8,
                      iconName: onClocTickCircleIcon,
                      textStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Add your job card detail UI here
                    _buildCommonView(onClocLocale.lblJobNumber, controller.jobCard.jobCardId),
                    10.height,
                    _buildCommonView(onClocLocale.lblSubject, controller.jobCard.subject),
                    10.height,
                    _buildCommonView(onClocLocale.lblDescription, controller.jobCard.description!),
                    10.height,
                    _buildCommonView(onClocLocale.lblDate, onClocFormatter.format(controller.jobCard.scheduledDate)),
                    10.height,
                    _buildCommonView(onClocLocale.lblLocation, controller.jobCard.location!),
                    10.height,
                    _buildCommonView(onClocLocale.lblContactNumber, controller.jobCard.contactNumber),
                    10.height,
                    _buildCommonView(onClocLocale.lblStatus, controller.jobCard.jobStatus),
                    10.height,
                    _buildCommonView(onClocLocale.lblApprovedBy, controller.jobCard.approvedBy),
                    10.height,
                  ],
                ),
              ),
            ),
          ),
    );
  }

  
  Widget _buildCommonView(
    String title,
    String data,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w300,
              color: Get.isDarkMode ? Colors.white : onClocGreyColor),
        ),
        5.height,
        Text(
          data,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w300,
          ),
        ),
        8.height,
        Divider(
          color: onClocGreyColor.withValues(alpha: 0.10),
        ),
      ],
    );
  }
}
