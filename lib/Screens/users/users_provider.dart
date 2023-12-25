import 'dart:convert';

import 'package:common/AuthRepository/auth_repository.dart';
import 'package:common/common_mixin_widgets/common_mixin_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';

class UsersProvider with ChangeNotifier, CommonWidgets {
  List user = [];
  int pageValue = 1;
  int resultValue = 10;
  String seed = '';
  ScrollController scrollController = ScrollController();
  AuthRepository authRepository = AuthRepository();

  pagination({BuildContext? context}) async {
    scrollController.addListener(() async {
      if ((scrollController.position.pixels ==
          scrollController.position.maxScrollExtent)) {
        pageValue = (pageValue) + 1;
        await doGetUsers(context!);
        print('pageValue:--->$pageValue');
        notifyListeners();
      }
    });
    notifyListeners();
  }
   doGetUsers(BuildContext context) async {
     // WidgetsBinding.instance?.addPostFrameCallback((_) {
       commonLoader(context);
     // });
    final result = await authRepository.getUserList(
      endPoint: 'api/?page=$pageValue&results=$resultValue&seed=$seed',
    );
    try {
      if (result.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(result.body);
        hideLoader();
        print('resultUsers:----> $responseBody');
        user.addAll(responseBody['results']);
        seed = responseBody['info']['seed'];
        print('SEED:--------> $seed');
        print('USER_LIST :---> $user');
      } else if (result.statusCode == 400) {
        hideLoader();
      }
      notifyListeners();
    } catch (e) {
      hideLoader();
    }
  }

}
