import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places_app/helpers/db_helper.dart';
import 'package:great_places_app/helpers/location_helper.dart';
import 'package:great_places_app/models/place.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  Future<void> addPlace(String title, File image, PlaceLocation location) async {
    final address = await LocationHelper.getPlaceAddress(location.latitude, location.longitude);
    final updatedLocation = PlaceLocation(latitude: location.latitude, longitude: location.longitude, address: address);
    final newPlace = Place(id: DateTime.now().toString(), image: image, title: title, location: updatedLocation);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address!,
    });
  }

  Future<void> fetchPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList.map((item) => Place(id: item['id'], title: item['title'], image: File(item['image']), location: PlaceLocation(latitude: item['loc_lat'], longitude: item['loc_lng'], address: item['address'])  )).toList();
    notifyListeners();
  }

  Place findById(String id) {
    return _items.firstWhere((Place place) => place.id == id);
  }
}
