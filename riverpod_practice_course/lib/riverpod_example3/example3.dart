import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


enum City{stockholm, paris, tokyo}

typedef WeatherEmoji = String;

const unknownWeatherEmoji = '🤷';

Future<WeatherEmoji> getWeather(City city){
  return Future.delayed(const Duration(seconds: 1), 
  () => {
      City.stockholm: '💨',
      City.paris: '🌧️',
      City.tokyo: '☀️'
    }[city] ?? '🔥'
  );
}
//UI writes to and reads from this provider
final currentCityProvider = StateProvider<City?>((ref) => null);
//This Provider watches changes in the currentCityProvider and the UI reads from here;
final weatherProvider = FutureProvider<WeatherEmoji>((ref) {
  final city = ref.watch(currentCityProvider); 
  if(city != null){return getWeather(city);}
  else{return unknownWeatherEmoji;}
});


class Example3 extends ConsumerWidget {
  const Example3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(weatherProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: currentWeather.when(
              data: ((data) => Text(data)),
              error: ((_, trace) => Text(trace.toString())),
              loading: () => const CircularProgressIndicator(strokeWidth: 5,)
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: City.values.length,
              itemBuilder: (context, listIndex){
                final city = City.values.elementAt(listIndex);
                //UI reads from the StateProvider 
                final isSelected = city == ref.watch(currentCityProvider);
                return ListTile(
                  title: Text(city.name.toString()),
                  trailing: isSelected ? const Icon(Icons.check_circle_rounded) : null,
                  //UI writes to StateProvider by resettting its notifies state from null to city
                  onTap: () => ref.read(currentCityProvider.notifier).state = city,
                );
              }
            )
          )
        ]
      )
    );
  }
}