import 'dart:convert';
import 'package:http/http.dart' as http;

const GOOGLE_API_Key = 'AIzaSyA_Zdlro6_cfCbXoRjn1mTLbB9ils3v8lQ';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=14&size=400x400&maptype=roadmap&markers=color:red%7Clabel:H%7C$latitude,$longitude&key=$GOOGLE_API_Key';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_Key';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
