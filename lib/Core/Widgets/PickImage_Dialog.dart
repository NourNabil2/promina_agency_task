import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promina_agency_test/Core/Utils/constants.dart';

import '../../Features/Home_Page/Model_view/home_cubit.dart';
import '../../Features/Home_Page/view/home_screen.dart';
import '../Network/API.dart';


void addChatUserDialog(context){
  HomeCubit Cubit_Home = BlocProvider.of<HomeCubit>(context);
  showDialog(
      context: context,
      builder: (_) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 250),
    child: AlertDialog(
      buttonPadding: EdgeInsets.all(40),
      iconPadding: EdgeInsets.all(40),
      contentPadding: const EdgeInsets.only(
          left: 24, right: 24, top: 20, bottom: 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white)),
      backgroundColor: Colors.white38,
      //content
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
                color: Color(0xffefd8f9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

                onPressed: () async {
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery , imageQuality: 80);
                  if(pickedFile!= null ){
                    image = File(pickedFile.path);
                     Cubit_Home.uploadphoto({},image!);
                  }else {
                    print('no image selected');
                  }

                },
                child:   Row(
                  children: [
                    Image.asset(kGallery,width: 50,),
                    Text('Gallery',
                        style: TextStyle(color: Color(0xff4a4a4a), fontSize: 20)),
                  ],
                ) ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
                color: Color(0xffebf6ff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () async {
                  final pickedFile = await picker.pickImage(source: ImageSource.camera , imageQuality: 80);
                  if(pickedFile!= null ){
                    image = File(pickedFile.path);
                    Cubit_Home.uploadphoto({},image!);
                  }else {
                    print('no image selected');
                  }

                },
                child:  Row(
                  children: [
                    Image.asset(kLogo,width: 50,),
                    Text('Camera',
                        style: TextStyle(color: Color(0xff4a4a4a), fontSize: 20)),
                  ],
                )),
          )
        ],
      ),


    ),
  ) );
}



