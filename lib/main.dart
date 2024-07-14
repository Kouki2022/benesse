import 'package:benesse1/SearchResult.dart';
import 'package:benesse1/exmaple_info_screen.dart';
import 'package:flutter/material.dart';
import 'Search.dart';
import 'Calender.dart';
import 'SearchResult.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:device_preview/device_preview.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '受験日程プランナー',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: MyHomePage(title: '受験日程プランナー'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeContent(), //ホーム
    CalendarScreen(), // Calendar
    SearchScreen(), //先輩の記録
    ExamInfoScreen(), // 高校検索
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'スケジュール',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '先輩の記録',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '高校検索',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            color: Theme.of(context).primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'あなたの志望校',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 8),
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc('SasqYMwGb1YqpRK3PEcU') //動的にする必要
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    var userData = snapshot.data!.data() as Map<String, dynamic>;
                    return Column(
                      children: [
                        _buildSchoolCard('第一志望', userData['First']['highschool'], userData['First']['date']),
                        _buildSchoolCard('第二志望', userData['Second']['highschool'], userData['Second']['date']),
                        _buildSchoolCard('第三志望', userData['Third']['highschool'], userData['Third']['date']),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc('SasqYMwGb1YqpRK3PEcU')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    var userData = snapshot.data!.data() as Map<String, dynamic>;
                    String pushCalendar = userData['push'] ?? 'Calendar1';
                    int calendarIndex = pushCalendar == 'Calendar1' ? 0 : 
                                        pushCalendar == 'Calendar2' ? 1 : 
                                        pushCalendar == 'Calendar3' ? 2 : 0;
                    
                    return Card(
                      child: SizedBox(
                        height: 700,
                        child: CalendarScreen(
                          initialCalendarIndex: calendarIndex,
                          showBottomNavigation: false,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),
                Text(
                  '主な機能',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                _buildFeatureCard(
                  context, 
                  Icons.calendar_today, 
                  '受験日程を設定',
                  '先輩の記録を参考に最適な受験日程を計画しましょう',
                  Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CalendarScreen()),
                    );
                  }          
                ),
                _buildFeatureCard(
                  context, 
                  Icons.history, 
                  '先輩の記録を閲覧',
                  '過去の受験生の勉強計画や結果を確認できます',
                  Colors.orange,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchScreen()),
                    );
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchoolCard(String rank, String schoolName, String schedule) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text('$rank: $schoolName'),
        subtitle: Text('受験日程: $schedule'),
        trailing: Icon(Icons.edit),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, IconData icon, String title, String description, Color color, {VoidCallback? onTap}) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              Icon(icon, size: 48, color: color),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(description, style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}