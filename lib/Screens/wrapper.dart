import 'package:fire/Model/user.dart';
import 'package:fire/Screens/Authenticate/authenticate.dart';
import 'package:fire/Screens/Home/home.dart';
import 'package:fire/Screens/bottomNavigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Custom?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return BottonNavigation();
    }
  }
}
