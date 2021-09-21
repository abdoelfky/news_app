import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business.dart';
import 'package:news_app/modules/science/science.dart';
import 'package:news_app/modules/settings_screen/settings_screen.dart';
import 'package:news_app/modules/sports/sports.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cash_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(InitialState());
  static NewsCubit get(context)=>BlocProvider.of(context);

  List <Widget> screens=
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];



  int currentIndex=0;

  List <BottomNavigationBarItem> bottomItems=[
    BottomNavigationBarItem(icon:Icon(Icons.business),label: 'Business'),
    BottomNavigationBarItem(icon:Icon(Icons.sports),label: 'Sports'),
    BottomNavigationBarItem(icon:Icon(Icons.science),label: 'Science'),

  ];

void changeBottomNavBar(int index)
{

  currentIndex=index;
  if(index==0){getBusiness();}
  if(index==1){getSports();}
  if(index==2){getScience();}

  emit(NewsBottomNavState());
}

List <dynamic> business=[];
List <dynamic> sports=[];
List <dynamic> science=[];

void getBusiness(){
emit(NewsGetBusinessLoadingState());
  DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey':'c5f6e0225aee4615840852f68d665c51',


      }).then((value){
    business=value.data['articles'];
    print(business.length);
    print(business[0]['title']);
    emit(NewsGetBusinessSuccessState());
  }).catchError((error){
    print(error.toString());
    emit(NewsGetBusinessErrorState(error.toString()));
  });
}

void getSports(){
  if(sports.length==0){emit(NewsGetSportsLoadingState());
  DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'sports',
        'apiKey':'c5f6e0225aee4615840852f68d665c51',

      }).then((value){
    sports=value.data['articles'];
    print(sports.length);
    print(sports[0]['title']);
    emit(NewsGetSportsSuccessState());
  }).catchError((error){
    print(error.toString());
    emit(NewsGetSportsErrorState(error.toString()));
  });}

  else{
    emit(NewsGetSportsSuccessState());
  }

  }

void getScience(){
  if(science.length==0)
  {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey':'c5f6e0225aee4615840852f68d665c51',


        }).then((value){
      science=value.data['articles'];
      print(science.length);
      print(science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });


  }
  else {emit(NewsGetScienceSuccessState());}


}

bool isDark=true;

void changeAppMode({bool fromShared})
{
if(fromShared!=null){
    isDark=!isDark;
    isDark=fromShared;
  emit(ChangeAppThemeState());
  }

  else{
    isDark=!isDark;
    CasheHelper.putData(key: 'isDark', value: isDark).then((value)
    {
      emit(ChangeAppThemeState());
    });
  }
}
List <dynamic> search=[];

  void getSearch(String value){
    if(science.length==0)
    {
      emit(NewsGetSearchLoadingState());
      search=[];

      DioHelper.getData(
          url: 'v2/everything',
          query: {
            'q':'$value',
            'apiKey':'c5f6e0225aee4615840852f68d665c51',


          }).then((value){
        search=value.data['articles'];
        print(search.length);
        print(search[0]['title']);
        emit(NewsGetSearchSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });

}}}