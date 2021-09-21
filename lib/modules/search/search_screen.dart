import 'package:flutter/material.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>
      (listener:(context,state){} ,
      builder:(context,state){
        var list=NewsCubit.get(context).search;
        return Scaffold(
          appBar:AppBar(),
          body:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children:
              [
                defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    validate: (String value){
                      if(value.isEmpty){
                        return 'Search Must not be Empty';
                      }
                    },
                    label: 'Search',
                    prefix: Icons.search,
                    onChange: (value)
                    {
                      NewsCubit.get(context).getSearch(value);

                    }
                ),
                Expanded(child: articleBuilder(list))

              ],
            ),
          ),
        );
      } ,
    );
  }
}
