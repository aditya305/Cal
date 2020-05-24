import 'package:firebase_helpers/firebase_helpers.dart';

class EventModel extends DatabaseItem {
  final String id;
  final String title;
  final String description;
  final DateTime eventStartDate;
  final DateTime eventEndDate;
  final bool allDay;

  EventModel({
    this.id,
    this.title,
    this.description,
    this.eventStartDate,
    this.eventEndDate,
    this.allDay,
  }) : super(id);

  factory EventModel.fromMap(Map data) {
    return EventModel(
      title: data['title'],
      description: data['description'],
      eventStartDate: data['startDate'],
      eventEndDate: data['endDate'],
      allDay: data['allDay'],
    );
  }

  factory EventModel.fromDS(String id, Map<String, dynamic> data) {
    return EventModel(
      id: id,
      title: data['title'],
      description: data['description'],
      eventStartDate: data['startDate'],
      eventEndDate: data['endDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "startDate": eventStartDate,
      "endDate": eventEndDate,
      "allDay": allDay,
      "id": id,
    };
  }
}
