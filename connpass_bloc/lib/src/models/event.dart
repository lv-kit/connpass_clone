import 'package:equatable/equatable.dart';
import './series.dart';

class Event extends Equatable {
  final String eventUrl;
  final String eventType;
  final String ownerNickname;
  final Series series;
  final String updatedAt;
  final String lat;
  final String startedAt;
  final String hashTag;
  final String title;
  final int eventId;
  final String lon;
  final int waiting;
  final int limit;
  final int ownerId;
  final String ownerDisplayName;
  final String description;
  final String address;
  final String catchText;
  final int accepted;
  final String endedAt;
  final String place;

  Event({
    this.eventUrl,
    this.eventType,
    this.ownerNickname,
    this.series,
    this.updatedAt,
    this.lat,
    this.startedAt,
    this.hashTag,
    this.title,
    this.eventId,
    this.lon,
    this.waiting,
    this.limit,
    this.ownerId,
    this.ownerDisplayName,
    this.description,
    this.address,
    this.catchText,
    this.accepted,
    this.endedAt,
    this.place
  }) : super([
    eventUrl,
    eventType,
    ownerNickname,
    series,
    updatedAt,
    lat,
    startedAt,
    hashTag,
    title,
    eventId,
    lon,
    waiting,
    limit,
    ownerId,
    ownerDisplayName,
    description,
    address,
    catchText,
    accepted,
    endedAt,
    place
  ]);

  static Event fromJson(Map<String, dynamic> json) {
    var series = json['series'] == null
        ? null : Series.fromJson(json['series'] as Map<String, dynamic>);
    return Event(
      eventUrl: json['event_url'] as String,
      eventType: json['event_type'] as String,
      ownerNickname: json['owner_nickname'] as String,
      series: series,
      updatedAt: json['updated_at'] as String,
      lat: json['lat'] as String,
      startedAt: json['started_at'] as String,
      hashTag: json['hash_tag'] as String,
      title: json['title'] as String,
      eventId: json['event_id'] as int,
      lon: json['lon'] as String,
      waiting: json['waiting'] as int,
      limit: json['limit'] as int,
      ownerId: json['owner_id'] as int,
      ownerDisplayName: json['owner_display_name'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      catchText: json['catch'] as String,
      accepted: json['accepted'] as int,
      endedAt: json['ended_at'] as String,
      place: json['place'] as String,
    );
  }
}