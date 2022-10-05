import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/places.dart';
import '../screens/add_place_screen.dart';
import '../screens/place_detail_screen.dart';
import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
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
                            Navigator.of(context).pushNamed(
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
