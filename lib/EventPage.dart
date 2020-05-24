import 'package:cal/date_time_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Event extends StatefulWidget {
  static final String tag = '\Event';

  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  bool allDay = false;
  DateTime _startDate;
  TimeOfDay _startTime;
  DateTime _endDate;
  TimeOfDay _endTime;
  DateTime _start;
  DateTime _end;
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();

  @override
  void initState() {
    super.initState();

    _startDate = DateTime.now();
    _endDate = DateTime.now().add(Duration(hours: 1));
    _startTime = TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
    _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);
    _start = _combineDateWithTime(date: _startDate, time: _startTime);
    _end = _combineDateWithTime(date: _endDate, time: _endTime);
  }

  void _saveEvent() {
    final eventId = Uuid().v4();
    Firestore.instance.collection("events").document(eventId).setData({
      'eventId': eventId,
      'title': controllerTitle.text,
      'description': controllerDescription.text,
      'startDate': Timestamp.fromDate(_start),
      'endDate': Timestamp.fromDate(_end),
      'allDay': allDay,
    }).then(
      (value) => print('Event Saved!'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                new TextFormField(
                  controller: controllerTitle,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                new TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                new SwitchListTile(
                  value: allDay,
                  onChanged: (value) {
                    setState(() {
                      allDay = value;
                    });
                  },
                  title: Text('All Day'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                DateTimePicker(
                  labelText: 'From',
                  enableTime: !allDay,
                  selectedDate: _startDate,
                  selectedTime: _startTime,
                  selectDate: (DateTime date) {
                    setState(() {
                      _startDate = date;
                      _start = _combineDateWithTime(
                          date: _startDate, time: _startTime);
                    });
                  },
                  selectTime: (TimeOfDay time) {
                    setState(() {
                      _startTime = time;
                      _start = _combineDateWithTime(
                          date: _startDate, time: _startTime);
                    });
                  },
                ),
                new DateTimePicker(
                  labelText: 'To',
                  enableTime: !allDay,
                  selectedDate: _endDate,
                  selectedTime: _endTime,
                  selectDate: (DateTime date) {
                    setState(() {
                      _endDate = date;
                      _end =
                          _combineDateWithTime(date: _endDate, time: _endTime);
                    });
                  },
                  selectTime: (TimeOfDay time) {
                    setState(() {
                      _endTime = time;
                      _end =
                          _combineDateWithTime(date: _endDate, time: _endTime);
                    });
                  },
                ),
                RaisedButton(
                  onPressed: _saveEvent,
                  child: Text('Save'),
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // function Date Time Picker
  DateTime _combineDateWithTime({
    DateTime date,
    TimeOfDay time,
  }) {
    if (date == null && time == null) return null;
    final dateWithoutTime =
        DateTime.parse(DateFormat("y-MM-dd 00:00:00").format(date));
    return dateWithoutTime
        .add(Duration(hours: time.hour, minutes: time.minute));
  }
}
