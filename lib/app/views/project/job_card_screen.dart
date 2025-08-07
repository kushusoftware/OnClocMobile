import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/project/job_card_controller.dart';
import 'package:on_cloc_mobile/app/controllers/theme/theme_controller.dart';
import 'package:on_cloc_mobile/app/models/project/job_allocation.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/utilities/routes.dart';
import 'package:on_cloc_mobile/widgets/button_with_icon.dart';
import 'package:on_cloc_mobile/widgets/common_button.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

class OnClocJobCardScreen extends StatefulWidget {
  const OnClocJobCardScreen({super.key});

  @override
  OnClocJobCardScreenState createState() => OnClocJobCardScreenState();
}

class OnClocJobCardScreenState extends State<OnClocJobCardScreen> {
  OnClocJobCardController controller = Get.put(OnClocJobCardController());
  final OnClocThemeController themeController = Get.find<OnClocThemeController>();

  late ThemeData theme;

  final scollContoller = ScrollController();
  final appBarHeight = AppBar().preferredSize.height;
  final double horizontalPadding = 20.0;

  @override
  void initState() {
    super.initState();
    theme = Get.isDarkMode ? OnClocTheme.darkTheme : OnClocTheme.lightTheme;
  }

  @override
  Widget build(BuildContext context) => GetBuilder<OnClocJobCardController>(
    init: controller,
    tag: 'on_cloc_job_card',
    builder:
        (controller) => Scaffold(
          backgroundColor: themeController.isDarkMode
              ? servpalBgColorDark
              : servpalBgColorLight,
          appBar: onClocCommonAppBarWidget(
            context,
            leadingWidth: 0,
            leadingWidget: const Wrap(),
            isback: false,
            isTitleCenter: false,
            titleText: onClocLocale.lblJobCardScreenTitle,
            actionWidget: InkWell(
              onTap: () {
                Get.toNamed(OnClocRoutes.onClocJobCardCreateScreen);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: SvgPicture.asset(
                  onClocAddSquareIcon,
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
            ),
            actionWidget2: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (BuildContext context) {
                    return buildFilterBottomSheetItem();
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 20.0),
                child: SvgPicture.asset(
                  onClocFilterIcon,
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
            ),
          ),
          body: SafeArea(
            child: DefaultTabController(
              length: 4,
              child: NestedScrollView(
                headerSliverBuilder:
                    (context, isScrolled) => [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Obx(
                                    () => Expanded(
                                      child: _buildTopView(
                                        onClocLocale.lblOpenJobsTitle,
                                        controller.openJobCardsCount
                                            .toString(),
                                        Get.isDarkMode
                                            ? Colors.white
                                            : servpalPrimaryColor,
                                      ),
                                    ),
                                  ),
                                  10.width,
                                  Obx(
                                    () => Expanded(
                                      child: _buildTopView(
                                        onClocLocale.lblUpcomingJobsTitle,
                                        controller.upComingJobCardsCount
                                            .toString(),
                                        Get.isDarkMode
                                            ? Colors.white
                                            : servpalSecondaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              10.height,
                              Row(
                                children: [
                                  Obx(
                                    () => Expanded(
                                      child: _buildTopView(
                                        onClocLocale.lblOnHoldJobsTitle,
                                        controller.onHoldJobCardsCount
                                            .toString(),
                                        Get.isDarkMode
                                            ? Colors.white
                                            : servpalOptionalColor,
                                      ),
                                    ),
                                  ),

                                  10.width,
                                  Obx(
                                    () => Expanded(
                                      child: _buildTopView(
                                        onClocLocale.lblCompletedJobsTitle,
                                        controller.completedJobCardsCount
                                            .toString(),
                                        Get.isDarkMode
                                            ? Colors.white
                                            : servpalTertiaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              20.height,
                            ],
                          ),
                        ),
                      ),
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
                              Tab(
                                icon: FaIcon(FontAwesomeIcons.clipboardList),
                                text: onClocLocale.lblOpenJobsTitle,
                              ),
                              Tab(
                                icon: FaIcon(FontAwesomeIcons.clock),
                                text: onClocLocale.lblUpcomingJobsTitle,
                              ),
                              Tab(
                                icon: FaIcon(FontAwesomeIcons.pause),
                                text: onClocLocale.lblOnHoldJobsTitle,
                              ),
                              Tab(
                                icon: FaIcon(FontAwesomeIcons.checkDouble),
                                text: onClocLocale.lblCompletedJobsTitle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                body: TabBarView(
                  children: [
                    buildOpenJobCardList(),
                    buildUpComingJobCardList(),
                    buildOnHoldJobCardList(),
                    buildCompletedJobCardList(),
                  ],
                ),
              ),
            ),
          ),
        ),
  );

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
            // Service Desk
            20.height,
            Text(
              onClocLocale.lblServiceDeskTitle,
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
                    color:
                        controller.serviceDeskList.isEmpty
                            ? onClocGreyColor.withValues(alpha: 0.20)
                            : servpalPrimaryColor,
                  ),
                  color:
                      Get.isDarkMode
                          ? servpalPrimaryColorDark
                          : Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    isExpanded: true,
                    value: controller.selectedServiceDesk.value,
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
                      onClocLocale.lblSelectServiceDesk,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    items:
                        controller.serviceDeskList.map((deskItem) => DropdownMenuItem<String>(
                            value: deskItem.value.toString(),
                            child: Text(
                              deskItem.text,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                        ).toList(),
                    onChanged: (String? newValue) {
                      controller.updateSelectedServiceDesk(newValue);
                    },
                  ),
                ),
              ),
            ),
            // Job Type
            15.height,
            Text(
              onClocLocale.lblJobTypeTitle,
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
                    color:
                        controller.jobTypeList.isEmpty
                            ? onClocGreyColor.withValues(alpha: 0.20)
                            : servpalPrimaryColor,
                  ),
                  color:
                      Get.isDarkMode
                          ? servpalPrimaryColorDark
                          : Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    isExpanded: true,
                    value: controller.selectedJobType.value,
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
                      onClocLocale.lblSelectJobType,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    items:
                        controller.jobTypeList.map((typeItem) => DropdownMenuItem<String>(
                            value: typeItem.value.toString(),
                            child: Text(
                              typeItem.text,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                        ).toList(),
                    onChanged: (String? newValue) {
                      controller.updateSelectedJobType(newValue);
                    },
                  ),
                ),
              ),
            ),
            // Job Category
            15.height,
            Text(
              onClocLocale.lblJobCategoryTitle,
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
                    color:
                        controller.jobCategoryList.isEmpty
                            ? onClocGreyColor.withValues(alpha: 0.20)
                            : servpalPrimaryColor,
                  ),
                  color:
                      Get.isDarkMode
                          ? servpalPrimaryColorDark
                          : Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    isExpanded: true,
                    value: controller.selectedJobCategory.value,
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
                      onClocLocale.lblSelectJobCategory,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    items:
                        controller.jobCategoryList.map((categoryItem) => DropdownMenuItem<String>(
                            value: categoryItem.value.toString(),
                            child: Text(
                              categoryItem.text,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                        ).toList(),
                    onChanged: (String? newValue) {
                      controller.updateSelectedJobCategory(newValue);
                    },
                  ),
                ),
              ),
            ),
            // Job Class
            15.height,
            Text(
              onClocLocale.lblJobClassTitle,
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
                    color:
                        controller.jobClassList.isEmpty
                            ? onClocGreyColor.withValues(alpha: 0.20)
                            : servpalPrimaryColor,
                  ),
                  color:
                      Get.isDarkMode
                          ? servpalPrimaryColorDark
                          : Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    isExpanded: true,
                    value: controller.selectedJobClass.value,
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
                      onClocLocale.lblSelectJobClass,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    items:
                        controller.jobClassList.map((classItem) => DropdownMenuItem<String>(
                            value: classItem.value.toString(),
                            child: Text(
                              classItem.text,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                        ).toList(),
                    onChanged: (String? newValue) {
                      controller.updateSelectedJobClass(newValue);
                    },
                  ),
                ),
              ),
            ),
            // Job Group
            15.height,
            Text(
              onClocLocale.lblJobGroupTitle,
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
                    color:
                        controller.jobGroupList.isEmpty
                            ? onClocGreyColor.withValues(alpha: 0.20)
                            : servpalPrimaryColor,
                  ),
                  color:
                      Get.isDarkMode
                          ? servpalPrimaryColorDark
                          : Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    isExpanded: true,
                    value: controller.selectedJobGroup.value,
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
                      onClocLocale.lblSelectJobGroup,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    items:
                        controller.jobGroupList.map((groupItem) => DropdownMenuItem<String>(
                            value: groupItem.value.toString(),
                            child: Text(
                              groupItem.text,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                        ).toList(),
                    onChanged: (String? newValue) {
                      controller.updateSelectedJobGroup(newValue);
                    },
                  ),
                ),
              ),
            ),
            // Job Genre
            15.height,
            Text(
              onClocLocale.lblJobGenreTitle,
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
                    color:
                        controller.jobGenreList.isEmpty
                            ? onClocGreyColor.withValues(alpha: 0.20)
                            : servpalPrimaryColor,
                  ),
                  color:
                      Get.isDarkMode
                          ? servpalPrimaryColorDark
                          : Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    isExpanded: true,
                    value: controller.selectedJobGenre.value,
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
                      onClocLocale.lblSelectJobGenre,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    items:
                        controller.jobGenreList.map((genreItem) => DropdownMenuItem<String>(
                            value: genreItem.value.toString(),
                            child: Text(
                              genreItem.text,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                        ).toList(),
                    onChanged: (String? newValue) {
                      controller.updateSelectedJobGenre(newValue);
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
                    borderColor:
                        Get.isDarkMode
                            ? onClocGreyColor.withValues(alpha: 0.10)
                            : onClocGreyColor.withValues(alpha: 0.05),
                    onPressed: () {
                      for (int i = 0; i < controller.serviceDeskList.length; i++) {
                        controller.serviceDeskList[i].isSelected.value = false;
                      }
                      controller.selectedServiceDesk.value = null;
                      for (int i = 0; i < controller.jobTypeList.length; i++) {
                        controller.jobTypeList[i].isSelected.value = false;
                      }
                      controller.selectedJobType.value = null;
                      for (int i = 0; i < controller.jobCategoryList.length; i++) {
                        controller.jobCategoryList[i].isSelected.value = false;
                      }
                      controller.selectedJobCategory.value = null;
                      for (int i = 0; i < controller.jobClassList.length; i++) {
                        controller.jobClassList[i].isSelected.value = false;
                      }
                      controller.selectedJobClass.value = null;
                      for (int i = 0; i < controller.jobGroupList.length; i++) {
                        controller.jobGroupList[i].isSelected.value = false;
                      }
                      controller.selectedJobGroup.value = null;
                      for (int i = 0; i < controller.jobGenreList.length; i++) {
                        controller.jobGenreList[i].isSelected.value = false;
                      }
                      controller.selectedJobGenre.value = null;
                    },
                    textColor:
                        Get.isDarkMode
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

  Widget buildOpenJobCardList() {
    return FutureBuilder<List<JobAllocation>>(
      future: controller.getOpenJobCards(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: servpalPrimaryColor),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Obx(
            () =>
                controller.openJobCards.isEmpty
                    ? Center(child: Text(onClocLocale.lblNoDataAvailable))
                    : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.openJobCards.length,
                      itemBuilder: (context, index) {
                        JobAllocation data = controller.openJobCards[index];
                        return _buildRunningJobsView(data);
                      },
                    ),
          );
        }
      },
    );
  }

  Widget buildUpComingJobCardList() {
    return FutureBuilder<List<JobAllocation>>(
      future: controller.getUpComingJobCards(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: servpalPrimaryColor),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Obx(
            () =>
                controller.upComingJobCards.isEmpty
                    ? Center(child: Text(onClocLocale.lblNoDataAvailable))
                    : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.upComingJobCards.length,
                      itemBuilder: (context, index) {
                        JobAllocation data =
                            controller.upComingJobCards[index];
                        return _buildNoneRunningJobsView(data);
                      },
                    ),
          );
        }
      },
    );
  }

  Widget buildOnHoldJobCardList() {
    return FutureBuilder<List<JobAllocation>>(
      future: controller.getOnHoldJobCards(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: servpalPrimaryColor),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Obx(
            () =>
                controller.onHoldJobCards.isEmpty
                    ? Center(child: Text(onClocLocale.lblNoDataAvailable))
                    : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.onHoldJobCards.length,
                      itemBuilder: (context, index) {
                        JobAllocation data =
                            controller.onHoldJobCards[index];
                        return _buildNoneRunningJobsView(data);
                      },
                    ),
          );
        }
      },
    );
  }

  Widget buildCompletedJobCardList() {
    return FutureBuilder<List<JobAllocation>>(
      future: controller.getCompletedJobCards(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: servpalPrimaryColor),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Obx(
            () =>
                controller.completedJobCards.isEmpty
                    ? Center(child: Text(onClocLocale.lblNoDataAvailable))
                    : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.completedJobCards.length,
                      itemBuilder: (context, index) {
                        JobAllocation data =
                            controller.completedJobCards[index];
                        return _buildNoneRunningJobsView(data);
                      },
                    ),
          );
        }
      },
    );
  }

  Widget _buildRunningJobsView(JobAllocation data) {
    return InkWell(
      onTap: () {
        Get.toNamed(OnClocRoutes.onClocJobCardDetailScreen, arguments: data);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color:
              Get.isDarkMode
                  ? onClocGreyColor.withValues(alpha: 0.05)
                  : Colors.white,
          border: Border.all(
            color:
                Get.isDarkMode
                    ? onClocGreyColor.withValues(alpha: 0.10)
                    : Colors.white,
          ),
          boxShadow: [
            if (!Get.isDarkMode)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 110,
                offset: const Offset(0, 55),
              ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: onClocPortalCachedImageWidget(
                    data.clientAvatorUrl,
                    40,
                    width: 40,
                  ),
                ),
                10.width,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.subject,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      2.height,
                      Text(
                        '${onClocFormatter.format(data.scheduledDate)} - ${onClocFormatter.format(data.dueDate)}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: OnClocButtonWithIcon(
                    height: 40,
                    filter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    bgColor: servpalTertiaryColor,
                    onPressed: () {},
                    text: onClocLocale.lblReject,
                    iconName: onClocCloseSquareIcon,
                    borderRadius: 8,
                    textStyle: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
                10.width,
                Expanded(
                  child: OnClocButtonWithIcon(
                    height: 40,
                    filter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    bgColor: servpalOptionalColor,
                    onPressed: () {},
                    text: onClocLocale.lblAccept,
                    borderRadius: 8,
                    iconName: onClocTickCircleIcon,
                    textStyle: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoneRunningJobsView(JobAllocation data) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color:
            Get.isDarkMode
                ? onClocGreyColor.withValues(alpha: 0.05)
                : Colors.white,
        border: Border.all(
          color:
              Get.isDarkMode
                  ? onClocGreyColor.withValues(alpha: 0.10)
                  : Colors.white,
        ),
        boxShadow: [
          if (!Get.isDarkMode)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 110,
              offset: const Offset(0, 55),
            ),
        ],
      ),
      padding: const EdgeInsets.all(10),
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
                      'Date',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    2.height,
                    Text(
                      '${onClocFormatter.format(data.scheduledDate)} - ${onClocFormatter.format(data.dueDate)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:
                      (data.jobStatus == 'Completed')
                          ? servpalTertiaryColor.withValues(alpha: 0.05)
                          : servpalOptionalColor.withValues(alpha: 0.05),
                ),
                child: Text(
                  data.jobStatus,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color:
                        (data.jobStatus == 'Completed')
                            ? servpalTertiaryColor
                            : servpalOptionalColor,
                  ),
                ),
              ),
            ],
          ),
          10.height,
          Divider(color: onClocGreyColor.withValues(alpha: 0.10)),
          10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextView('Subject:', data.subject.toString()),
              _buildTextView('Priority:', data.priorityLevel.toString()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextView(String title, String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTopView(String title, String count, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            count,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({required this.child});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color:
            Get.isDarkMode
                ? servpalSecondaryColorDark
                : servpalSecondaryColorLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
