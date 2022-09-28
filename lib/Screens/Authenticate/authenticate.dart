import 'package:fire/Screens/Authenticate/register.dart';
import 'package:fire/Screens/Authenticate/sign_in.dart';
import 'package:flutter/cupertino.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool signInShow = true;
  void toggleView() {
    setState(() => signInShow = !signInShow);
  }

  @override
  Widget build(BuildContext context) {
    if (signInShow) {
      return Sign_In(view: toggleView);
    } else {
      return Register(view: toggleView);
    }
  }
}
