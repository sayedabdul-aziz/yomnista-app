import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yomnista/core/functions/email_validate.dart';
import 'package:yomnista/core/services/local_storage.dart';
import 'package:yomnista/core/utils/app_colors.dart';
import 'package:yomnista/core/utils/app_text_styles.dart';
import 'package:yomnista/core/widgets/custom_button.dart';
import 'package:yomnista/core/widgets/custom_error.dart';
import 'package:yomnista/core/widgets/custom_loading.dart';
import 'package:yomnista/feature/admin/home/nav_bar.dart';
import 'package:yomnista/feature/auth/presentation/view/signin_view.dart';
import 'package:yomnista/feature/auth/presentation/view_model/auth_cubit.dart';
import 'package:yomnista/feature/auth/presentation/view_model/auth_states.dart';
import 'package:yomnista/feature/customer/home/nav_bar.dart';
import 'package:yomnista/feature/manager/home/nav_bar.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fName = TextEditingController();
  final TextEditingController _lName = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isVisable = true;
  bool isChecked = false;
  int roleIndex = 0;

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.scaffoldBG,
      statusBarIconBrightness: Brightness.dark,
    ));
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          if (state.role == '0') {
            AppLocal.cacheData(AppLocal.role, '0');
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const CustomerNavBarView(),
              ),
              (route) => false,
            );
          } else if (state.role == '1') {
            AppLocal.cacheData(AppLocal.role, '1');
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const ManagerNavBarView(),
              ),
              (route) => false,
            );
          } else {
            AppLocal.cacheData(AppLocal.role, '2');
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const AdminNavBarView(),
              ),
              (route) => false,
            );
          }
        } else if (state is AuthFailureState) {
          Navigator.of(context).pop();
          showErrorDialog(context, state.error);
        } else {
          showLoaderDialog(context);
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create an account',
                        style: getTitleStyle(fontSize: 32),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'First Name',
                        style: getbodyStyle(color: AppColors.color2),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _fName,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'First Name is required*';
                            } else {
                              return null;
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Last Name',
                        style: getbodyStyle(color: AppColors.color2),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _lName,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Last Name is required*';
                            } else {
                              return null;
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Username',
                        style: getbodyStyle(color: AppColors.color2),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _userName,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Username is required*';
                            } else {
                              return null;
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Email',
                        style: getbodyStyle(color: AppColors.color2),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is required*';
                          } else if (!emailValidate(value)) {
                            return 'Please enter the email correctly';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Password',
                        style: getbodyStyle(color: AppColors.color2),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        style: TextStyle(color: AppColors.black),
                        obscureText: isVisable,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisable = !isVisable;
                                });
                              },
                              icon: Icon((isVisable)
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.visibility_off_rounded)),
                        ),
                        controller: _passwordController,
                        validator: (value) {
                          if (value!.isEmpty) return 'Password is required*';
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'why use this app?',
                        style: getbodyStyle(color: AppColors.color2),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  roleIndex = 0;
                                });
                              },
                              child: Container(
                                height: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: roleIndex == 0
                                        ? AppColors.color1
                                        : AppColors.color3,
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  'Customer',
                                  style: getbodyStyle(
                                    color: roleIndex == 0
                                        ? AppColors.white
                                        : AppColors.color2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  roleIndex = 1;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                height: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: roleIndex == 1
                                        ? AppColors.color1
                                        : AppColors.color3,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  'Manager',
                                  style: getbodyStyle(
                                    color: roleIndex == 1
                                        ? AppColors.white
                                        : AppColors.color2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  roleIndex = 2;
                                });
                              },
                              child: Container(
                                height: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: roleIndex == 2
                                        ? AppColors.color1
                                        : AppColors.color3,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  'Admin',
                                  style: getbodyStyle(
                                    color: roleIndex == 2
                                        ? AppColors.white
                                        : AppColors.color2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      CheckboxListTile(
                        activeColor: AppColors.color1,
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          'I Agree With Privacy and Policy',
                          style: getbodyStyle(color: AppColors.color2),
                        ),
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          text: 'Sign Up',
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await context.read<AuthCubit>().register(
                                  _fName.text,
                                  _lName.text,
                                  _userName.text,
                                  _emailController.text,
                                  roleIndex,
                                  _passwordController.text);
                            }
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already Have An Account?',
                            style: getbodyStyle(color: AppColors.color2),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const LoginView(),
                                ));
                              },
                              child: Text(
                                'Sign in',
                                style: getbodyStyle(
                                        color: AppColors.color2,
                                        fontWeight: FontWeight.w600)
                                    .copyWith(
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppColors.color2),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Navigator.pop(context);
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: getbodyStyle(),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text(
        "Error!",
        style: getbodyStyle(),
      ),
      content: Text(
        "Email already Exists",
        style: getbodyStyle(),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
