
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import '../../../main.dart';
import '../Data/Model_Upload.dart';
import '../Data/Model_gallery.dart';
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
   Future<ModelGallery> fetchGallery() async {
    final response = await http.get(Uri.parse("https://flutter.prominaagency.com/api/my-gallery") ,headers: {
      'Authorization' : 'Bearer $token'
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
      'Authorization' : 'Bearer $token'
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
