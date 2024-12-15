// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather/weather_cubit.dart';
import 'package:weather_app/bloc/weather/weather_states.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';

class HomePage extends StatelessWidget
{
  WeatherModel? weatherData;

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) {return SearchPage();}));},
            icon:  const Icon(Icons.search),),],
        title:  const Text('Weather App'),),

        body: BlocBuilder<WeatherCubit, WeatherStates>(builder: (context, state)
        {
          final weatherCubit = BlocProvider.of<WeatherCubit>(context);
          if (state is WeatherLoadingState)
          {
            return  const Center(child: CircularProgressIndicator(),);
          }
          else if (state is WeatherLoadingSuccessState)
          {
            final weatherData = weatherCubit.weatherModel; // Ensure weatherData is initialized
            return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  weatherData!.getThemeColor(),
                  weatherData.getThemeColor()[300]!,
                  weatherData.getThemeColor()[100]!,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 3,
                  ),
                  Text(
                    //Provider.of<WeatherProvider>(context).cityName!,
                    BlocProvider.of<WeatherCubit>(context).weatherModel!.cityName,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'updated at : ${weatherData.date.hour.toString()}:${weatherData.date.minute.toString()}',
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(weatherData.getImage()),
                      Text(
                        weatherData.temp.toInt().toString(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: [
                          Text('maxTemp :${weatherData.maxTemp.toInt()}'),
                          Text('minTemp : ${weatherData.minTemp.toInt()}'),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    weatherData.weatherStateName,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(
                    flex: 5,
                  ),
                ],
              ),
            );
          }
          else if (state is WeatherLoadingFailureState)
          {
            return const Center(child: Text('Something went wrong 😔'),);
          }
          else
          {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'there is no weather 😔 start',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    'searching now 🔍',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  )
                ],
              ),
            );
          }
        }
      ),
    );
  }
}
