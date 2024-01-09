import 'dart:io';

import 'package:common/Common/string_constant.dart';
import 'package:common/local_notification/local_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../common_mixin_widgets/common_mixin_widget.dart';
import '../../network_connectivity /network_connectivity.dart';
import '../next_screen/next_screen.dart';
import 'home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with CommonWidgets {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final prov = Provider.of<HomeProvider>(context, listen: false);
    prov.get(context);
    prov.deviceToken();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<NetworkStatusService, HomeProvider>(
      builder: (context, value, value2, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: commonText(commonText: "Use Of Mixin"),
          ),
          body: Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: commonElevatedButton(
                  // context: context,
                  textFontSize: 20,
                  fontWeight: FontWeight.w500,
                  buttonText: "Next Screen",
                  buttonOnTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NextScreen()));
                  },
                ),
              ),
              commonText(
                  commonText:
                  'status :- ${value.connectionStatus} - ${value
                      .connectionValue}'),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 140,
                width: 140,
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.only(bottom: 2, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 1, color: Colors.deepPurple),
                  // shape: BoxShape.circle,
                  image: value2.picture.path.isNotEmpty
                      ? DecorationImage(
                      image: FileImage(File(value2.picture.path)))
                      : DecorationImage(
                    image: NetworkImage(value2.url),
                  ),
                ),
                child: InkWell(
                    onTap: () {
                      commonBottomSheetMethod(context, value2);
                    },
                    child: const Icon(CupertinoIcons.camera_fill)),
              ),
              const SizedBox(
                height: 20,
              ),
              commonTextFormField(context: context,
                  textFieldController: TextEditingController(),

                  validationRules: [
                    StringConstant.emailRegexPattern[0],
                    StringConstant.emailRegexPattern[1],
                    StringConstant.emailRegexPattern[2],
                    StringConstant.emailRegexPattern[3],
                    StringConstant.emailRegexPattern[4],
                    StringConstant.emailRegexPattern[5],
                    StringConstant.emailRegexPattern[6],
                  ]
              ),
              commonElevatedButton(buttonText: "error Dialog", buttonOnTap: () {
                commonConfirmationDialog(
                    context: context, onYes: () => Navigator.of(context).pop());
              }),
              commonElevatedButton(
                  buttonText: "Simple Notification", buttonOnTap: () {
                LocalNotifications.showSimpleNotification(
                    title: "Simple Notification",
                    body: "Added In Tray",
                    payload: "Loadmimvr.");
              })
            ],
          ),
        );
      },
    );
  }

  void commonBottomSheetMethod(BuildContext context, HomeProvider value2) {
    commonBottomSheet(
        context: context,
        widget: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.2,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  value2.requestPermissionsAndPickImage(
                      ImageSource.camera, context);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.purple,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.camera),
                      commonText(
                          commonText: "Pick From Camera.",
                          fontSize: 20,
                          textOnTapUse: false,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  value2.requestPermissionsAndPickImage(
                      ImageSource.gallery, context);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.purple,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.photo_library_outlined),
                      commonText(
                          commonText: "Pick From Gallery",
                          textOnTapUse: false,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
