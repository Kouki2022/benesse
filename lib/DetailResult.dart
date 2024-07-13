import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DetailResultScreen extends StatelessWidget {
  final Map<String, dynamic> result;

  DetailResultScreen({required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('詳細情報'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('基本情報', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8.0),
                    Text('性別: ${result['gender']}'),
                    Text('偏差値: ${result['deviation']}'),
                    Text('重視したこと: ${result['priority']}'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('志望校情報', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8.0),
                    Text('第一志望: ${result['firstChoice']}'),
                    Text('第一志望受験日: ${result['firstChoiceDate']}'),
                    SizedBox(height: 8.0),
                    Text('併願校:'),
                    ...result['otherSchools'].map((school) => Text('- $school')).toList(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('受験日程', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8.0),
                    TableCalendar(
                      firstDay: DateTime.utc(2024, 1, 1),
                      lastDay: DateTime.utc(2024, 12, 31),
                      focusedDay: DateTime.now(),
                      eventLoader: (day) {
                        return result['examDates'].where((date) {
                          final eventDate = DateTime.parse(date.replaceAll('年', '-').replaceAll('月', '-').replaceAll('日', ''));
                          return eventDate.year == day.year && eventDate.month == day.month && eventDate.day == day.day;
                        }).toList();
                      },
                      calendarStyle: CalendarStyle(
                        markerDecoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('感想', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8.0),
                    Text(result['impression']),
                    SizedBox(height: 16.0),
                    Text('一言メッセージ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8.0),
                    Text(result['message']),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}