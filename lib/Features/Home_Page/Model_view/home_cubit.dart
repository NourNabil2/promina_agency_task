
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:promina_agency_test/Core/Functions/cash_save.dart';
import '../../../Core/Network/API.dart';
import '../../../Core/Utils/constants.dart';
import '../../../main.dart';
import '../Data/Model_Upload.dart';
import '../Data/Model_gallery.dart';
import '../view/home_screen.dart';
part 'home_state.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  ModelGallery? gallery;
  // void getAllGallery() {
  //   DioHelper.getdata(
  //       Url: APIs_Links.gallery,
  //       token: token,
  //   ).then((data)   {
  //     log(data.data);
  //     gallery = ModelGallery.fromJson(data.data);
  //     emit(HomeGEtSuccess());
  //     return ModelGallery.fromJson(data.data);
  //   }
  //
  //   ).catchError((e){
  //     log(e);
  //     emit(HomeGEtError(e.toString()));
  //   });
  // }
   Future<ModelGallery> fetchGallery( {token}) async {
    final response = await http.get(Uri.parse("https://flutter.prominaagency.com/api/my-gallery") ,headers: {
      'Authorization' : 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZDcyYjdjNWYzNWU3NWJhMjBkYjk5ZTMzYTlhMTMwMjlmYjU1MjM2YWEyZjNjNDcyNjMzMGJmMDg5NTY3YTQ0YmExOWNiZDUwMzI3ZjE3YjEiLCJpYXQiOjE3MTM5MDM1MTEuODE2MTEzLCJuYmYiOjE3MTM5MDM1MTEuODE2MTE0LCJleHAiOjE3NDU0Mzk1MTEuODE1Mjg4LCJzdWIiOiIzMzEiLCJzY29wZXMiOltdfQ.NJSC6_RS4aoLJLoAHJvNbb2O1em2DoaNmkSUk0goDZRIBaO7sVDdmeq6cgm4P2YgZX3I4Cq8iR-xrMMqgR51ANXv79yUMNeExeLzA5bKvgSKf-55HNkxK8D_732r7VTx6fw0spPf9f3925FqkkYzK_tiVkT44j7FKfZqS_YGTgXDSFo7f6c4N598FVNjtdJMVjm-S9mAzC-CKyOlZZsLj84RfIdnm6hyiaKlIEcJoek79j9UFYuvMByKrnxnPHEhSHexxebeEVvZhthz3cVLhE2TNellnFo0EpF9Z2u1jgfJIbk2TSL0UGdqfCqjBGnGsG4Toq3inhU1bm8DEVVjwl5omcEQ0ufywwPF7TDhSKFnYujjZMb_yYPbD9Od65C5IE1KBLqvh0w0Ys1OGGgTd3Ka-t_7sWlhL2NQAuU09bQ87niGtXoE0TlXVmMNMey5qeiXS9o2QIw2FKTw9Ijnsjc0mieFvlzTpmQYTfm68WZGVkVkjucwE5tj2mVuHNVbn3lvHnerT82qEf8x7l4UHN3SI11yRGINl5SntprIW9FRPDi01xuTPCOACrnUkFNmyPa9uFjGrhcF3QnahfhmNvjDOyn01rzp3scDSXcEH0OtzL8cQaMxLhj8f9nAj1c8Fpvg7KcgPfRaC-vOKE3yAcLcTNtlVNF-yweltLN9Wvo'
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      log(data.toString());
      gallery = ModelGallery.fromJson(data);
      emit(HomeGEtSuccess());
      return ModelGallery.fromJson(data);
    } else {
      emit(HomeGEtError());
      throw Exception('${response.body}');
    }
  }


  ModelUpload? modelUpload;
  void uploadphoto(Map data , File file) async {
    var req = MultipartRequest('POST',Uri.parse("https://flutter.prominaagency.com/api/upload"),);
    int length = await file.length()  ;
    var stream = ByteStream(file.openRead());
    var multyfile = http.MultipartFile('img',stream,length,filename: basename(file.path) );
    req.files.add(multyfile);
    req.headers.addAll({
      'Authorization' : 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZDcyYjdjNWYzNWU3NWJhMjBkYjk5ZTMzYTlhMTMwMjlmYjU1MjM2YWEyZjNjNDcyNjMzMGJmMDg5NTY3YTQ0YmExOWNiZDUwMzI3ZjE3YjEiLCJpYXQiOjE3MTM5MDM1MTEuODE2MTEzLCJuYmYiOjE3MTM5MDM1MTEuODE2MTE0LCJleHAiOjE3NDU0Mzk1MTEuODE1Mjg4LCJzdWIiOiIzMzEiLCJzY29wZXMiOltdfQ.NJSC6_RS4aoLJLoAHJvNbb2O1em2DoaNmkSUk0goDZRIBaO7sVDdmeq6cgm4P2YgZX3I4Cq8iR-xrMMqgR51ANXv79yUMNeExeLzA5bKvgSKf-55HNkxK8D_732r7VTx6fw0spPf9f3925FqkkYzK_tiVkT44j7FKfZqS_YGTgXDSFo7f6c4N598FVNjtdJMVjm-S9mAzC-CKyOlZZsLj84RfIdnm6hyiaKlIEcJoek79j9UFYuvMByKrnxnPHEhSHexxebeEVvZhthz3cVLhE2TNellnFo0EpF9Z2u1jgfJIbk2TSL0UGdqfCqjBGnGsG4Toq3inhU1bm8DEVVjwl5omcEQ0ufywwPF7TDhSKFnYujjZMb_yYPbD9Od65C5IE1KBLqvh0w0Ys1OGGgTd3Ka-t_7sWlhL2NQAuU09bQ87niGtXoE0TlXVmMNMey5qeiXS9o2QIw2FKTw9Ijnsjc0mieFvlzTpmQYTfm68WZGVkVkjucwE5tj2mVuHNVbn3lvHnerT82qEf8x7l4UHN3SI11yRGINl5SntprIW9FRPDi01xuTPCOACrnUkFNmyPa9uFjGrhcF3QnahfhmNvjDOyn01rzp3scDSXcEH0OtzL8cQaMxLhj8f9nAj1c8Fpvg7KcgPfRaC-vOKE3yAcLcTNtlVNF-yweltLN9Wvo'
    });

    data.forEach((key, value)
    {
      req.fields[key]=value;
    }
    );
    var myrequest = await req.send();
    var respone = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200)
    {

      emit(UploadSuccess());
      return jsonDecode(respone.body);
    }
    else
    {
      emit(UploadErorr());
      print('erorr request!!!!');
    }
  }


}
