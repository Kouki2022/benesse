import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late PageController _pageController;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int _currentIndex = 0;

  final List<String> _calendarTitles = ['受験Aプラン', '受験Bプラン', '個人予定'];
  final List<Map<DateTime, List<Event>>> _allEvents = [
    {}, // 試験のイベント
    {}, // 学習計画のイベント
    {}  // 個人予定のイベント
  ];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _pageController = PageController(initialPage: _currentIndex);

    // サンプルのイベントを追加
    _allEvents[0] = {
      DateTime.utc(2023, 7, 15): [Event('模擬試験')],
      DateTime.utc(2024, 1, 13): [Event('センター試験（1日目）')],
      DateTime.utc(2024, 1, 14): [Event('センター試験（2日目）')],
    };
    _allEvents[1] = {
      DateTime.utc(2023, 8, 1): [Event('夏期講習開始')],
      DateTime.utc(2023, 12, 1): [Event('冬期講習開始')],
    };
    _allEvents[2] = {
      DateTime.utc(2023, 8, 15): [Event('友人との勉強会')],
      DateTime.utc(2023, 9, 1): [Event('塾の個別相談')],
    };
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _allEvents[_currentIndex][day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('カレンダー: ${_calendarTitles[_currentIndex]}'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: _getEventsForDay,
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView(
              children: _getEventsForDay(_selectedDay ?? _focusedDay)
                  .map((event) => ListTile(
                        title: Text(event.title),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _calendarTitles
            .map((title) => BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today),
                  label: title,
                ))
            .toList(),
      ),
    );
  }
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}