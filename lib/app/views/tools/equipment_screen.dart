import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/controllers/tools/equipment_controller.dart';
import 'package:on_cloc_mobile/app/models/tools/equipment_model.dart';
import 'package:on_cloc_mobile/app/views/project/job_card_screen.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

class OnClocEquipmentScreen extends StatefulWidget {
  const OnClocEquipmentScreen({super.key});

  @override
  State<OnClocEquipmentScreen> createState() => OnClocEquipmentScreenState();
}

class OnClocEquipmentScreenState extends State<OnClocEquipmentScreen> {
  final OnClocEquipmentController equipmentController = Get.put(OnClocEquipmentController());
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme =
        Get.isDarkMode
            ? OnClocTheme.darkTheme
            : OnClocTheme.lightTheme;
    // Get Equipment from API or local JSON file
    equipmentController.getEquipment();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocEquipmentController>(
      init: equipmentController,
      tag: 'on_cloc_equipment',
      builder:
          (_) => Scaffold(
            appBar: onClocCommonAppBarWidget(
              context,
              leadingWidth: 0,
              leadingWidget: const Wrap(),
              isback: false,
              isTitleCenter: false,
              titleText: onClocLocale.lblEquipmentScreenTitle,
            ),
            backgroundColor: theme.scaffoldBackgroundColor,
            body: SafeArea(
              child: DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder:
                      (context, isScrolled) => [
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: StickyTabBarDelegate(
                            child: TabBar(
                              dividerColor: Colors.transparent,
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelStyle: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w300,
                                color:
                                    Get.isDarkMode
                                        ? servpalTextColorDark
                                        : servpalTextColorLight,
                              ),
                              labelColor: Colors.white,
                              indicator: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: servpalPrimaryColor,
                              ),
                              tabs: [
                                Tab(text: onClocLocale.lblEquipmentCustomer),
                                Tab(text: onClocLocale.lblEquipmentService),
                              ],
                            ),
                          ),
                        ),
                      ],
                  body: TabBarView(
                    children: [
                      buildCustomerEquipmentList(),
                      buildServiceEquipmentList(),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }

  Widget buildServiceEquipmentList() {
    return FutureBuilder<List<OnClocEquipment>>(
      future: equipmentController.getServiceEquipmentList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: servpalPrimaryColor),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return buildServiceEquipmentListView();
        } else {
          return Center(child: Text(onClocLocale.lblNoDataAvailable));
        }
      },
    );
  }

  Widget buildCustomerEquipmentList() {
    return FutureBuilder<List<OnClocEquipment>>(
      future: equipmentController.getCustomerEquipmentList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: servpalPrimaryColor),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return buildCustomerEquipmentListView();
        } else {
          return Center(child: Text(onClocLocale.lblNoDataAvailable));
        }
      },
    );
  }

  Widget buildServiceEquipmentListView() {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        itemCount: equipmentController.serviceEquipmentList.length,
        itemBuilder: (context, index) {
          final equipment = equipmentController.serviceEquipmentList[index];
          return ListTile(
            title: Text(equipment.name),
            subtitle: Text(equipment.description),
            trailing: Text('${equipment.count}'),
            onTap: () {
              // Handle tap event
            },
          );
        },
      ),
    );
  }

  Widget buildCustomerEquipmentListView() {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        itemCount: equipmentController.customerEquipmentList.length,
        itemBuilder: (context, index) {
          final equipment = equipmentController.customerEquipmentList[index];
          return ListTile(
            title: Text(equipment.name),
            subtitle: Text(equipment.description),
            trailing: Text('${equipment.count}'),
            onTap: () {
              // Handle tap event
            },
          );
        },
      ),
    );
  }
}
