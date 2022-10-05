import 'package:flutter/material.dart';
import '../screens/add_place_screen.dart';
import '../screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

import '../screens/places_list.dart';
import '../providers/places.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Places(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo).copyWith(secondary: Colors.amber),
        ),
        home: const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (BuildContext context) => const AddPlaceScreen(),
          PlaceDetailScreen.routeName: (BuildContext context) => const PlaceDetailScreen(),
        },
      ),
    );
  }
}
