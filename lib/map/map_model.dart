class MapDTO {
  final String duration;
  final String summary;
  final String points;
  final String distance;

  MapDTO(Map<String, dynamic> json, this.points)
      : duration = json['duration']['text'],
        distance = json['distance']['text'],
        summary = json['summary'];
}
