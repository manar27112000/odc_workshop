import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/business_logic/terms/terms_state.dart';

import '../../constants/end_points.dart';
import '../../data/Models/terms_model.dart';
import '../../data/data_provider/remote/dio_helper.dart';

class TermsCubit extends Cubit<TermsState> {
  TermsCubit() : super(TermsInitial());

  static TermsCubit get(context) => BlocProvider.of(context);
  TermsModel? termsModel;

  //use for get Terms & Conditions from api
  void getTermsConditions() async {
    DioHelper.getData(url: termsEndPoint).then((value) {
      termsModel = TermsModel.fromJson(json: value.data);
      emit(TermsSuccess());
    }).catchError((error) {
      emit(TermsError());
    });
  }
}
