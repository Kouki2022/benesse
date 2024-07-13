import 'package:flutter/material.dart';
import 'Search.dart';
import 'Calender.dart';

void main() => runApp(MyApp());

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

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              color: Theme.of(context).primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'あなたの第一志望',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Card(
                    child: ListTile(
                      title: Text('東京高校'),
                      subtitle: Text('受験まであと 234 日'),
                      trailing: Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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

