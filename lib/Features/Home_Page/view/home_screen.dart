import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promina_agency_test/Core/Functions/cash_save.dart';
import 'package:promina_agency_test/Core/Utils/constants.dart';
import 'package:promina_agency_test/Core/Widgets/PickImage_Dialog.dart';
import '../../../Core/Utils/Colors.dart';
import '../../../Core/Utils/Responsive.dart';
import '../../../Core/Widgets/Snackbar.dart';
import '../../../Core/Widgets/custom_button.dart';
import '../../Auth_Page/Model_view/login_cubit.dart';
import '../../Auth_Page/view/login_page.dart';
import '../Model_view/home_cubit.dart';
File? image ;
final picker = ImagePicker();
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static String id = 'Home page';

  @override
  Widget build(BuildContext context) {
    HomeCubit Cubit_Home = BlocProvider.of<HomeCubit>(context);
    LoginCubit cubit_Login = BlocProvider.of<LoginCubit>(context);
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) async {
          if (state is UploadSuccess)
            {
              Cubit_Home.fetchGallery();
              Navigator.pop(context);
              showSnackBar(context, 'Image uploaded successfully');
            }
          else if (state is UploadErorr)
            {
              Navigator.pop(context);
              showSnackBar(context, 'Error While Upload!');
            }
          if (state is LoginSuccess)
            {
              Cubit_Home.fetchGallery();
            }

        },
        builder: (context, state) => Scaffold(
            body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    ColorApp.kScreenColor4,
                    ColorApp.kScreenColor3,
                  ], transform: GradientRotation(10)),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(ValueApp.kPadding_20),
                        child: Row(
                          children: [
                            Text(
                              'Welcome \n${cubit_Login.User?.user?.name}',
                              style: Responsive.isTablet(context) == true ?Theme.of(context).textTheme.titleLarge: Theme.of(context).textTheme.titleSmall,

                            ),
                            const Spacer(),
                            Responsive.isTablet(context) == true ? CircleAvatar(maxRadius: 45,child: Icon(Icons.person,size: 50,),): CircleAvatar(maxRadius: 25,child: Icon(Icons.person,size: 30,),)

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: ValueApp.kPadding_40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HomeButons(onTap: () async{
                              await CashSaver.Cleardata(key: 'token');
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                LoginPage.id,
                                    (route) => false,
                              );
                            },text: 'Log Out', icon: CupertinoIcons.arrow_left,color: Colors.redAccent,shadow: Colors.redAccent,),
                            Spacer(),
                            HomeButons(onTap: () {
                              addChatUserDialog(context);
                            },text: 'Upload', icon: CupertinoIcons.arrow_up,color: Color(0xffff9900),shadow: Color(0xffff9900),),

                          ],
                        ),
                      ),
                      Expanded(

                        child: Padding(
                          padding: const EdgeInsets.all(ValueApp.kPadding_8),
                          child: GridView.builder(
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: Responsive.isTablet(context) == true ? 5 :3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: Cubit_Home.gallery?.data.images.length ?? 0,
                            itemBuilder: (context, index) => Container(
                              margin:Responsive.isTablet(context) == true ? EdgeInsets.all(5) : null,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),boxShadow: [BoxShadow(color: Colors.black54,blurRadius: 5,spreadRadius: 1,blurStyle: BlurStyle.normal)],
                              image: DecorationImage(image:  CachedNetworkImageProvider(Cubit_Home.gallery!.data.images[index]),fit:BoxFit.fill )
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]))));
  }
}
