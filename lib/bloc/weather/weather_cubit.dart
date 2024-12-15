
// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather/weather_states.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherCubit extends Cubit<WeatherStates>
{
  WeatherCubit(this.wsObj) : super(WeatherInitialState());

  WeatherService wsObj = WeatherService();
  WeatherModel? weatherModel;

  dynamic getWeather({required String cityName}) async
  {
    emit(WeatherLoadingState());
    try
    {
      weatherModel = await wsObj.getWeather(cityName: cityName);
      //print("\n$weatherModel\n");
      emit(WeatherLoadingSuccessState(weatherModel: weatherModel));
    } on Exception catch (error)
    {
      print("\n$error\n");
      emit(WeatherLoadingFailureState());
    }
    
  }

  
}