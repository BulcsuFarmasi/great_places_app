import 'dart:convert';
import 'package:http/http.dart' as http;
import './secret.dart';

class LocationHelper {
  static String generateLocationPreviewImage({double latitude = 0.0, double longitude = 0.0}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleMapsApiKey';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
      final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$googleMapsApiKey');
      final response = await http.get(url);
      return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
