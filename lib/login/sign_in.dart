import 'dart:async';

import 'package:get/get.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignInPage extends StatefulWidget {
  @override
  State createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _globalKey = GlobalKey<ScaffoldMessengerState>();
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();
  bool _passwordVisible = false;
  bool loader = false;

  Widget username() {
    return Container(
        width: double.infinity,
        height: 50,
        child: FormBuilderTextField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          key: _emailFieldKey,
          name: 'username',
          decoration: InputDecoration(
            labelText: 'Email or Phone Number',
            labelStyle: TextStyle(color: Theme.of(context).hintColor),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(30),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(30),
            ),
            counterText: "",
          ),
          style: TextStyle(height: 1, color: Colors.black),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
        ));
  }

  Widget _password() {
    return Container(
        width: double.infinity,
        height: 50,
        child: FormBuilderTextField(
          name: 'password',
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(color: Theme.of(context).hintColor),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(30),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(30),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.black,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
            counterText: "",
          ),
          obscureText: !_passwordVisible, //This will obscure text dynamically
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.match("(?=.*[A-Z])",
                errorText: "Must be at least one upper case"),
            FormBuilderValidators.match("(?=.*[a-z])",
                errorText: "Must be at least one lower case"),
            FormBuilderValidators.minLength(6),
          ]),
        ));
  }

  Widget button() {
    return loader
        ? Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.black87,
              size: 40,
            ),
          )
        : Container(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
                child: Text("Login", style: TextStyle(fontSize: 14)),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: Theme.of(context).primaryColor)))),
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    if (true) {
                      var array = _formKey.currentState?.value;
                      if (array!['username'] == 'admin' &&
                          array['password'] == 'password') {
                        setState(() {
                          loader = true;
                        });
                        Timer(Duration(seconds: 3), () {
                          Get.offNamed('/home');
                        });
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Username dan Password Salah!'),
                        ));
                      }
                    }

                    debugPrint('Valid');
                  } else {
                    debugPrint('Invalid');
                  }
                  debugPrint(_formKey.currentState?.value.toString());
                }));
  }

  Widget forgot() {
    return Align(
        alignment: Alignment.centerRight,
        child: Material(
            color: Colors.white,
            child: InkWell(
                onTap: () {}, // Image tapped
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(children: <Widget>[
                  Positioned.fill(
                    child: Image.asset(
                      "assets/bg.png",
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.bottomLeft,
                    ),
                  ),
                  Center(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: SingleChildScrollView(
                              child: FormBuilder(
                                  key: _formKey,
                                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 125.0,
                                        width: 125.0,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          //set border radius to 50% of square height and width
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/coffee-bag.png"),
                                            fit: BoxFit
                                                .scaleDown, //change image fill type
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 50),
                                      username(),
                                      const SizedBox(height: 20),
                                      _password(),
                                      const SizedBox(height: 20),
                                      forgot(),
                                      const SizedBox(height: 20),
                                      button()
                                    ],
                                  ))))),
                ]))));
  }
}
