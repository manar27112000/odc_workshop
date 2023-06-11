import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:workshop/constants/end_points.dart';
import 'package:workshop/data/Models/auth/login_model.dart';
import 'package:workshop/data/data_provider/remote/dio_helper.dart';

import '../../../constants/end_points.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  bool visiblePassword = false;

  void changePasswordVisibility(){
    visiblePassword = !visiblePassword;
    emit(PasswordVisibilityState());
  }

  void login({
    required String email,
    required String password,
    required  Function(String) loginError,
  }){
    emit(LoginLoadingState());
    DioHelper.postData(url: loginEndPoint, data: {
      'email' : email,
      'password' : password,
    }).then((value) {
      emit(LoginSuccessState(loginModel: LoginModel.fromJson(value.data)),);
    }).catchError((e){
      print(e);

      loginError('Successfully Signup');
      emit(LoginErrorState());
    });
  }
}



// part 'login_state.dart';
//
// class LoginCubit extends Cubit<LoginState> {
//   LoginCubit() : super(LoginInitialState());
//
//   static LoginCubit get(context) => BlocProvider.of(context);
//
//   bool visiblePassword = false;
//
//   void changePasswordVisibility() {
//     visiblePassword = !visiblePassword;
//     emit(PasswordVisibilityState());
//   }
//
//   void postLogin({
//     required String email,
//     required String password,
//     context,
//   }) {
//     emit(LoginLoadingState());
//     DioHelper.postData(url: loginEndPoint, data: {
//       'email': email,
//       'password': password,
//     }).then((value) {
//       if (value.statusCode == 200) {
//         emit(LoginSuccessState(loginModel: LoginModel.fromJson(value.data)));
//       }
//     }).catchError((error) {
//       if (kDebugMode) {
//         print(error);
//       }
//       emit(LoginErrorState());
//     });
//   }
// }
