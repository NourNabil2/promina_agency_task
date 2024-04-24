import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina_agency_test/Core/Functions/cash_save.dart';

import '../../../Core/Utils/Colors.dart';
import '../../../Core/Utils/Responsive.dart';
import '../../../Core/Utils/constants.dart';
import '../../../Core/Widgets/Snackbar.dart';
import '../../../Core/Widgets/components.dart';
import '../../../Core/Widgets/custom_button.dart';
import '../../../Core/Widgets/custom_text_field.dart';
import '../../../main.dart';
import '../../Home_Page/Model_view/home_cubit.dart';
import '../../Home_Page/view/home_screen.dart';
import '../Model_view/login_cubit.dart';


class LoginPage extends StatelessWidget {
  bool isLoading = false;
  static String id = 'login page';

  GlobalKey<FormState> formKey = GlobalKey();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? email, password;
    LoginCubit Cubit = BlocProvider.of<LoginCubit>(context);
    HomeCubit Cubit_Home = BlocProvider.of<HomeCubit>(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          isLoading = false;
          await CashSaver.SaveData(key: 'token', value: state.auth.token);
          Cubit_Home.fetchGallery();
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.id,
                (route) => false,
          );
        } else if (state is LoginError) {
          isLoading = false;
          showSnackBar(context, state.messageErorr!);
        }
      },
      builder: (context, state) => Scaffold(
          body:   Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [ColorApp.kScreenColor4,ColorApp.kPrimaryColor,ColorApp.kScreenColor2,ColorApp.kScreenColor3,],transform: GradientRotation(10)),
              //BackGround Image
              // image: DecorationImage(
              //     image: AssetImage(kLogoscreen), fit: BoxFit.fill)
            ),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  Transform.rotate(
                    angle: -0.4,
                    child: Image.asset(

                      alignment: const AlignmentDirectional(-1, 0.7),
                      kLogo,
                      height: Responsive.isTablet(context) == true ? 300 : 200,
                    ),
                  ),
                  Center(
                    child: Text(
                      'My\nGellary',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Container(
                    margin: Responsive.isTablet(context) == true ? EdgeInsets.symmetric(horizontal: ValueApp.margin_250) : EdgeInsets.all( ValueApp.margin_30),
                    padding: Responsive.isTablet(context) == true ? EdgeInsets.all( ValueApp.kPadding_120) : EdgeInsets.all(ValueApp.kPadding_20),
                    decoration:  BoxDecoration(color: Colors.white38,borderRadius: BorderRadius.circular(24)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Responsive.isTablet(context) == true ? Box(size: 0): Box(size: 20),
                        Center(
                          child: Text(
                            'LOG IN',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Box(size: 20),
                        CustomFormTextField(
                          obscureText: false,
                          onChanged: (data) {
                            email = data;
                          },
                          hintText: 'User Name',
                        ),
                        Box(size: 20),
                        CustomFormTextField(
                          obscureText: true,
                          onChanged: (data) {
                            password = data;
                          },
                          hintText: 'Password',
                        ),
                        Box(size: 20),
                        CustomButon(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              Cubit.userLogin(email: email!, password: password!);
                            } else {}
                          },
                          text: 'Submit',
                        ),
                         Box(size: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

    );
  }
}
