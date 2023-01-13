import 'dart:convert';

import 'package:covid_19_tracker/Models/WorldStatsModel.dart';
import 'package:covid_19_tracker/Services/Utilities/app_url.dart';
import 'package:covid_19_tracker/View/world_stats.dart';
import 'package:http/http.dart'as http;

class StatesService{
  Future<WorldStatsModel> fetchWorldStatsRecords()async{
    final response= await http.get(Uri.parse(AppUrl.worldstateApi));
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
    return WorldStatsModel.fromJson(data);

    }else{
      throw Exception('Error');

    }

  }
  Future<List<dynamic>> CountriesListApi() async{
    var data;
    final response= await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode==200){
      data=jsonDecode(response.body);
      return data;

    }else{
      throw Exception('Error');

    }

  }



}

Future<List<dynamic>> CountriesListApi() async{
  var data;
  final response= await http.get(Uri.parse(AppUrl.countriesList));
  if(response.statusCode==200){
    data=jsonDecode(response.body);
    return data;

  }else{
    throw Exception('Error');

  }

}
