import 'package:flutter/material.dart';
import 'weather_service.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geocoding App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController cityController = TextEditingController();

  Future<Map<String, double>>? _futureCoords;

  void getLatLon() async {
    if (cityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter city name')),
      );
      return;
    }

    try {
      setState(() {
        _futureCoords =
            _weatherService.getLatLon(cityController.text);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Geocoding App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: 'Enter City (e.g. New York)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: getLatLon,
              child: const Text('Get Latitude & Longitude'),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Center(
                child: _futureCoords == null
                    ? const Text(
                        'Enter a city and press button',
                        style: TextStyle(fontSize: 16),
                      )
                    : FutureBuilder<Map<String, double>>(
                        future: _futureCoords,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text(
                              'Error: ${snapshot.error}',
                              style: const TextStyle(color: Colors.red),
                            );
                          } else if (snapshot.hasData) {
                            final coords = snapshot.data!;

                            return Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      cityController.text,
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    Text(
                                      "Latitude: ${coords['lat']}",
                                      style: const TextStyle(fontSize: 22),
                                    ),

                                    const SizedBox(height: 10),

                                    Text(
                                      "Longitude: ${coords['lon']}",
                                      style: const TextStyle(fontSize: 22),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          return const Text('No data');
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}