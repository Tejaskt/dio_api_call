import 'package:flutter/material.dart';

import '../../core/routes/route_name.dart';
import '../../core/storage/secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool isUserLoggedIn(){
    final token = SecureStorage.getToken();
    if(token.toString() != ''){
      return true;
    }else{
      return false;
    }
  }

  @override
  void initState() {
    isUserLoggedIn()
        ?  Navigator.pushReplacementNamed(context, RoutesName.login)
        :  Navigator.pushReplacementNamed(context, RoutesName.home);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: const Text('Splash Screen')));
  }
}
