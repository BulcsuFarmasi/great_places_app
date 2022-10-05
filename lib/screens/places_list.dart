import 'package:flutter/material.dart';
import 'package:great_places_app/providers/places.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:great_places_app/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                navigator.pushNamed(AddPlaceScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : Consumer<Places>(
                child: const Center(child: Text('Got no places yet, start adding one')),
                builder: (BuildContext ctx, Places places, Widget? child) => places.items.isEmpty
                    ? child!
                    : ListView.builder(
                        itemBuilder: (BuildContext context, int i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(places.items[i].image),
                          ),
                          title: Text(places.items[i].title),
                          subtitle: Text(places.items[i].location.address!),
                          onTap: () {
                            navigator.pushNamed(
                              PlaceDetailScreen.routeName,
                              arguments: places.items[i].id,
                            );
                          },
                        ),
                        itemCount: places.items.length,
                      )),
      ),
    );
  }
}
