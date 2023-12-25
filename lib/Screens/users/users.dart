import 'package:common/common_mixin_widgets/common_mixin_widget.dart';
import 'package:common/screens/users/users_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> with CommonWidgets {
  @override
  void initState() {
    final userProvider = Provider.of<UsersProvider>(context, listen: false);
    userProvider.doGetUsers(context);
    userProvider.pagination(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersProvider>(
      builder: (context, value, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: commonText(
                textOnTap: () {
                  // Get.to(()=> const UserProfileScreen());
                },
                commonText: 'Users Count ${value.user.length}'),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: value.scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: value.user.length,
                  padding: const EdgeInsets.only(top: 10),
                  itemBuilder: (context, index) {
                    final users = value.user[index];
                    if (index >= value.user.length) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          users['picture']['large'])),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                  )),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonText(
                                    fontSize: 20,
                                    textOverflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w500,
                                    commonText: users['name']['title'] +
                                        users['name']['first'] +
                                        users['name']['last']),
                                commonText(commonText: users['email'],
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                                commonText(commonText: users['dob']['date'],
                                  textOverflow: TextOverflow.ellipsis,

                                ),
                                commonText(commonText: users['phone'],
                                  textOverflow: TextOverflow.ellipsis,

                                ),
                                commonText(
                                    commonText: users['login']['username'],
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
