import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {

  final int initialCalendarIndex;
  final bool showBottomNavigation;

  CalendarScreen({
    this.initialCalendarIndex = 0,
    this.showBottomNavigation = true,
  });

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late int _currentIndex;
  late PageController _pageController;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final List<String> _calendarTitles = ['Calendar1', 'Calendar2', 'Calendar3'];
  final List<Map<DateTime, List<Event>>> _allEvents = [{}, {}, {}];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialCalendarIndex;
    _selectedDay = _focusedDay;
    _pageController = PageController(initialPage: _currentIndex);
    _loadEvents();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _loadEvents() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc('SasqYMwGb1YqpRK3PEcU')
        .get();

    final calendarData = userDoc.data()?['calendar'] as Map<String, dynamic>?;

    if (calendarData != null) {
      setState(() {
        for (int i = 0; i < 3; i++) {
          final calendarEvents = calendarData[_calendarTitles[i]] as Map<String, dynamic>?;
          if (calendarEvents != null) {
            _allEvents[i] = calendarEvents.map((key, value) {
              final date = DateTime.parse(key);
              final events = (value as List).map((e) {
                final eventData = e as Map<String, dynamic>;
                return Event(
                  eventData['title'],
                  TimeOfDay(hour: eventData['startHour'], minute: eventData['startMinute']),
                  TimeOfDay(hour: eventData['endHour'], minute: eventData['endMinute']),
                );
              }).toList();
              return MapEntry(date, events);
            });
          }
        }
      });
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _allEvents[_currentIndex][day] ?? [];
  }

  bool _checkEventOverlap(DateTime date, TimeOfDay startTime, TimeOfDay endTime) {
    final events = _allEvents[_currentIndex][date] ?? [];
    for (var event in events) {
      if (_doTimesOverlap(startTime, endTime, event.startTime, event.endTime)) {
        return true;
      }
    }
    return false;
  }

  bool _doTimesOverlap(TimeOfDay start1, TimeOfDay end1, TimeOfDay start2, TimeOfDay end2) {
    int start1Minutes = start1.hour * 60 + start1.minute;
    int end1Minutes = end1.hour * 60 + end1.minute;
    int start2Minutes = start2.hour * 60 + start2.minute;
    int end2Minutes = end2.hour * 60 + end2.minute;

    return start1Minutes < end2Minutes && start2Minutes < end1Minutes;
  }

  void _addEvent(String title, TimeOfDay startTime, TimeOfDay endTime) async {
    final eventDate = _selectedDay ?? _focusedDay;
    
    if (_checkEventOverlap(eventDate, startTime, endTime)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('時間の重複'),
          content: Text('この時間帯に既に予定が入っています。それでも追加しますか？'),
          actions: [
            TextButton(
              child: Text('キャンセル'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('追加'),
              onPressed: () {
                Navigator.of(context).pop();
                _saveEvent(title, startTime, endTime, eventDate);
              },
            ),
          ],
        ),
      );
    } else {
      _saveEvent(title, startTime, endTime, eventDate);
    }
  }

  void _saveEvent(String title, TimeOfDay startTime, TimeOfDay endTime, DateTime eventDate) async {
    final newEvent = Event(title, startTime, endTime);

    setState(() {
      if (_allEvents[_currentIndex][eventDate] == null) {
        _allEvents[_currentIndex][eventDate] = [newEvent];
      } else {
        _allEvents[_currentIndex][eventDate]!.add(newEvent);
      }
    });

    // Firestoreに保存
    final userDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc('SasqYMwGb1YqpRK3PEcU');

    await userDoc.set({
      'calendar': {
        _calendarTitles[_currentIndex]: _allEvents[_currentIndex].map(
          (key, value) => MapEntry(key.toIso8601String(),
              value.map((e) => {
                'title': e.title,
                'startHour': e.startTime.hour,
                'startMinute': e.startTime.minute,
                'endHour': e.endTime.hour,
                'endMinute': e.endTime.minute,
              }).toList()),
        ),
      }
    }, SetOptions(merge: true));
  }

  void _handleOkButtonPress(String calendarTitle) async {
    final userDoc = FirebaseFirestore.instance
        .collection('Users')
        .doc('SasqYMwGb1YqpRK3PEcU');

    await userDoc.update({'push': calendarTitle});
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('カレンダー: ${_calendarTitles[_currentIndex]}'),
      actions: [
        IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            _handleOkButtonPress(_calendarTitles[_currentIndex]);
          },
        ),
      ],
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
          child: _buildEventList(),
        ),
      ],
    ),
    floatingActionButton: widget.showBottomNavigation 
      ? FloatingActionButton(
          onPressed: _showAddEventDialog,
          child: Icon(Icons.add),
        )
      : null,
    bottomNavigationBar: _buildBottomNavigationBar(),
  );
}

Widget? _buildBottomNavigationBar() {
  if (!widget.showBottomNavigation) {
    return null;
  }
  return BottomNavigationBar(
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
  );
}

  Widget _buildEventList() {
    final events = _getEventsForDay(_selectedDay ?? _focusedDay);
    if (events.isEmpty) {
      return Center(
        child: Text(
          '予定はありません',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: Icon(Icons.event, color: Theme.of(context).primaryColor),
            title: Text(
              event.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${event.startTime.format(context)} - ${event.endTime.format(context)}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteEvent(event),
            ),
          ),
        );
      },
    );
  }

  void _showAddEventDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String newEventTitle = '';
        TimeOfDay startTime = TimeOfDay.now();
        TimeOfDay endTime = TimeOfDay(hour: startTime.hour + 1, minute: startTime.minute);
        return AlertDialog(
          title: Text('新しい予定を追加'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    newEventTitle = value;
                  },
                  decoration: InputDecoration(
                    labelText: "予定のタイトル",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        icon: Icon(Icons.access_time),
                        label: Text('開始時間: ${startTime.format(context)}'),
                        onPressed: () async {
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: startTime,
                          );
                          if (picked != null && picked != startTime) {
                            setState(() {
                              startTime = picked;
                              if (endTime.hour < startTime.hour ||
                                  (endTime.hour == startTime.hour && endTime.minute <= startTime.minute)) {
                                endTime = TimeOfDay(hour: startTime.hour + 1, minute: startTime.minute);
                              }
                            });
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: TextButton.icon(
                        icon: Icon(Icons.access_time),
                        label: Text('終了時間: ${endTime.format(context)}'),
                        onPressed: () async {
                          final TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: endTime,
                          );
                          if (picked != null && picked != endTime) {
                            setState(() {
                              endTime = picked;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('追加'),
              onPressed: () {
                if (newEventTitle.isNotEmpty) {
                  _addEvent(newEventTitle, startTime, endTime);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteEvent(Event event) {
    setState(() {
      _allEvents[_currentIndex][_selectedDay ?? _focusedDay]?.remove(event);
    });
    // Firestoreからも削除する処理を追加する必要
  }
}

class Event {
  final String title;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const Event(this.title, this.startTime, this.endTime);

  @override
  String toString() => '$title (${startTime.format(NavigationContext())} - ${endTime.format(NavigationContext())})';
}

class NavigationContext implements BuildContext {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}