import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:goltest_ebay/ui/screen/weather_widgets.dart';

void main() {
  group('Basic Goldens', () {
    /// This test uses .pumpWidgetBuilder to automatically set up
    /// the appropriate Material dependencies in order to minimize boilerplate.
    ///
    /// It simply pumps a custom widget and captures the golden
    testGoldens('Single weather card should look correct', (tester) async {
      await tester.pumpWidgetBuilder(
        const Center(child: WeatherCard(temp: 66, weather: Weather.sunny)),
        surfaceSize: const Size(200, 200),
      );
      await screenMatchesGolden(tester, 'single_weather_card');
    });
  });

  group('GoldenBuilder', () {
    testGoldens('Weather Card - Accessibility', (tester) async {
      final gb = GoldenBuilder.grid(
          columns: 2, widthToHeightRatio: 1, bgColor: Colors.red[100])
        ..addScenario(
            'Sunny', const WeatherCard(temp: 66, weather: Weather.sunny))
        ..addScenario(
            'Cloudy', const WeatherCard(temp: 56, weather: Weather.cloudy))
        ..addScenario(
            'Raining', const WeatherCard(temp: 37, weather: Weather.rain))
        ..addScenario(
          'Cold',
          const WeatherCard(temp: 25, weather: Weather.cold),
        );

      await tester.pumpWidgetBuilder(
        gb.build(),
        surfaceSize: const Size(500, 500),
      );
      await screenMatchesGolden(tester, 'wather_types_gird');
    });

    //testGoldens('Weather Card - Different types with', (tester) async {
    //  final gb = GoldenBuilder.grid(
    //    columns: 2,
    //    widthToHeightRatio: 1,
    //    bgColor: Colors.red[100],
    //    //wrap: _simpleFrame)
    //  )
    //    ..addScenario(
    //        'Sunny', const WeatherCard(temp: 66, weather: Weather.sunny))
    //    ..addScenario(
    //        'Cloudy', const WeatherCard(temp: 56, weather: Weather.cloudy))
    //    ..addScenario(
    //        'Raining', const WeatherCard(temp: 37, weather: Weather.rain))
    //    ..addScenario(
    //      'Cold',
    //      const WeatherCard(temp: 25, weather: Weather.cold),
    //    );
//
    //  await tester.pumpWidgetBuilder(
    //    gb.build(),
    //    surfaceSize: const Size(120, 900),
    //  );
    //  await screenMatchesGolden(tester, 'wather_types_gird');
    //});
  });
}
