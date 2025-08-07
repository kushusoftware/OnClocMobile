import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/models/api/requests/dropdown_menu_request.dart';
import 'package:on_cloc_mobile/app/models/api/requests/job_allocation_request.dart';
import 'package:on_cloc_mobile/app/models/base/select_list_item.dart';
import 'package:on_cloc_mobile/app/models/project/job_allocation.dart';
import 'package:on_cloc_mobile/app/models/project/job_status.dart';
import 'package:on_cloc_mobile/app/models/project/job_category.dart';
import 'package:on_cloc_mobile/app/models/project/job_class.dart';
import 'package:on_cloc_mobile/app/models/project/job_genre.dart';
import 'package:on_cloc_mobile/app/models/project/job_group.dart';
import 'package:on_cloc_mobile/app/models/project/job_priority.dart';
import 'package:on_cloc_mobile/app/models/project/job_type.dart';
import 'package:on_cloc_mobile/app/models/technician/service_desk.dart';
import 'package:on_cloc_mobile/app/models/api/requests/service_desk_list_request.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';

class OnClocJobCardController extends GetxController {
  var isLoading = false.obs;

  var selectedServiceDesk = Rxn<String>();
  var serviceDeskList = <SelectListItem<ServiceDesk>>[].obs;

  var selectedJobType = Rxn<String>();
  var jobTypeList = <SelectListItem<JobType>>[].obs;

  var selectedJobCategory = Rxn<String>();
  var jobCategoryList = <SelectListItem<JobCategory>>[].obs;

  var selectedJobClass = Rxn<String>();
  var jobClassList = <SelectListItem<JobClass>>[].obs;

  var selectedJobGroup = Rxn<String>();
  var jobGroupList = <SelectListItem<JobGroup>>[].obs;

  var selectedJobGenre = Rxn<String>();
  var jobGenreList = <SelectListItem<JobGenre>>[].obs;

  var selectedJobAllocation = Rxn<String>();
  var jobAllocationList = <SelectListItem<JobAllocation>>[].obs;
  
  var jobStatusList = <SelectListItem<JobStatus>>[];
  var jobPriorityList = <SelectListItem<JobPriority>>[];
  
  var jobCardsList = <JobAllocation>[].obs;

  var openJobCardsCount = 0.obs;
  var upComingJobCardsCount = 0.obs;
  var onHoldJobCardsCount = 0.obs;
  var completedJobCardsCount = 0.obs;

  var openJobCards = <JobAllocation>[].obs;
  var upComingJobCards = <JobAllocation>[].obs;
  var onHoldJobCards = <JobAllocation>[].obs;
  var completedJobCards = <JobAllocation>[].obs;

  Position? position;

  @override
  void onInit() {
    super.onInit();
    getServiceDesks();
    getJobTypes();
    getJobCards();
  }

  Future<RxList<JobAllocation>> getOpenJobCards() async {
    openJobCards.clear();
    await Future.delayed(const Duration(seconds: 1));
    openJobCards = filterJobCardsByStatus('in-progress').obs;
    openJobCardsCount.value = openJobCards.length;
    return openJobCards;
  }

  Future<RxList<JobAllocation>> getUpComingJobCards() async {
    upComingJobCards.clear();
    await Future.delayed(const Duration(seconds: 1));
    upComingJobCards = filterJobCardsByStatus('new').obs;
    upComingJobCardsCount.value = upComingJobCards.length;
    return upComingJobCards;
  }

  Future<RxList<JobAllocation>> getOnHoldJobCards() async {
    onHoldJobCards.clear();
    await Future.delayed(const Duration(seconds: 1));
    onHoldJobCards = filterJobCardsByStatus('on-hold').obs;
    onHoldJobCardsCount.value = onHoldJobCards.length;
    return onHoldJobCards;
  }

  Future<RxList<JobAllocation>> getCompletedJobCards() async {
    completedJobCards.clear();
    await Future.delayed(const Duration(seconds: 1));
    completedJobCards = filterJobCardsByStatus('completed').obs;
    completedJobCardsCount.value = completedJobCards.length;
    return completedJobCards;
  }

  JobAllocation get runningJob =>
      jobCardsList.firstWhere((e) => e.isJobRunning == true);

  Future getJobCards() async {
    jobCardsList.clear();
    isLoading.value = true;
    var filterStartDate = DateTime.now().subtract(const Duration(days: 30));
    var filterEndDate = DateTime.now().add(const Duration(days: 30));
    var jobAllocationRequest = JobAllocationRequest(
        serviceOfficerProfileId: getStringAsync(serviceOfficeProfileIdPref),
        filterStartDate: filterStartDate,
        filterEndDate: filterEndDate,
    );
    // Fetch job cards from API or database
    var jobCards = await onClocApiService.getJobAllocation(jobAllocationRequest);
    if (jobCards.isNotEmpty) {
      for (var jobCard in jobCards) {
        jobCardsList.add(jobCard);
      }
    }

    // Filter job cards based on status
    if (jobCardsList.isEmpty) {
      toast(onClocLocale.lblNoJobCardsAvailable);
    } else {
      openJobCardsCount.value = filterJobCardsByStatus('in-progress').length;
      upComingJobCardsCount.value = filterJobCardsByStatus('new').length;
      onHoldJobCardsCount.value = filterJobCardsByStatus('on-hold').length;
      completedJobCardsCount.value = filterJobCardsByStatus('completed').length;
    }
    isLoading.value = false;
  }

  List<JobAllocation> filterJobCardsByStatus(String status) {
    return jobCardsList
        .where(
          (jobCard) => jobCard.jobStatus.toLowerCase() == status.toLowerCase(),
        )
        .toList();
  }

  Future<bool> startJob(String jobCardId) async {
    if (!mainStore.isCheckedIn) {
      toast(onClocLocale.lblCheckInFirst);
      return false;
    }
    isLoading.value = true;
    //Get location
    position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
    if (position == null) {
      isLoading.value = false;
      toast(onClocLocale.lblLocationNotEnabled);
      return false;
    }
    var result = await onClocApiService.startJob(
      jobCardId,
      position!.latitude,
      position!.longitude,
    );
    isLoading.value = false;
    getJobCards();
    return result;
  }

  Future<bool> holdJob() async {
    if (!mainStore.isCheckedIn) {
      toast(onClocLocale.lblCheckInFirst);
      return false;
    }
    isLoading.value = true;
    //Get location
    position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
    if (position == null) {
      isLoading.value = false;
      toast(onClocLocale.lblLocationNotEnabled);
      return false;
    }
    var result = await onClocApiService.holdJob(
      runningJob.jobCardId,
      position!.latitude,
      position!.longitude,
    );
    isLoading.value = false;
    getJobCards();
    return result;
  }

  Future<bool> resumeJob(String jobCardId) async {
    if (!mainStore.isCheckedIn) {
      toast(onClocLocale.lblCheckInFirst);
      return false;
    }
    isLoading.value = true;
    //Get location
    position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
    if (position == null) {
      isLoading.value = false;
      toast(onClocLocale.lblLocationNotEnabled);
      return false;
    }
    var result = await onClocApiService.resumeJob(
      jobCardId,
      position!.latitude,
      position!.longitude,
    );
    isLoading.value = false;
    getJobCards();
    return result;
  }

  Future<bool> completeJob() async {
    if (!mainStore.isCheckedIn) {
      toast(onClocLocale.lblCheckInFirst);
      return false;
    }
    isLoading.value = true;
    //Get location
    position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
    if (position == null) {
      isLoading.value = false;
      toast(onClocLocale.lblLocationNotEnabled);
      return false;
    }
    var result = await onClocApiService.completeJob(
      runningJob.jobCardId,
      position!.latitude,
      position!.longitude,
    );
    isLoading.value = false;
    getJobCards();
    return result;
  }
  
  void updateSelectedServiceDesk(String? newValue) {
    if (newValue != null) {
      selectedServiceDesk.value = newValue;
    } else {
      selectedServiceDesk.value = null;
    }
  }

  void updateSelectedJobType(String? newValue) {
    selectedJobType.value = newValue;
    if(!selectedJobType.value.isEmptyOrNull) 
    {
      selectedJobCategory.value = null;
      jobCategoryList.clear();
      selectedJobClass.value = null;
      jobClassList.clear();
      selectedJobGroup.value = null;
      jobGroupList.clear();
      selectedJobGenre.value = null;
      jobGenreList.clear();
      // Get job categories based on selected job type
      var dropdownMenuRequest = DropdownMenuRequest(
        menuId: selectedJobType.value!,
      );
      getJobCategories(dropdownMenuRequest);
    }
  }

  void updateSelectedJobCategory(String? newValue) {
    selectedJobCategory.value = newValue;
    if(!selectedJobCategory.value.isEmptyOrNull) 
    {
      selectedJobClass.value = null;
      jobClassList.clear();
      selectedJobGroup.value = null;
      jobGroupList.clear();
      selectedJobGenre.value = null;
      jobGenreList.clear();
      // Get job classes based on selected job category
      var dropdownMenuRequest = DropdownMenuRequest(
        menuId: selectedJobCategory.value!,
      );
      getJobClasses(dropdownMenuRequest);
    }
  }

  void updateSelectedJobClass(String? newValue) {
    selectedJobClass.value = newValue;
    if(!selectedJobClass.value.isEmptyOrNull) 
    {
      selectedJobGroup.value = null;
      jobGroupList.clear();
      selectedJobGenre.value = null;
      jobGenreList.clear();
      // Get job groups based on selected job class
      var dropdownMenuRequest = DropdownMenuRequest(
        menuId: selectedJobClass.value!,
      );
      getJobGroups(dropdownMenuRequest);
    }
  }

  void updateSelectedJobGroup(String? newValue) {
    selectedJobGroup.value = newValue;
    if(!selectedJobGroup.value.isEmptyOrNull) 
    {
      selectedJobGenre.value = null;
      jobGenreList.clear();
      // Get job genres based on selected job group
      var dropdownMenuRequest = DropdownMenuRequest(
        menuId: selectedJobGroup.value!,
      );
      getJobGenres(dropdownMenuRequest);
    }
  }

  void updateSelectedJobGenre(String? newValue) {
    if(newValue != null) {
      selectedJobGenre.value = newValue;
    } else {
      selectedJobGenre.value = null;
    } 
  }

  Future<int> getServiceDesks() async {
      var serviceDeskListRequest = ServiceDeskListRequest(
        serviceOfficerProfileId: getStringAsync(serviceOfficeProfileIdPref),
      );
      var serviceDesks = await onClocApiService.getServiceDesks(serviceDeskListRequest);
      if (serviceDesks.isNotEmpty) {
        serviceDeskList.clear();
        for(var desk in serviceDesks) {
          serviceDeskList.add(
            SelectListItem(
              desk.serviceDeskId,
              desk.name,
              desk,
              isSelected: false,
            ),
          );
        }
      }
      return serviceDesks.length;
  }

  Future<int> getJobCardStatus() async {
    var jobStatuses = await onClocApiService.getJobStatusList();
    if (jobStatuses.isNotEmpty) {
      jobStatusList.clear();
      for(var jobStatus in jobStatuses) {
        jobStatusList.add(
          SelectListItem(
            jobStatus.jobStatusId,
            jobStatus.status,
            jobStatus,
            isSelected: false,
          ),
        );
      }
    }
    return jobStatuses.length;
  }

  Future<int> getJobCardPriority() async {
    var jobPriorities = await onClocApiService.getJobPriorityList();
    if (jobPriorities.isNotEmpty) {
      jobPriorityList.clear();
      for(var jobPriority in jobPriorities) {
        jobPriorityList.add(
          SelectListItem(
            jobPriority.jobPriorityLevelId,
            jobPriority.priorityLevel,
            jobPriority,
            isSelected: false,
          ),
        );
      }
    }
    return jobPriorities.length;
  }

  Future<int> getJobTypes() async {
    var jobTypes = await onClocApiService.getJobTypeList();
    if (jobTypes.isNotEmpty) {
      jobTypeList.clear();
      for(var jobType in jobTypes) {
        jobTypeList.add(
          SelectListItem(
            jobType.jobTypeId,
            jobType.name,
            jobType,
            isSelected: false,
          ),
        );
      }
    }
    return jobTypes.length;
  }

  Future<int> getJobCategories(DropdownMenuRequest request) async {
    var jobCategories = await onClocApiService.getJobCategoryList(request);
    if (jobCategories.isNotEmpty) {
      jobCategoryList.clear();
      for(var jobCategory in jobCategories) {
        jobCategoryList.add(
          SelectListItem(
            jobCategory.jobCategoryId,
            jobCategory.name,
            jobCategory,
            isSelected: false,
          ),
        );
      }
    }
    return jobCategories.length;
  }

  Future<int> getJobClasses(DropdownMenuRequest request) async {
    var jobClasses = await onClocApiService.getJobClassList(request);
    if (jobClasses.isNotEmpty) {
      jobClassList.clear();
      for(var jobClass in jobClasses) {
        jobClassList.add(
          SelectListItem(
            jobClass.jobClassId,
            jobClass.name,
            jobClass,
            isSelected: false,
          ),
        );
      }
    }
    return jobClasses.length;
  }

  Future<int> getJobGroups(DropdownMenuRequest request) async {
    var jobGroups = await onClocApiService.getJobGroupList(request);
    if (jobGroups.isNotEmpty) {
      jobGroupList.clear();
      for(var jobGroup in jobGroups) {
        jobGroupList.add(
          SelectListItem(
            jobGroup.jobGroupId,
            jobGroup.name,
            jobGroup,
            isSelected: false,
          ),
        );
      }
    }
    return jobGroups.length;
  }

  Future<int> getJobGenres(DropdownMenuRequest request) async {
    var jobGenres = await onClocApiService.getJobGenreList(request);
    if (jobGenres.isNotEmpty) {
      jobGenreList.clear();
      for(var jobGenre in jobGenres) {
        jobGenreList.add(
          SelectListItem(
            jobGenre.jobGenreId,
            jobGenre.name,
            jobGenre,
            isSelected: false,
          ),
        );
      }
    }
    return jobGenres.length;
  }
}
