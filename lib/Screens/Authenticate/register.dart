import 'package:fire/Services/auth.dart';
import 'package:fire/Shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Shared/constant.dart';

class Register extends StatefulWidget {
  final Function view;
  Register({required this.view});
  //const Register({Key? key, required this.view}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.brown[400],
              title: Text('Register Brew Crew'),
              centerTitle: true,
              actions: [
                FlatButton.icon(
                    onPressed: () {
                      widget.view();
                    },
                    icon: Icon(Icons.login),
                    label: Text('login'))
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          validator: (val) => val!.length < 6
                              ? 'Enter a password 6+ characters long'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FlatButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);
                              if (result == null) {
                                setState(() {
                                  error = 'Enter valid email';
                                  loading = false;
                                });
                              }
                            }
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.brown,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          error,
                          style: TextStyle(fontSize: 14, color: Colors.red),
                        )
                      ],
                    ))),
          );
  }
}
