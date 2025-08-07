import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:on_cloc_mobile/app/models/ticket/service_ticket.dart';

class OnClocTicketHandlingController extends GetxController {
  late ServiceTicket ticket;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();
  final technicianRemarksController = TextEditingController(text: 'technician remarks here');

  final dateFocusNode = FocusNode();
  final addressFocusNode = FocusNode(); 
  final technicianRemarksFocusNode = FocusNode();

  RxInt currentStep = 0.obs;
  RxInt selectedButtonIndex = 0.obs;

  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  Rx<String> selectedTime = ''.obs;

  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime?> selectedDay = Rx<DateTime?>(null);

  List<String> steps = [];
  
  var addressController = TextEditingController(text: '7 spring close, off Fifth St, Kampala');
  var selectedPlace = '7 spring close, off Fifth St, Kampala'.obs;
    // Function to update selected place
  void updateSelectedPlace(String place) {
    selectedPlace.value = place;
  }

  @override
  void onInit() {
    super.onInit();
    final arguments = ModalRoute.of(Get.context!)?.settings.arguments ?? Get.arguments;
    if(arguments is ServiceTicket)
    {
          ticket = arguments;
    }
    else if (arguments is Map) {
      ticket = arguments['data'] as ServiceTicket;
    } else {
      // Handle unexpected cases
      throw Exception('invalid arguments passed to OnClocServiceTicketDetailsController');
    }

    // Initialize the steps for the ticket handling process
    getTicketSteps();

    // Update the dateController with the initial date and time
    selectedDate.value = DateTime.now();
    selectedTime.value = DateFormat('hh:mm a').format(DateTime.now());
    updateDateAndTime();
  }

  @override
  void onClose() {
    dateController.dispose();
    addressController.dispose();
    technicianRemarksController.dispose();
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

    dateController.text = formatDate(selectedDay); // Only set the date initially
    selectedDate.value = selectedDay; // Store the selected date
    update();
  }

  void updateDateAndTime() {
    // Set both date and time if time is selected
    if (selectedTime.value.isNotEmpty && selectedDate.value != null) {
      dateController.text = '${formatDate(selectedDate.value!)}, ${selectedTime.value}';
    } else if (selectedDate.value != null) {
      dateController.text = formatDate(selectedDate.value!); // Only show date if time is empty
    }
    update();
  }

  void removeDateFocus() {
    dateFocusNode.unfocus(); // Remove the focus
  }

  // Function to handle step changes
  void onStepContinue() {
    if (currentStep.value < steps.length - 1) {
      currentStep.value++;
    } else {
      // Handle completion of all steps
      Get.snackbar('Completed', 'All steps completed');
    }
  }

  void onStepCancel() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void onStepTapped(int step) {
    if (step >= 0 && step < steps.length) {
      currentStep.value = step;
    }
  }

  void onDateFieldTap() {
    dateFocusNode.requestFocus(); // Request focus for the date field
  }

  void onAddressFieldTap() {
    addressFocusNode.requestFocus(); // Request focus for the address field
  }

  void onDescriptionFieldTap() {
    technicianRemarksFocusNode.requestFocus(); // Request focus for the description field
  }

 Future<bool> handleTicketClose() async {
   // Implement your logic here
   return true;
 }

 void getTicketSteps() {
    // Return the list of steps for the ticket handling process
    int taskCount = ticket.tasksList.length;

    if (taskCount == 0) {
      steps.add('Task 1');
    }

    if (taskCount > 0) {
      for (var i = 0; i < ticket.tasksList.length; i++) {
        steps.add('Task ${i + 1}');
      }
    }

    steps.add('Finish');
    update();
  }

}