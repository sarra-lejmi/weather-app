import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/data/constants.dart';
import 'package:flutter_weather_app/presentation/bloc/weather_bloc.dart';
import 'package:flutter_weather_app/presentation/bloc/weather_event.dart';
import 'package:flutter_weather_app/presentation/bloc/weather_state.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Weather',
          style: TextStyle(
            color: Colors.purple,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: 'Enter city name',
              ),
              onChanged: (query) {
                context.read<WeatherBloc>().add(OnCityChanged(query));
              },
            ),
            const SizedBox(
              height: 32.0,
            ),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is WeatherHasData) {
                  return Column(
                    key: const Key('weather_data'),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.result.cityName,
                            style: const TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                          Image(
                            image: NetworkImage(
                              Urls.weatherIcon(
                                state.result.iconCode,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        '${state.result.main} | ${state.result.description}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Table(
                        defaultColumnWidth: const FixedColumnWidth(150.0),
                        border: TableBorder.all(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                        children: [
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Temperature',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  state.result.temperature.toString(),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Pressure',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  state.result.pressure.toString(),
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      letterSpacing: 1.2,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Humidity',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  state.result.humidity.toString(),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (state is WeatherError) {
                  return const Center(
                    child: Text('Something went wrong!'),
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}