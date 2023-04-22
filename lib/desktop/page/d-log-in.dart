// ignore_for_file: file_names, use_build_context_synchronously

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:p/constant/colorsize.dart';
import 'package:p/constant/responsive.dart';
import 'package:p/database/functions/auth.dart';
import 'package:p/desktop/components/album-component/snack-bar.dart';
import 'package:p/desktop/components/login-component/hover-account.dart';
import 'package:p/desktop/components/login-component/hover-text.dart';
import 'package:p/desktop/page/d-register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DLogin extends StatefulWidget {
  const DLogin({super.key});

  @override
  State<DLogin> createState() => _DLoginState();
}

class _DLoginState extends State<DLogin> {
  bool loading = false;
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .titleSmall!
        .copyWith(color: darkC, fontWeight: FontWeight.w500, fontSize: mediumT);
    return Scaffold(
        body: Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                color: Colors.white,
                elevation: 15,
                shadowColor: darkC.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 500,
                  width: 360,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'yorPortfolio',
                          style: style.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Welcome back!',
                            style:
                                style.copyWith(color: darkC.withOpacity(0.8))),
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          cursorColor: darkC,
                          style: style,
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a valid email Id.";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            constraints: const BoxConstraints(maxHeight: 40),
                            prefixIcon: SizedBox(
                              width: 30,
                              child: Center(
                                child: Icon(
                                  AntIcons.userOutlined,
                                  size: 17,
                                  color: darkC.withOpacity(0.7),
                                ),
                              ),
                            ),
                            labelText: 'email',
                            labelStyle: style,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(
                                  color: darkC.withOpacity(0.4),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(
                                  color: darkC.withOpacity(0.4),
                                )),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(
                                  color: Colors.red.withOpacity(0.4),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: true,
                          cursorColor: darkC,
                          style: style,
                          controller: passwordController,
                          validator: (value) {
                            if (value == null ||
                                value.length < 6 ||
                                value.isEmpty) {
                              return "Please enter a valid Password.";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            constraints: const BoxConstraints(maxHeight: 40),
                            prefixIcon: SizedBox(
                              width: 30,
                              child: Center(
                                child: Icon(
                                  AntIcons.keyOutlined,
                                  size: 17,
                                  color: darkC.withOpacity(0.7),
                                ),
                              ),
                            ),
                            labelText: 'Password',
                            labelStyle: style,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(
                                  color: darkC.withOpacity(0.4),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(
                                  color: darkC.withOpacity(0.4),
                                )),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                                borderSide: BorderSide(
                                  color: Colors.red.withOpacity(0.4),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () => logInFn(),
                          child: Material(
                            color: purpleC,
                            elevation: 15,
                            shadowColor: purpleC.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(7),
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: purpleC,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Center(
                                child: loading
                                    ? const SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        'Log in',
                                        style:
                                            style.copyWith(color: Colors.white),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            'or Continue with',
                            textAlign: TextAlign.center,
                            style:
                                style.copyWith(color: darkC.withOpacity(0.6)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HoverAccount(
                                icon: AntIcons.googleOutlined, pressed: () {}),
                            const SizedBox(
                              width: 20,
                            ),
                            HoverAccount(
                                icon: AntIcons.facebookFilled, pressed: () {}),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account  ",
                                style: style.copyWith(
                                    color: purpleC.withOpacity(0.8))),
                            HoverText(
                                text: 'Register Now',
                                pressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DRegister()));
                                })
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Copyright © 2023 yorPortfolio.com. All rights reserved',
                style:
                    style.copyWith(color: darkC.withOpacity(0.8), fontSize: 10),
              )
            ],
          ),
        ),
      ),
    ));
  }

  logInFn() async {
    // if (!formKey.currentState!.validate()) return;
    final email = emailController.value.text;
    final password = passwordController.value.text;

    setState(() => loading = true);

    try {
      await Auth().login(email, password).whenComplete(() async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("email", email);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Responsive()));
      });
    } catch (e) {
      showSnackBar(context, purpleC, e.toString());
    }

    setState(() => loading = false);
  }
}
