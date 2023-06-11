import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:workshop/business_logic/auth/register/register_cubit.dart';
import 'package:workshop/presentation/screens/login/login_screen.dart';
import 'package:workshop/presentation/styles/app_colors.dart';
import 'package:workshop/presentation/widgets/default_text.dart';
import 'package:workshop/presentation/widgets/default_text_form_field.dart';


class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  List<DropdownMenuItem<String>> genderMenu = const [
    DropdownMenuItem(
      value: 'm',
      child: Text('Male'),
    ),
    DropdownMenuItem(
      value: 'f',
      child: Text('Female'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
   RegisterCubit signupCubit = RegisterCubit.get(context);
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width / 30),
              child: Form(
                key: signupCubit.signupKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size.height / 30),
                      child: Image.asset('assets/images/logo.png',
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
                          'Register',
                          style: TextStyle(fontSize: 35),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    DefaultTextFormField(
                      validation: (value) {
                        if (value.isEmpty) {
                          return "Please Enter Your Name";
                        } else if (value.length > 32) {
                          return "Name Must be less than 32 characters";
                        }
                        ;
                      },
                      hintText: 'Name',
                      controller: signupCubit.nameController,
                      onChanged: (){},
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
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
                      controller: signupCubit.emailController, onChanged: (){},
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
                    DefaultTextFormField(
                      validation: (val) {
                        if (val.isEmpty) {
                          return 'Please Enter Your Password';
                        }
                      },
                      onChanged: () {},
                      isPasswordField: true,
                      hintText: 'Confirm Password',
                      controller: passwordController,
                      //  visibleText: signupCubit.visiblePassword,
                      //  onTap: () {
                      //   signupCubit.changePasswordVisibility();},
                      //   onChanged: (){},
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                   DefaultTextFormField(
                      validation: (val) {
                        if (val == null) {
                          return "Please Enter Your Phone Number";
                        } else if (val.length != 11) {
                          return "Phone Number must be 11 number";
                        }
                      },
                    //  visibleText: signupCubit.visiblePassword,
                      hintText: 'Phone Number',
                      controller: signupCubit.phoneNumberController, onChanged: (){},
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(

                          width: size.width / 5,
                          padding: const EdgeInsets.only(left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey,

                              )),
                          child: DropdownButton(
                            alignment: Alignment.center,
                            underline: Container(
                              height: 1,
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            onChanged: (val) {
                              signupCubit.changeGender(val);
                            },
                            value: signupCubit.gender,
                            items: genderMenu,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    ElevatedButton(
                      onPressed: () {

                        if (signupCubit.signupKey.currentState!.validate()) {
                          if (signupCubit.passwordController.text !=
                              signupCubit.confirmPasswordController.text) {
                            Fluttertoast.showToast(
                                msg: 'Password doesn\'t Match',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }else {
                            signupCubit.postRegister(context);
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginScreen()));
                          }
                        }
                      },
                      child: const Text(
                        'Register',
                      ),
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: size.width / 50),
                          child: const Text('OR'),
                        ),
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Login',
                      ),
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}









// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({Key? key}) : super(key: key);
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   final TextEditingController nameController = TextEditingController();
//
//   final TextEditingController lastNameController = TextEditingController();
//
//   final TextEditingController emailController = TextEditingController();
//
//   final TextEditingController confirmPasswordController =
//       TextEditingController();
//
//   final TextEditingController passwordController = TextEditingController();
//
//   final TextEditingController phoneNumberController = TextEditingController();
//
//   final GlobalKey<FormState> registerKey = GlobalKey<FormState>();
//
//   List<DropdownMenuItem<String>> genderMenu = const [
//     DropdownMenuItem(
//       value: 'm',
//       child: Text('Male'),
//     ),
//     DropdownMenuItem(
//       value: 'f',
//       child: Text('Female'),
//     ),
//   ];
//   String gender = 'm';
//
//   void changeGender(val) {
//     gender = val;
//   }
//
//   var genderSelected = "Select gender";
//
//   @override
//   Widget build(BuildContext context) {
//     RegisterCubit registerCubit = RegisterCubit.get(context);
//     return BlocBuilder<RegisterCubit, RegisterState>(
//       builder: (context, state) {
//         return Scaffold(
//           body: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 5.w),
//             child: Form(
//               key: registerKey,
//               child: ListView(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 5.h),
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
//                       "Register",
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
//                         return 'Please Enter Your Name';
//                       } else if (value.length > 32) {
//                         return 'Name Must be less than 32 characters';
//                       }
//                     },
//                     onChanged: () {},
//                     hintText: 'Name',
//                     isObscureText: false,
//                     controller: nameController,
//                   ),
//                   SizedBox(
//                     height: 5.h,
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
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   DefaultTextFormField(
//                     validation: (value) {
//                       if (value.isEmpty) {
//                         return 'Please Enter Your Confirm Password';
//                       }
//                     },
//                     onChanged: () {},
//                     isPasswordField: true,
//                     hintText: 'Confirm Password',
//                     controller: confirmPasswordController,
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   DefaultTextFormField(
//                     validation: (value) {
//                       if (value.isEmpty) {
//                         return 'Please Enter Your Phone Number';
//                       } else if (value.length != 11) {
//                         return "Phone Number Must be 11 Number";
//                       }
//                     },
//                     onChanged: () {},
//                     hintText: 'Phone Number',
//                     isObscureText: false,
//                     controller: phoneNumberController,
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       DefaultText(
//                         text: 'Gender',
//                         fontSize: 15.sp,
//                       ),
//                       Container(
//                         height: 5.h,
//                         width: 50.w,
//                         padding: EdgeInsets.symmetric(horizontal: 5.w),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12.sp),
//                             border: Border.all(
//                                 color: Colors.deepOrange, width: 2.sp)),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton<String>(
//                             isExpanded: true,
//                             onChanged: (value) {
//                               registerCubit.changeGender(value);
//                             },
//                             value: registerCubit.gender,
//                             items: genderMenu,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (registerKey.currentState!.validate()) {
//                         registerCubit.postRegister(
//                             name: nameController.text,
//                             email: emailController.text,
//                             password: passwordController.text,
//                             phoneNumber: phoneNumberController.text,
//                             gender:
//                                 registerCubit.gender == 'male' ? 'm' : 'f');
//
//                       }
//                     },
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(
//                         AppColors.primaryColor,
//                       ),
//                     ),
//                     child: const Text('Register'),
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
//                         Navigator.pushAndRemoveUntil(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => LoginScreen(),
//                             ),
//                             (route) => false);
//                       },
//                       style: OutlinedButton.styleFrom(
//                         primary: AppColors.primaryColor,
//                         side: const BorderSide(color: AppColors.primaryColor),
//                       ),
//                       child: const Text('Login')),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
