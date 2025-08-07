import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/profile/user_notification_controller.dart';
import 'package:on_cloc_mobile/app/models/profile/user_notification_model.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

class OnClocUserNotificationScreen extends StatefulWidget {
  const OnClocUserNotificationScreen({super.key});

  @override
  OnClocUserNotificationScreenState createState() =>
      OnClocUserNotificationScreenState();
}

class OnClocUserNotificationScreenState extends State<OnClocUserNotificationScreen> {
  OnClocUserNotificationController controller = Get.put(OnClocUserNotificationController());
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme =
        Get.isDarkMode
            ? OnClocTheme.darkTheme
            : OnClocTheme.lightTheme;
  }

  double horizontalPadding = 15.0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocUserNotificationController>(
      init: controller,
      tag: 'on_cloc_notification',
      builder:
          (_) => Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: onClocCommonAppBarWidget(
              context,
              titleText: onClocLocale.lblNotificationTitle,
            ),
            body: SafeArea(child: getNotificationList()),
          ),
    );
  }

  Widget getNotificationList() {
    return Center(
      child: FutureBuilder<List<OnClocUserNotification>>(
        future: controller.getNotificationList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(color: servpalPrimaryColor);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return controller.userNotificationList.isEmpty
                ? Text(onClocLocale.lblNoDataAvailable)
                : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: controller.userNotificationList.length,
                  // shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    OnClocUserNotification data =
                        controller.userNotificationList[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (data.notificationType == 'leave')
                                  ? ClipOval(
                                    child: onClocPortalCachedImageWidget(
                                      data.imageUrl!,
                                      42,
                                      width: 42,
                                    ),
                                  )
                                  : _buildIcon(data.notificationType),
                            ],
                          ),
                          title: Text(
                            data.title,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                data.message,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              2.height,
                              Text(
                                data.dateTime,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w300,
                                  color:
                                      Get.isDarkMode
                                          ? Colors.white
                                          : onClocGreyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Divider(
                            color: onClocGreyColor.withValues(alpha: 0.10),
                          ),
                        ),
                      ],
                    );
                  },
                );
          }
        },
      ),
    );
  }

  Widget _buildIcon(String notificationType) {
    return Container(
      width: 42,
      height: 42,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Get.isDarkMode 
          ? servpalSecondaryColor.withValues(alpha: 0.9)
          : servpalOptionalColor.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        getAssetIcon(notificationType),
        width: 20,
        height: 20,
        colorFilter: const ColorFilter.mode(
          servpalPrimaryColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  String getAssetIcon(String notificationType) {
    if (notificationType == 'updateProfile') {
      return onClocProfileIcon;
    } else if (notificationType == 'password') {
      return onClocLockIcon;
    } else if (notificationType == 'systemUpdate') {
      return onClocMobileIcon;
    }
    return '';
  }
}
