import 'package:common/network_connectivity%20/network_connectivity.dart';
import 'package:common/screens/home/home_provider.dart';
import 'package:common/screens/home/home_screen.dart';
import 'package:common/screens/users/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(create: (context) => HomeProvider(),),
        ChangeNotifierProvider<NetworkStatusService>(create: (context) => NetworkStatusService(),),
        ChangeNotifierProvider<UsersProvider>(create: (context) => UsersProvider(),),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

