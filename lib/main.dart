import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Core/Functions/cash_save.dart';
import 'Core/Network/API.dart';
import 'Features/Auth_Page/Model_view/login_cubit.dart';
import 'Features/Auth_Page/view/login_page.dart';
import 'Features/Home_Page/Model_view/home_cubit.dart';
import 'Features/Home_Page/view/home_screen.dart';
String? token;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashSaver.init();
  await DioHelper.init();
  token = CashSaver.getData(key: 'token');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit() ),
        BlocProvider(create: (context) => HomeCubit()..fetchGallery()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            textTheme: const TextTheme(
              titleLarge: TextStyle(color: Color(0xff4a4a4a),fontSize: 48,fontWeight: FontWeight.bold),
              titleMedium: TextStyle(color: Color(0xff4a4a4a),fontSize: 32,fontWeight: FontWeight.bold),
              titleSmall: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
              labelSmall: TextStyle(color: Color(0xff9d9491),fontSize: 15,fontWeight: FontWeight.bold),

            ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
          useMaterial3: true,
        ),
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          LoginPage.id: (context) => LoginPage(),
        },
        initialRoute: LoginPage.id ,
      ),
    );
  }
}

