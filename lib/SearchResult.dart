import 'package:flutter/material.dart';

import 'DetailResult.dart';

class SearchResultScreen extends StatelessWidget {
  final List<Map<String, dynamic>> searchResults = [
    {
      'gender': '男性',
      'priority': '教育方針',
      'firstChoice': '東京大学',
      'otherSchools': ['京都大学', '大阪大学'],
      'likes': 120,
      'deviation': 70,
      'firstChoiceDate': '2024年11月1日',
      'examDates': ['2024年11月1日', '2024年11月15日', '2024年12月1日'],
      'impression': '難しかったけど、やりがいがあった！',
      'message': '頑張れば夢は叶います！'
    },
        {
      'gender': '男性',
      'priority': '教育方針',
      'firstChoice': '東京大学',
      'otherSchools': ['京都大学', '大阪大学'],
      'likes': 120,
      'deviation': 70,
      'firstChoiceDate': '2024年11月1日',
      'examDates': ['2024年11月1日', '2024年11月15日', '2024年12月1日'],
      'impression': '難しかったけど、やりがいがあった！',
      'message': '頑張れば夢は叶います！'
    },
        {
      'gender': '男性',
      'priority': '教育方針',
      'firstChoice': '東京大学',
      'otherSchools': ['京都大学', '大阪大学'],
      'likes': 120,
      'deviation': 70,
      'firstChoiceDate': '2024年11月1日',
      'examDates': ['2024年11月1日', '2024年11月15日', '2024年12月1日'],
      'impression': '難しかったけど、やりがいがあった！',
      'message': '頑張れば夢は叶います！'
    },
        {
      'gender': '男性',
      'priority': '教育方針',
      'firstChoice': '東京大学',
      'otherSchools': ['京都大学', '大阪大学'],
      'likes': 120,
      'deviation': 70,
      'firstChoiceDate': '2024年11月1日',
      'examDates': ['2024年11月1日', '2024年11月15日', '2024年12月1日'],
      'impression': '難しかったけど、やりがいがあった！',
      'message': '頑張れば夢は叶います！'
    },
        {
      'gender': '男性',
      'priority': '教育方針',
      'firstChoice': '東京大学',
      'otherSchools': ['京都大学', '大阪大学'],
      'likes': 120,
      'deviation': 70,
      'firstChoiceDate': '2024年11月1日',
      'examDates': ['2024年11月1日', '2024年11月15日', '2024年12月1日'],
      'impression': '難しかったけど、やりがいがあった！',
      'message': '頑張れば夢は叶います！'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('検索結果'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final result = searchResults[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailResultScreen(result: result),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.all(8.0),
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '性別: ${result['gender']}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4.0),
                              Text('重視したこと: ${result['priority']}'),
                              SizedBox(height: 4.0),
                              Text('第一志望: ${result['firstChoice']}'),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Icon(Icons.favorite, color: Colors.red),
                            Text(
                              '${result['likes']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Text('併願校:'),
                    ...result['otherSchools'].map((school) => Text('- $school')).toList(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}