import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myproject/bloc/weather_bloc.dart';
import 'package:myproject/models/weather_data.dart';
import 'package:myproject/services/data_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // final Future<List<WeatherData>> weatherDataFuture;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // enregistrement du cubit
      home: BlocProvider(
        create: (_) => WeatherCubit(WeatherService()),
        child: const WeatherApp(
          title: 'Weather app',
        ),
      ),
    );
  }
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({
    super.key,
    required this.title,
  });

  final String title;

  @override
  WeatherAppState createState() => WeatherAppState();
}

class WeatherAppState extends State<WeatherApp> {
  var _expandedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  Widget _showMoreDetails(WeatherData weatherData) {
    return Text('More details for ${weatherData.city}: ${weatherData.weather}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Weather app'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<WeatherCubit, List<WeatherData>>(
                builder: (context, state) {
                  if (state.isEmpty) {
                    return const CircularProgressIndicator();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      final weatherData = state[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            // maj état _isExpanded
                            _expandedIndex = index;
                          });
                        },
                        child: _ExpandableCard(
                          title: weatherData.city,
                          subtitle: 'Température: ${weatherData.temperature}°C',
                          isExpanded: _expandedIndex == index,
                          child: _showMoreDetails(weatherData),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 12.0),
              const _RefreshButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _RefreshButton extends StatelessWidget {
  const _RefreshButton();

  @override
  Widget build(BuildContext context) {
    const color = MaterialStateProperty.all<Color>;

    return TextButton(
      style: ButtonStyle(
        backgroundColor: color(Colors.blue),
        foregroundColor: color(Colors.black),
      ),
      onPressed: () => context.read<WeatherCubit>(),
      child: const Text('Refresh'),
    );
  }
}

class _ExpandableCard extends StatelessWidget {
  const _ExpandableCard({
    required this.title,
    required this.subtitle,
    required this.isExpanded,
    this.child,
  });

  final String title;
  final String subtitle;
  final bool isExpanded;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context);

    return Card(
      color: Colors.indigo.shade200,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textStyle.textTheme.titleMedium,
                  ),
                  Text(
                    subtitle,
                    style: textStyle.textTheme.titleSmall,
                  ),
                  if (isExpanded) child ?? Container(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
