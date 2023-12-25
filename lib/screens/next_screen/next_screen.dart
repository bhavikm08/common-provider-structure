import 'dart:async';

import 'package:common/Common/extensions_methods.dart';
import 'package:common/common_mixin_widgets/common_mixin_widget.dart';
import 'package:common/network_connectivity%20/network_connectivity.dart';
import 'package:common/screens/users/users.dart';
import 'package:common/screens/videos/videos_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class NextScreen extends StatefulWidget {
  const NextScreen({super.key});

  @override
  State<NextScreen> createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> with CommonWidgets {
  String l1 = "capital letters";

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkStatusService>(
      builder: (context, value, child) {
        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: commonElevatedButton(
                  textFontSize: 20,
                  fontWeight: FontWeight.w500,
                  buttonText: "Common SnackBar",
                  buttonOnTap: () => commonSnackBar(
                      context: context,
                      message: "${l1.countTotalLengthOfString()}",
                      snackBarBehavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: commonElevatedButton(
                  textFontSize: 20,
                  fontWeight: FontWeight.w500,
                  buttonText: "Error Message",
                  buttonOnTap: () => commonToast(
                      errorMessage: "Toast", toastGravity: ToastGravity.BOTTOM),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: commonElevatedButton(
                  textFontSize: 20,
                  fontWeight: FontWeight.w500,
                  buttonText: "Error Dialog",
                  buttonOnTap: () => commonShowErrorDialog(
                      context: context,
                      message:
                          "Press Ok To Close jihvhernvnenrnvkanvnernvanvnjknenvmd,skakodjihvhernvnenrnvkanvnernvanvnjknenvmd,skakodskakodjihvhernvnenrnvkanvnernvanvnjknenvmd,skakodskakodjihvhernvnenrnvkanvnernvanvnjknenvmd,skakodskakodjihvhernvnenrnvkanvnernvanvnjknenvmd,skakodskakodjihvhernvnenrnvkanvnernvanvnjknenvmd,skakodskakodjihvhernvnenrnvkanvnernvanvnjknenvmd,skakodskakodjihvhernvnenrnvkanvnernvanvnjknenvmd,skakodskakodjihvhernvnenrnvkanvnernvanvnjknenvmd,skakodskakodjihvhernvnenrnvkanvnernvanvnjknenvmd,skakod."),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: commonElevatedButton(
                    textFontSize: 20,
                    fontWeight: FontWeight.w500,
                    buttonText: "Loader",
                    buttonOnTap: () async {
                      value.connectionValue == true
                          ? showLoader(context)
                          : null;
                      value.connectionValue == true
                          ? Timer(const Duration(seconds: 3), () {
                              hideLoader();
                            })
                          : null;
                    }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: commonElevatedButton(
                    textFontSize: 20,
                    fontWeight: FontWeight.w500,
                    buttonText: "Videos",
                    buttonOnTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const VideosView(),
                      ));
                    }),
              ),
              commonContainerButton(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const UsersView(),
                      )),
                  buttonText: 'press')
            ],
          ),
        );
      },
    );
  }
}
