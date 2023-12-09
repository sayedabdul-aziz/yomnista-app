import 'package:borcelle_restaurant/core/functions/email_validate.dart';
import 'package:borcelle_restaurant/core/utils/app_colors.dart';
import 'package:borcelle_restaurant/core/utils/app_text_styles.dart';
import 'package:borcelle_restaurant/core/widgets/custom_button.dart';
import 'package:borcelle_restaurant/core/widgets/custom_error.dart';
import 'package:borcelle_restaurant/core/widgets/custom_loading.dart';
import 'package:borcelle_restaurant/feature/auth/presentation/view/forget_password.dart';
import 'package:borcelle_restaurant/feature/auth/presentation/view/register_view.dart';
import 'package:borcelle_restaurant/feature/auth/presentation/view_model/auth_cubit.dart';
import 'package:borcelle_restaurant/feature/auth/presentation/view_model/auth_states.dart';
import 'package:borcelle_restaurant/feature/customer/home/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
  });

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isVisable = true;
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          if (state.role == '0') {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const CustomerNavBarView(),
              ),
              (route) => false,
            );
          } else if (state.role == '1') {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const CustomerNavBarView(),
              ),
              (route) => false,
            );
          } else {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const CustomerNavBarView(),
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
      child: Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    'Welcome Back!',
                    style: getTitleStyle(fontSize: 32),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Email Address',
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
                  CheckboxListTile(
                    activeColor: AppColors.color1,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      'Remember Me',
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
                    height: 20,
                  ),
                  CustomButton(
                      text: 'Sign in',
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await context.read<AuthCubit>().login(
                              _emailController.text, _passwordController.text);
                        }
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ForgetPasswordView(),
                            ));
                          },
                          child: Text(
                            'Forget Password',
                            textAlign: TextAlign.center,
                            style: getbodyStyle(
                                    color: AppColors.color2,
                                    fontWeight: FontWeight.w600)
                                .copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.color2),
                          )),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t Have An Account?',
                        style: getbodyStyle(color: AppColors.color2),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const RegisterView(),
                            ));
                          },
                          child: Text(
                            'Sign Up',
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
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
