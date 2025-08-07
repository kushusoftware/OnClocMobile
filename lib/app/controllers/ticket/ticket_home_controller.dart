import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/models/api/requests/ticket_list_request.dart';
import 'package:on_cloc_mobile/app/models/base/select_list_item.dart';
import 'package:on_cloc_mobile/app/models/ticket/service_ticket.dart';
import 'package:on_cloc_mobile/app/models/ticket/ticket_category.dart';
import 'package:on_cloc_mobile/app/models/ticket/ticket_priority.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';

class OnClocTicketHomeController extends GetxController {
  var isLoading = false.obs;
  var serviceTicketsList = <ServiceTicket>[].obs;

  var selectedTicketCategory = Rxn<String>();
  var ticketCategoryList = <SelectListItem<TicketCategory>>[].obs;

  var selectedTicketPriority = Rxn<String>();
  var ticketPriorityList = <SelectListItem<TicketPriority>>[].obs;

  @override
  void onInit() {
    super.onInit();
    getTicketCategories();
    getTicketPriorities();
    getServiceTickets();
  }

  Future<List<ServiceTicket>> getServiceTickets() async {
    isLoading.value = true;
    // Fetch data from an API or database
    var ticketListRequest = TicketListRequest(
      serviceOfficerProfileId: getStringAsync(serviceOfficeProfileIdPref),
      filterStartDate: DateTime.now().subtract(Duration(days: 30)),
      filterEndDate: DateTime.now().add(Duration(days: 30)),
      );
    var serviceTickets = await onClocApiService.getServiceTickets(ticketListRequest);
    if (serviceTickets.isNotEmpty) {
      serviceTicketsList.clear();
      serviceTicketsList.value = serviceTickets.obs;
    }
    isLoading.value = false;
    return serviceTicketsList;
  }

  Future<int> getTicketCategories() async {
    isLoading.value = true;
    // Fetch data from an API or database
    var categories = await onClocApiService.getTicketCategories();
    if(categories.isNotEmpty){
      ticketCategoryList.clear();
      for (var category in categories)
      {
        ticketCategoryList.add(
          SelectListItem(
            category.ticketCategoryId,
            category.name,
            category,
            isSelected: false,
          ),
        );
      }
    }
    isLoading.value = false;
    return ticketCategoryList.length;
  }

  Future<int> getTicketPriorities() async {
    isLoading.value = true;
    // Fetch data from an API or database
    var priorities = await onClocApiService.getTicketPriorities();
    if(priorities.isNotEmpty){
      ticketPriorityList.clear();
      for (var priority in priorities)
      {
        ticketPriorityList.add(
          SelectListItem(
            priority.ticketPriorityId,
            priority.priorityLevel,
            priority,
            isSelected: false,
          ),
        );
      }
    }
    isLoading.value = false;
    return ticketPriorityList.length;
  }

  void updateSelectedTicketCategory(String? newValue) {
    if (newValue != null && newValue.isNotEmpty) {
      selectedTicketCategory.value = newValue;
    } else {
      selectedTicketCategory.value = null;
    }
    update();
  }

  void updateSelectedTicketPriority(String? newValue) {
    if (newValue != null && newValue.isNotEmpty) {
      selectedTicketPriority.value = newValue;
    } else {
      selectedTicketPriority.value = null;
    }
    update();
  }
}