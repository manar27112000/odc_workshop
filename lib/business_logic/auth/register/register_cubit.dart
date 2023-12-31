import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:workshop/constants/constant_methods.dart';
import 'package:workshop/constants/end_points.dart';
import 'package:workshop/data/data_provider/remote/dio_helper.dart';
import 'package:workshop/presentation/screens/app_layout/app_layout.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  String gender = 'm';

  final GlobalKey<FormState> signupKey = GlobalKey<FormState>();

  bool visiblePassword = false;
  bool visibleConfirmPassword = false;

  // function to change visibility of password
  void changePasswordVisibility() {
    visiblePassword = !visiblePassword;
    emit(VisiblePasswordState());
  }

  void changeConfirmPasswordVisibility() {
    visibleConfirmPassword = !visibleConfirmPassword;
    emit(VisibleConfirmPasswordState());
  }

  void changeGender (val){
    gender = val;
    emit(ChangeGenderState());
  }

  Future postRegister(context) async {
    var json = {
      "name": nameController.value.toString(),
      "email": emailController.value.toString(),
      "password": passwordController.value.toString(),
      "phoneNumber": phoneNumberController.value.toString(),
      "gender": gender == 'male' ? 'm' : 'f',
    };


    DioHelper.postData(url: registerEndPoint, data: json).then((value) {

      if (value.statusCode == 200) {
        print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>success');
        Fluttertoast.showToast(
            msg: "Successfully Signup",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const AppLayout(),
            ),
                (route) => false);
      }
      emit(RegisterSuccessState());

    }).catchError((e){
      print(e);
      emit(RegisterErrorState());
    });
  }
}








// part 'register_state.dart';
//
// class RegisterCubit extends Cubit<RegisterState> {
//   RegisterCubit() : super(RegisterInitialState());
//
//   static RegisterCubit get(context) => BlocProvider.of(context);
//
//   bool visiblePassword = false;
//   bool visibleConfirmPassword = false;
//
//   /// function to change password visibility
//   void changePasswordVisibility() {
//     visiblePassword = !visiblePassword;
//     emit(VisiblePasswordState());
//   }
//
//   /// function to change password visibility
//   void changeConfirmPasswordVisibility() {
//     visibleConfirmPassword = !visibleConfirmPassword;
//     emit(VisibleConfirmPasswordState());
//   }
//
//   String gender = 'm';
//   void changeGender(value){
//     gender = value;
//     emit(ChangeGenderState());
//   }
//
//   Future postRegister(
//       {required String name,
//       required String email,
//       required String password,
//       required String phoneNumber,
//       required String gender,
//       context}) async {
//     emit(RegisterLoadingState());
//     DioHelper.postData(url: registerEndPoint, data: {
//       "name": name,
//       "email": email,
//       "password": password,
//       "phoneNumber": phoneNumber,
//       "gender": gender,
//     }).then((value) {
//       if (value.statusCode == 200) {
//
//         flutterToast(msg: 'Registered Successfully', color: Colors.green);
//
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const AppLayout(),
//             ),
//             (route) => false);
//         emit(RegisterSuccessState());
//       }
//     }).catchError((error) {
//       if (kDebugMode) {
//         print(error.toString());
//       }
//       emit(RegisterErrorState());
//     });
//   }
// }
