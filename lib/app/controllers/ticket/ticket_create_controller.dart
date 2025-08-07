import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/models/api/requests/ticket_create_request.dart';
import 'package:on_cloc_mobile/app/models/base/select_list_item.dart';
import 'package:on_cloc_mobile/app/models/client/client_profile.dart';
import 'package:on_cloc_mobile/app/models/ticket/ticket_category.dart';
import 'package:on_cloc_mobile/app/models/ticket/ticket_priority.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';

class OnClocTicketCreateController extends GetxController {
  var isLoading = false.obs;

  var selectedClientProfile = Rxn<String>();
  var clientProfileList = <SelectListItem<ClientProfile>>[].obs;

  var selectedTicketCategory = Rxn<String>();
  var ticketCategoryList = <SelectListItem<TicketCategory>>[].obs;

  var selectedTicketPriority = Rxn<String>();
  var ticketPriorityList = <SelectListItem<TicketPriority>>[].obs;

  var dueDateController = TextEditingController();
  var subjectController = TextEditingController();
  var descriptionController = TextEditingController();
  var taskController = TextEditingController();

  final dueDateFocusNode = FocusNode();
  final subjectFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final taskFocusNode = FocusNode();

  var selectedDate = Rx<DateTime?>(null);
  var selectedTime = ''.obs;
  var selectedDay = Rx<DateTime?>(null);

  var focusedDay = DateTime.now().obs;

  var selectedButtonIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize the selected date and time
    selectedDate.value = DateTime.now();
    selectedTime.value = DateFormat('hh:mm a').format(DateTime.now());
    // Load dropdown lists
    loadClientProfiles();
    loadTicketCategories();
    loadTicketPriorities();
  }

  @override
  void onClose() {
    dueDateController.dispose();
    subjectController.dispose();
    descriptionController.dispose();
    taskController.dispose();
    super.onClose();
  }

  String formatDate(DateTime date) {
    return DateFormat('d MMMM yyyy').format(date);
  }

  String formatTime(String time) {
    return time; // Or modify if needed
  }

  void selection(int index) {
    selectedButtonIndex.value = index;
  }

  void updateTime(String time) {
    selectedTime.value = time;
    updateDateAndTime(); // Update the dateController whenever time changes
  }

  void setSelectedDay(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;

    dueDateController.text = formatDate(selectedDay); // Only set the date initially
    selectedDate.value = selectedDay; // Store the selected date
    update();
  }

  void updateDateAndTime() {
    // Set both date and time if time is selected
    if (selectedTime.value.isNotEmpty && selectedDate.value != null) {
      dueDateController.text = '${formatDate(selectedDate.value!)}, ${selectedTime.value}';
    } else if (selectedDate.value != null) {
      dueDateController.text = formatDate(selectedDate.value!); // Only show date if time is empty
    }
    update();
  }

  void removeDateFocus() {
    dueDateFocusNode.unfocus(); // Remove the focus
  }

  void updateSelectedClientProfile(String? newValue) {
    if (newValue != null) {
      selectedClientProfile.value = newValue;
    } else {
      selectedClientProfile.value = null;
    }
  }

  void updateSelectedTicketCategory(String? newValue) {
    if (newValue != null) {
      selectedTicketCategory.value = newValue;
    } else {
      selectedTicketCategory.value = null;
    }
  }

  void updateSelectedTicketPriority(String? newValue) {
    if (newValue != null) {
      selectedTicketPriority.value = newValue;
    } else {
      selectedTicketPriority.value = null;
    }
  }

  void clearForm() {
    subjectController.clear();
    descriptionController.clear();
    selectedTicketCategory.value = null;
    selectedTicketPriority.value = null;
  }

  Future<int> loadClientProfiles() async {
    isLoading.value = true;
    var clientProfiles = await onClocApiService.getClientProfiles();
    if (clientProfiles.isNotEmpty) {
      clientProfileList.clear();
      clientProfileList.value = clientProfiles
          .map((profile) => SelectListItem<ClientProfile>(
                profile.clientProfileId,
                profile.clientName,
                profile,
                isSelected: false,
              ))
          .toList();
    }
    isLoading.value = false;
    return clientProfiles.length;
  }

  Future<int> loadTicketCategories() async {
    isLoading.value = true;
    var ticketCategories = await onClocApiService.getTicketCategories();
    if (ticketCategories.isNotEmpty) {
      ticketCategoryList.clear();
      ticketCategoryList.value = ticketCategories
          .map((category) => SelectListItem<TicketCategory>(
                category.ticketCategoryId,
                category.name,
                category,
                isSelected: false,
              ))
          .toList();
    }
    isLoading.value = false;
    return ticketCategories.length;
  }

  Future<int> loadTicketPriorities() async {
    isLoading.value = true;
    var ticketPriorities = await onClocApiService.getTicketPriorities();
    if (ticketPriorities.isNotEmpty) {
      ticketPriorityList.clear();
      ticketPriorityList.value = ticketPriorities
          .map((priority) => SelectListItem<TicketPriority>(
                priority.ticketPriorityId,
                priority.priorityLevel,
                priority,
                isSelected: false,
              ))
          .toList();
    }
    isLoading.value = false;
    return ticketPriorities.length;
  }

  void createServiceTicket() async {
    DateTime dueDate = DateFormat('d MMMM yyyy, hh:mm a').parse(dueDateController.text.trim());
    var createTicketRequest = CreateTicketRequest(
      subject: subjectController.text.trim(), 
      description: descriptionController.text.trim(),
      taskInstruction: taskController.text.trim(),
      taskDueDateTime: dueDate,
      clientProfileId: selectedClientProfile.value != null 
          ? selectedClientProfile.value! 
          : getStringAsync(clientProfileIdPref),
      ticketCategoryId: selectedTicketCategory.value != null 
          ? int.parse(selectedTicketCategory.value!) 
          : 0, 
      ticketPriorityId: selectedTicketPriority.value != null 
          ? int.parse(selectedTicketPriority.value!) 
          : 0, 
      serviceOfficerProfileId: getStringAsync(serviceOfficeProfileIdPref),
    );
    var ticketCreated = await onClocApiService.createServiceTicket(createTicketRequest);
    if (ticketCreated == true) {
      toast(onClocLocale.lblTicketCreatedSuccessfully);
      clearForm();
      Get.back(); // Close the ticket creation screen
    } else {
      toast(onClocLocale.lblTicketCreationFailed);
    }
  }
  String? validateDueDate(String? value) {
    if (value == null || value.isEmpty) {
      return onClocLocale.lblThisFieldIsRequired;
    } else {
      try {
        DateTime.parse(value);
        return null; // Valid date
      } catch (e) {
        return onClocLocale.lblInvalidDateFormat; // Invalid date format
      }
    }
  }

  String? validateSubject(String? value) {
    if (value == null || value.isEmpty ) {
      return onClocLocale.lblThisFieldIsRequired;
    }
    else if (value.length < 5) {
      return onClocLocale.lblMustBeAtLeast5Characters;
    }
    else if (value.length > 20) {
      return onClocLocale.lblMustNotExceed20Characters;
    }
    else {
      return null;
    }
  }

  String? validateDescription(String? value) {
    if (value == null || value.isEmpty ) {
      return onClocLocale.lblThisFieldIsRequired;
    }
    else {
      return null;
    }
  }

  String? validateTask(String? value) {
    if (value == null || value.isEmpty ) {
      return onClocLocale.lblThisFieldIsRequired;
    }
    else {
      return null;
    }
  }
}