import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TableCalendar(
            calendarStyle: CalendarStyle(
              todayColor: Colors.blue,
              selectedColor: Colors.green,
              todayStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
                color: Colors.white,
              ),
            ),
            headerStyle: HeaderStyle(
              centerHeaderTitle: true,
              formatButtonDecoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              formatButtonTextStyle: TextStyle(color: Colors.white),
            ),
            calendarController: _controller,
          ),
        ],
      ),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          
        },
      ),
    );
  }
}
