import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/work/work_visit_controller.dart';
import 'package:on_cloc_mobile/app/models/client/client_profile.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';
import 'package:on_cloc_mobile/widgets/common_button.dart';

class OnClocWorkVisitScreen extends StatefulWidget {
  const OnClocWorkVisitScreen({super.key});

  @override
  State<OnClocWorkVisitScreen> createState() => OnClocWorkVisitScreenState();
}

class OnClocWorkVisitScreenState extends State<OnClocWorkVisitScreen> {
  OnClocWorkVisitController controller = OnClocWorkVisitController();

  final ImagePicker _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  File? file;
  String fileName = '', filePath = '';

  final _clientCont = TextEditingController();
  final _clientNode = FocusNode();

  final _remarksCont = TextEditingController();
  final _remarksNode = FocusNode();
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    init();
    theme = Get.isDarkMode ? OnClocTheme.darkTheme : OnClocTheme.lightTheme;
  }

  Future<void> init() async {
    controller.init();
  }

  Future pickFile() async {
    hideKeyboard(context);
    // Capture a photo
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 65,
    );
    if (photo != null) {
      filePath = photo.path;
      file = File(photo.path);
    }
    setState(() {});
  }

  void removeFile() {
    filePath = '';
    file = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => GetBuilder<OnClocWorkVisitController>(
    init: controller,
    tag: 'work_visit',
    builder:
        (controller) => Scaffold(
          appBar: onClocCommonAppBarWidget(
            context,
            titleText: onClocLocale.lblWorkVisitScreenTitle,
          ),
          body: Obx(
            () =>
                !controller.isLoading.value
                    ? !controller.isClientsExists.value
                        ? Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(onClocLocale.lblToMarkVisitsPleaseAddClient),
                              10.height,
                              OnClocCommonButton(
                                text: onClocLocale.lblAddClient,
                                onPressed:
                                    () => {}
                                    //     const AddClientScreen().launch(context),
                              ),
                            ],
                          ),
                        )
                        : SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _clientCont,
                                    focusNode: _clientNode,
                                    onTap: () async {
                                      hideKeyboard(context);
                                      var result = await showSearch(
                                        context: context,
                                        // delegate to customize the search bar
                                        delegate: ClientSearchDelegate(),
                                      );
                                      init();
                                      result as ClientProfile;
                                      controller.selectedClient.value = result;
                                      _clientCont.text = result.clientName;
                                    },
                                    style: primaryTextStyle(),
                                    decoration: newEditTextDecoration(
                                      Icons.people,
                                      controller.clientLabel.value,
                                    ),
                                    cursorColor:
                                        Get.isDarkMode ? white : blackColor,
                                  ),
                                  10.height,
                                  file != null
                                      ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Card(
                                            color: servpalPrimaryColor,
                                            elevation: 5,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Image.file(
                                                file!,
                                                height: 200,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Card(
                                                elevation: 5,
                                                shape: buildCardCorner(),
                                                color: servpalPrimaryColor,
                                                child: IconButton(
                                                  color: white,
                                                  onPressed: () {
                                                    pickFile();
                                                  },
                                                  icon: const Icon(
                                                    Icons.change_circle,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                elevation: 5,
                                                shape: buildRoundedCorner(
                                                  radius: 50,
                                                ),
                                                color: Colors.red,
                                                child: IconButton(
                                                  color: white,
                                                  onPressed: () {
                                                    removeFile();
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                      : Card(
                                        elevation: 2,
                                        shape: buildCardCorner(),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                onClocLocale.lblClickToAddImage,
                                                style: primaryTextStyle(
                                                  color: servpalPrimaryColor,
                                                ),
                                              ),
                                              Card(
                                                elevation: 5,
                                                shape: buildRoundedCorner(
                                                  radius: 50,
                                                ),
                                                color: servpalPrimaryColor,
                                                child: IconButton(
                                                  color: white,
                                                  onPressed: () {
                                                    pickFile();
                                                  },
                                                  icon: const Icon(
                                                    Icons.image,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ).onTap(() => pickFile()),
                                  10.height,
                                  TextFormField(
                                    controller: _remarksCont,
                                    focusNode: _remarksNode,
                                    style: primaryTextStyle(),
                                    decoration: newEditTextDecoration(
                                      Icons.receipt,
                                      onClocLocale.lblRemarks,
                                    ),
                                    cursorColor:
                                        Get.isDarkMode ? white : blackColor,
                                    keyboardType: TextInputType.name,
                                    validator: (s) {
                                      if (s!.trim().isEmpty) {
                                        return onClocLocale.lblCommentIsRequired;
                                      }
                                      return null;
                                    },
                                  ),
                                  10.height,
                                  OnClocCommonButton(
                                    text:  onClocLocale.lblSubmit,
                                    onPressed: () async {
                                      if (filePath.isEmptyOrNull) {
                                        toast(onClocLocale.lblImageIsRequired);
                                        return;
                                      }
                                      if (_formKey.currentState!.validate()) {
                                        var result = await controller.submit(
                                          filePath,
                                          _remarksCont.text,
                                          '0',
                                        );
                                        if (result) {
                                          toast(
                                            onClocLocale.lblSubmittedSuccessfully,
                                          );
                                          if (!context.mounted) return;
                                          finish(context);
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                    : loadingWidgetMaker(),
          ),
        ),
  );
}

class ClientSearchDelegate extends SearchDelegate {
  List<ClientProfile> resultList = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear).onTap(() => finish(context)),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: boxDecorationWithRoundedCorners(
        backgroundColor: context.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back, color: servpalPrimaryColor),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ClientProfile> listToShow = [];
    if (query.isNotEmpty) {
      loadData(query);
    } else {
      resultList = [];
    }
    listToShow = resultList;
    return ListView.builder(
      itemCount: listToShow.length,
      itemBuilder: (context, index) {
        var result = listToShow[index];
        //.onTap(() => {finish(context, result)})
        return InkWell(
          onTap: () => finish(context, result),
          child: ListTile(
            title: Text(result.clientName),
            trailing: Text(result.city!),
            subtitle: Text(result.phoneNumber!),
          ),
        );
      },
    );
  }

  void loadData(String query) async {
    var result = await onClocApiService.searchClients(query);
    resultList = result;
  }
}
