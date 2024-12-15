import 'package:weather_app/models/weather_model.dart';

abstract class WeatherStates {}

class WeatherInitialState extends WeatherStates {}

class WeatherLoadingState extends WeatherStates {}

class WeatherLoadingSuccessState extends WeatherStates {
  WeatherModel? weatherModel;
  WeatherLoadingSuccessState({required this.weatherModel});
}

class WeatherLoadingFailureState extends WeatherStates {}