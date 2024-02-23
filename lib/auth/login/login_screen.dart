import 'package:flutter/material.dart';
import 'package:flutter_app_todo_c10_fri/auth/custom_text_form_field.dart';
import 'package:flutter_app_todo_c10_fri/my_theme.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: MyTheme.backgroundLightColor,
          child: Image.asset(
            'assets/images/main_background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Login'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Welcome Back!',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        CustomTextFormField(
                          label: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter Email';
                            }
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(text);
                            if (!emailValid) {
                              return 'Please enter valid email';
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          label: 'Password',
                          keyboardType: TextInputType.number,
                          controller: passwordController,
                          obscureText: true,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter Password';
                            }
                            if (text.length < 6) {
                              return 'Password should be at least 6 chars.';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                              onPressed: () {
                                login();
                              },
                              child: Text(
                                'Login',
                                style: Theme.of(context).textTheme.titleLarge,
                              )),
                        ),
                        TextButton(
                            onPressed: () {}, child: Text('OR Create Account'))
                      ],
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }

  void login() {
    if (formKey.currentState?.validate() == true) {
      // register
    }
  }
}
