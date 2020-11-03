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
        const Center(child: WeatherCard(temp: 66, weather: Weather.rain)),
        surfaceSize: const Size(200, 200),
      );
      await screenMatchesGolden(tester, 'single_weather_card');
    });
  });

  group('GoldenBuilder', () {
    testGoldens('Weather Card - Accessibility', (tester) async {
      final gb = GoldenBuilder.grid(
          columns: 2, widthToHeightRatio: 1, bgColor: Colors.green[100])
        ..addScenario('Example Sunny',
            const WeatherCard(temp: 66, weather: Weather.sunny))
        ..addScenario('Example Cloudy',
            const WeatherCard(temp: 56, weather: Weather.cloudy))
        ..addScenario('Example Raining',
            const WeatherCard(temp: 8, weather: Weather.rain))
        ..addScenario(
            'Example Cold', const WeatherCard(temp: 25, weather: Weather.cold));

      await tester.pumpWidgetBuilder(
        gb.build(),
        surfaceSize: const Size(500, 500),
      );
      await screenMatchesGolden(tester, 'wather_types_gird');
    });
  });

  group('Multi-Screen Golden', () {
    testGoldens('Example of testing a responsive layout', (tester) async {
      await tester.pumpWidgetBuilder(const WeatherForecast());
      await multiScreenGolden(tester, 'weather_forecast');
    });
  });
  testGoldens('Card should look right on different devices / screen sizes',
      (tester) async {
    final gb = GoldenBuilder.column(bgColor: Colors.white)
      ..addScenario(
          'Sunny', const WeatherCard(temp: 66, weather: Weather.sunny))
      ..addScenario(
          'Cloudy', const WeatherCard(temp: 56, weather: Weather.cloudy))
      ..addScenario(
          'Raining', const WeatherCard(temp: 37, weather: Weather.rain))
      ..addScenario('Cold', const WeatherCard(temp: 25, weather: Weather.cold))
      ..addTextScaleScenario(
          'Cold', const WeatherCard(temp: 25, weather: Weather.cold));

    await tester.pumpWidgetBuilder(
      gb.build(),
      surfaceSize: const Size(200, 1200),
    );

    await multiScreenGolden(
      tester,
      'all_sized_all_fonts',
      devices: [Device.phone, Device.tabletLandscape],
      overrideGoldenHeight: 1200,
    );
  });

  group('GoldenBuilder examples of accessibility testing', () {
    // With those test we want to make sure our widgets look right when user changes system font size
    testGoldens('Card should look right when user bumps system font size',
        (tester) async {
      const widget = WeatherCard(temp: 56, weather: Weather.cloudy);

      final gb = GoldenBuilder.column(
        bgColor: Colors.white,
        //wrap: _simpleFrame
      )
        ..addScenario('Regular font size', widget)
        ..addTextScaleScenario('Large font size', widget, textScaleFactor: 2.0)
        ..addTextScaleScenario('Largest font size', widget,
            textScaleFactor: 3.2);

      await tester.pumpWidgetBuilder(
        gb.build(),
        surfaceSize: const Size(200, 1000),
      );
      await screenMatchesGolden(tester, 'weather_accessibility');
    });
  });
}
