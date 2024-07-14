import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  final String userId;
  final Map<String, dynamic> userData;

  DetailPage({required this.userId, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('学生詳細情報'),
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchAllData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('データの読み込み中にエラーが発生しました'));
          }
          final allData = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, allData),
                _buildInfoSection(context, allData),
                _buildPreferencesSection(context, allData),
                _buildExamSchedule(context, allData),
                _buildFeedbackSection(context, allData),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Map<String, dynamic> data) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data['schoolName'] ?? '学校名未設定',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 8),
          Text(
            '偏差値: ${data['deviation'] ?? '未設定'}',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, Map<String, dynamic> data) {
    return _buildSection(
      context,
      '基本情報',
      [
        _buildInfoRow('性別', data['gender'] ?? '未設定'),
        _buildInfoRow('得意科目', data['subject'] ?? '未設定'),
      ],
    );
  }

  Widget _buildPreferencesSection(BuildContext context, Map<String, dynamic> data) {
    return _buildSection(
      context,
      '志望校情報',
      [
        _buildPreferenceRow('第一志望', data['First']),
        _buildPreferenceRow('第二志望', data['Second']),
        _buildPreferenceRow('第三志望', data['Third']),
      ],
    );
  }

  Widget _buildExamSchedule(BuildContext context, Map<String, dynamic> data) {
    List<Map<String, dynamic>> events = [];
    int currentYear = DateTime.now().year;

    ['First', 'Second', 'Third'].forEach((preference) {
      String prefJP = preference == 'First' ? '第一' : preference == 'Second' ? '第二' : '第三';
      if (data[preference] != null) {
        if (data[preference]['paper_date'] != null) {
          events.add({
            'date': _parseJapaneseDate(data[preference]['paper_date'], currentYear),
            'event': '$prefJP志望 ${data[preference]['name']} 書類提出',
            'isExam': false,
          });
        }
        if (data[preference]['detail_date'] != null) {
          events.add({
            'date': _parseJapaneseDate(data[preference]['detail_date'], currentYear),
            'event': '$prefJP志望 ${data[preference]['name']} 試験日',
            'isExam': true,
          });
        }
      }
    });

    events.sort((a, b) => a['date'].compareTo(b['date']));

    return _buildSection(
      context,
      '受験スケジュール',
      [
        for (var i = 0; i < events.length; i++)
          _buildTimelineTile(
            context,
            date: _formatDate(events[i]['date']),
            event: events[i]['event'],
            isFirst: i == 0,
            isLast: i == events.length - 1,
            isExam: events[i]['isExam'],
          ),
      ],
    );
  }

  DateTime _parseJapaneseDate(String dateString, int currentYear) {
    RegExp regExp = RegExp(r'(\d+)月(\d+)日');
    var match = regExp.firstMatch(dateString);
    if (match != null) {
      int month = int.parse(match.group(1)!);
      int day = int.parse(match.group(2)!);
      // 現在の月よりも前の月の場合、来年の日付とみなす
      if (month < DateTime.now().month) {
        currentYear++;
      }
      return DateTime(currentYear, month, day);
    }
    // パースに失敗した場合は現在の日付を返す
    return DateTime.now();
  }

  String _formatDate(DateTime date) {
    return DateFormat('MM月dd日').format(date);
  }

  Widget _buildTimelineTile(BuildContext context, {
    required String date,
    required String event,
    required bool isFirst,
    required bool isLast,
    required bool isExam,
  }) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      beforeLineStyle: LineStyle(color: Colors.blue),
      indicatorStyle: IndicatorStyle(
        width: 20,
        color: isExam ? Colors.red : Colors.blue,
        padding: EdgeInsets.all(6),
      ),
      endChild: Container(
        constraints: BoxConstraints(minHeight: 80),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(event, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackSection(BuildContext context, Map<String, dynamic> data) {
    return _buildSection(
      context,
      '受験フィードバック',
      [
        _buildExpandableText('志望理由', data['reason'] ?? '志望理由が入力されていません'),
        _buildExpandableText('受験の感想', data['message'] ?? '感想が入力されていません'),
        _buildExpandableText('後輩へのアドバイス', data['feedback'] ?? 'フィードバックがありません'),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildPreferenceRow(String title, Map<String, dynamic>? pref) {
    return pref != null
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(pref['name'] ?? '未設定', style: TextStyle(fontSize: 16)),
                    Text(
                      pref['date'] ?? '日程未設定',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          )
        : SizedBox.shrink();
  }

  Widget _buildExpandableText(String title, String content) {
    return ExpansionTile(
      title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(content, style: TextStyle(fontSize: 14)),
        ),
      ],
    );
  }

  Future<Map<String, dynamic>> _fetchAllData() async {
    final userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    final highschoolDocs = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('highschool')
        .get();

    Map<String, dynamic> allData = {...userData};
    
    for (var doc in highschoolDocs.docs) {
      if (['First', 'Second', 'Third', 'Other'].contains(doc.id)) {
        allData[doc.id] = doc.data();
      }
    }

    if (allData['Other'] != null) {
      allData.addAll(allData['Other'] as Map<String, dynamic>);
      allData.remove('Other');
    }

    return allData;
  }
}