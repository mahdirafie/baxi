import 'package:baxi/map/map_model.dart';
import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';

final mapHttpClient = Dio(BaseOptions(
    baseUrl: "https://api.neshan.org/v4/",
    headers: {'Api-Key': 'service.a6c2667f451d456c8f7c79b65eee4480'}));

class MapService {
  static Future<MapDTO> getDirections(
      LatLng origin, LatLng destination, bool isCar) async {
    final response = await mapHttpClient.get(
        'direction?type=${isCar ? "car" : "motorcycle"}&origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}');

    final points = response.data['routes'][0]['overview_polyline']['points'];
    return MapDTO(response.data['routes'][0]['legs'][0], points);
  }

  static Future<LatLng> addressToLocation(String address, double lat, double lng) async{
    final response = await mapHttpClient.get('https://api.neshan.org/v1/search?term=$address&lat=$lat&lng=$lng');
    double latitude = response.data['items'][0]['location']['y'];
    double longitude = response.data['items'][0]['location']['x'];

    return LatLng(latitude, longitude);
  }
}
