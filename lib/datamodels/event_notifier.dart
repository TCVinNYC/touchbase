import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:lets_connect/datamodels/event.dart';

class EventNotifier with ChangeNotifier {
  List<Event> _EventList = [];
  late Event _currentEvent;

  UnmodifiableListView<Event> get EventList => UnmodifiableListView(_EventList);

  Event get currentEvent => _currentEvent;

  set eventList(List<Event> eventList) {}

  set EventList(List<Event> EventList) {
    _EventList = EventList;
    notifyListeners();
  }

  set currentEvent(Event Event) {
    _currentEvent = Event;
    notifyListeners();
  }

  addEvent(Event Event) {
    _EventList.insert(0, Event);
    notifyListeners();
  }

  deleteEvent(Event Event) {
    _EventList.removeWhere((_Event) => _Event.documentId == Event.documentId);
    notifyListeners();
  }
}
