import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:workshop/business_logic/auth/login/login_cubit.dart';
import 'package:workshop/presentation/screens/app_layout/app_layout.dart';
import 'package:workshop/presentation/widgets/default_text_form_field.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/constants.dart';
import '../../../data/data_provider/local/cache_helper.dart';
import '../register/register_screen.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          token = state.loginModel.accessToken!;
          CacheHelper.put(key: tokenKey, value: token).then((value) {
            showTopSnackBar(
                context, CustomSnackBar.success(message: 'Welcome Back !'));
          });


          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => AppLayout(),
              ),
                  (route) => false);
        }
      },
      builder: (context, state) {
        LoginCubit myCubit = LoginCubit.get(context);
        return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width / 30),
              child: Form(
                key: myCubit.loginKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size.height / 30),
                      child: Image.asset(
                        odcImagePng,
                        height: size.height / 11,
                        width: size.width / 1.5,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    Row(
                      children: const [
                        Text(
                          'Login',

                          style: TextStyle(fontSize: 40),
                        )

                      ],
                    ),
                    Padding( padding: EdgeInsets.only(top: size.height / 30),),

                    DefaultTextFormField(
                validation: (value) {
                  if (value.isEmpty) {
                    return 'Please Enter Your Email';
                  } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[com]")
                      .hasMatch(value)) {
                    return 'Please Enter Valid as example@gmail.com';
                  }
                },
                hintText: 'Email',
                controller: emailController, onChanged: (){},
              ),


                    SizedBox(
                      height: size.height / 30,
                    ),

                    DefaultTextFormField(
                      validation: (val) {
                        if (val.isEmpty) {
                          return 'Please Enter Your Password';
                        }
                      },
                      onChanged: () {},
                      isPasswordField: true,
                      hintText: 'Password',
                      controller: passwordController,
                      //  visibleText: signupCubit.visiblePassword,
                      //  onTap: () {
                      //   signupCubit.changePasswordVisibility();},
                      //   onChanged: (){},
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forget password?',
                              style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 20,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (myCubit.loginKey.currentState!.validate()) {
                          myCubit.login(
                              email: emailController.value.text.trim(),
                              password: passwordController.value.text.trim(),
                              loginError: (String msg) {
                                showTopSnackBar(
                                    context, CustomSnackBar.error(message: msg));
                              });
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppLayout(),
                              ),
                                  (route) => false);
                        }
                      },
                      child: const Text(
                        'Login',
                      ),
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Colors.deepOrange,
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: size.width / 50),
                          child: const Text('OR'),
                        ),
                        const Expanded(
                          child: Divider(
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    ElevatedButton(

                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ));
                      },
                      child: const Text(
                        'Register',

                      ),
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}















// class LoginScreen extends StatelessWidget {
//   LoginScreen({Key? key}) : super(key: key);
//
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<LoginCubit, LoginState>(
//       listener: (context, state) {
//         if (state is LoginSuccessState) {
//           flutterToast(msg: 'Logged in Successfully', color: Colors.green);
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const AppLayout(),
//               ),
//                   (route) => false);
//         }
//       },
//       builder: (context, state) {
//         LoginCubit loginCubit = LoginCubit.get(context);
//         return Scaffold(
//           body: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 5.w),
//             child: Form(
//               key: loginKey,
//               child: ListView(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 8.h),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         Text(
//                           'Orange',
//                           style: TextStyle(
//                             color: Colors.deepOrange,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           'Digital Center',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 5.h),
//                     child: Text(
//                       "Login",
//                       style: TextStyle(
//                         color: AppColors.primaryColor,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20.sp,
//                       ),
//                     ),
//                   ),
//                   DefaultTextFormField(
//                     validation: (value) {
//                       if (value.isEmpty) {
//                         return 'Please Enter Your Email';
//                       } else if (!RegExp(
//                               "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[com]")
//                           .hasMatch(value)) {
//                         return 'Please Enter Valid as example@gmail.com';
//                       }
//                     },
//                     onChanged: () {},
//                     hintText: 'Email',
//                     isObscureText: false,
//                     controller: emailController,
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   DefaultTextFormField(
//                     validation: (value) {
//                       if (value.isEmpty) {
//                         return 'Please Enter Your Password';
//                       }
//                     },
//                     onChanged: () {},
//                     isPasswordField: true,
//                     hintText: 'Password',
//                     controller: passwordController,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 3.h),
//                     child: Text(
//                       "Forget Password?",
//                       style: TextStyle(
//                         color: AppColors.primaryColor,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 10.sp,
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (loginKey.currentState!.validate()) {
//                         loginCubit.postLogin(
//                           email: emailController.text,
//                           password: passwordController.text,
//                         );
//                       }
//                     },
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(
//                         AppColors.primaryColor,
//                       ),
//                     ),
//                     child: const Text('Login'),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 2.h),
//                     child: Row(
//                       children: [
//                         const Expanded(
//                             child: Divider(
//                           color: Colors.grey,
//                         )),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 1.w),
//                           child: const DefaultText(
//                               text: 'OR', textColor: Colors.grey),
//                         ),
//                         const Expanded(
//                             child: Divider(
//                           color: Colors.grey,
//                         )),
//                       ],
//                     ),
//                   ),
//                   OutlinedButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>  RegisterScreen(),
//                             ));
//                       },
//                       style: OutlinedButton.styleFrom(
//                         primary: AppColors.primaryColor,
//                         side: const BorderSide(color: AppColors.primaryColor),
//                       ),
//                       child: const Text('Register')),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
