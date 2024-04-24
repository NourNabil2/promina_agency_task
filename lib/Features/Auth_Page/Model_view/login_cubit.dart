import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:promina_agency_test/Core/Utils/constants.dart';
import '../../../Core/Network/API.dart';
import '../../../main.dart';
import '../Data/Model_Auth.dart';
import 'package:http/http.dart' as http;
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Auth? User;
  void userLogin({
    required String email,
    required String password,
  }) {
    DioHelper.postdata(token: token, path: APIs_Links.login, data: {
      'email': email,
      'password': password,
    }).then((data) {
      if (data.data['user'] != null) {
        User = Auth.fromJson(data.data);
        log(data.toString());
        emit(LoginSuccess(User!));
      } else if (data.data['error_message'] == 'Invalid Credntials') {
        emit(LoginError('email or Password incorrect'));
      }
    }).catchError((e) {
      print(e);
      emit(LoginError('Invalid Credntials'));
    });
  }
}
