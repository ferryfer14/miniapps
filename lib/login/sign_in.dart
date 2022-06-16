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

  Widget email() {
    return FormBuilderTextField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      key: _emailFieldKey,
      name: 'email',
      decoration: InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1),
        ),
        labelStyle: TextStyle(color: Colors.black87),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
        counterText: "",
      ),
      style: TextStyle(height: 1, color: Colors.black),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.email(),
      ]),
    );
  }

  Widget _password() {
    return FormBuilderTextField(
      name: 'password',
      decoration: InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1),
        ),
        labelStyle: TextStyle(color: Colors.black87),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
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
    );
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
                child: Text("Submit", style: TextStyle(fontSize: 18)),
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                            side: BorderSide(color: Colors.black)))),
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    if (true) {
                      setState(() {
                        loader = true;
                      });
                      Timer(Duration(seconds: 3), () {
                        Get.offNamed('/home');
                      });
                    }

                    debugPrint('Valid');
                  } else {
                    debugPrint('Invalid');
                  }
                  debugPrint(_formKey.currentState?.value.toString());
                }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      //Removing body:Center will change the reference
      // and render the widget at the start of the page
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
              child: FormBuilder(
                  key: _formKey,
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'LOGIN',
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                      const SizedBox(height: 50),
                      email(),
                      const SizedBox(height: 20),
                      _password(),
                      const SizedBox(height: 60),
                      button()
                    ],
                  )))),
    )));
  }
}
