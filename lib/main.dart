import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/layout/home_layout.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cash_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'dart:ui';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
    DioHelper.init();
    await CasheHelper.init();
    bool isDark=CasheHelper.getData(key: 'isDark');
    runApp(MyApp(isDark));

}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);
 // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context)=>NewsCubit()..getBusiness()..getSports()..getScience(),
        ),
        BlocProvider(
          create: (BuildContext context)=>NewsCubit()..changeAppMode(
            fromShared: isDark,
          )
        )


      ],
      child: BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state){} ,
      builder: (context,state){
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                    )
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrangeAccent
                ),
                scaffoldBackgroundColor: Colors.white,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    selectedItemColor: Colors.deepOrangeAccent,
                    elevation: 20.0,
                    type: BottomNavigationBarType.fixed
                ),
                appBarTheme: AppBarTheme(
                    titleSpacing: 23.0,
                    iconTheme: IconThemeData(
                        color: Colors.black
                    ),
                    titleTextStyle: TextStyle(color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                    color: Colors.white,
                    elevation: 0.0,
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark
                    )
                )
            ),
            darkTheme: ThemeData(
                appBarTheme: AppBarTheme(
                    titleSpacing: 23.0,
                    iconTheme: IconThemeData(
                        color: Colors.white
                    ),
                    titleTextStyle: TextStyle(color: Colors.white,
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                    backgroundColor: HexColor('333739'),
                    elevation: 0.0,
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: HexColor('333739'),
                        statusBarIconBrightness: Brightness.light
                    )
                ),
                scaffoldBackgroundColor: HexColor('333739'),
                backgroundColor: Colors.black,
                primaryColor: Colors.black,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    unselectedItemColor: Colors.grey,
                    selectedItemColor: Colors.deepOrange,
                    elevation: 20.0,
                    backgroundColor: HexColor('333739')
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    )
                )
            ),
            themeMode: NewsCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            home:  NewsHomeLayout()
        );
      }


      ),
    );
  }
}
