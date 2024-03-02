import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_todo_c10_fri/auth/custom_text_form_field.dart';
import 'package:flutter_app_todo_c10_fri/dialog_utils.dart';
import 'package:flutter_app_todo_c10_fri/home/firebase_utils.dart';
import 'package:flutter_app_todo_c10_fri/home/home_screen.dart';
import 'package:flutter_app_todo_c10_fri/model/my_user.dart';
import 'package:flutter_app_todo_c10_fri/my_theme.dart';
import 'package:flutter_app_todo_c10_fri/providers/auth_providers.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController(text: 'Amira');

  TextEditingController emailController =
      TextEditingController(text: 'amira@route.com');

  TextEditingController passwordController =
      TextEditingController(text: '123456');

  TextEditingController confirmPasswordController =
      TextEditingController(text: '123456');

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
            title: Text('Create Account'),
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
                        CustomTextFormField(
                          label: 'User Name',
                          controller: nameController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter User Name';
                            }
                            return null;
                          },
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
                        CustomTextFormField(
                          label: 'Confirm Password',
                          keyboardType: TextInputType.number,
                          controller: confirmPasswordController,
                          obscureText: true,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter Confirm Password';
                            }
                            if (text != passwordController.text) {
                              return "Confirm Password doesn't match.";
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                              onPressed: () {
                                register();
                              },
                              child: Text(
                                'Create Account',
                                style: Theme.of(context).textTheme.titleLarge,
                              )),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == true) {
      // register
      // todo: show loading
      DialogUtils.showLoading(
          context: context, message: 'Loading...', isDismissible: false);
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? "",
            email: emailController.text,
            name: nameController.text);
        await FirebaseUtils.addUserToFireStore(myUser);
        var authProviders = Provider.of<AuthProviders>(context, listen: false);
        authProviders.updateUser(myUser);
        // todo: hide loading
        DialogUtils.hideLoading(context);
        // todo: show Message
        DialogUtils.showMessage(
            context: context,
            message: 'Register Successfully',
            title: 'Success',
            posActionName: 'Ok',
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
        print('register successfully');
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          // todo: hide loading
          DialogUtils.hideLoading(context);
          // todo: show Message
          DialogUtils.showMessage(
              context: context,
              posActionName: 'Ok',
              message: 'The password provided is too weak.',
              title: 'Error');
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          // todo: hide loading
          DialogUtils.hideLoading(context);
          // todo: show Message
          DialogUtils.showMessage(
              context: context,
              title: 'Error',
              posActionName: 'Ok',
              message: 'The account already exists for that email.');
          print('The account already exists for that email.');
        }
      } catch (e) {
        // todo: hide loading
        DialogUtils.hideLoading(context);
        // todo: show Message
        DialogUtils.showMessage(
            context: context,
            title: 'Error',
            posActionName: 'Ok',
            message: '${e.toString()}');
        print(e);
      }
    }
  }
}
