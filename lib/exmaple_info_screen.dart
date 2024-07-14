import 'package:flutter/material.dart';

class ExamSchedule {
  final String scheduleName;
  final DateTime examDate;
  final List<String> subjects;
  final Map<String, int> subjectScores;
  final int totalScore;

  ExamSchedule({
    required this.scheduleName,
    required this.examDate,
    required this.subjects,
    required this.subjectScores,
    required this.totalScore,
  });
}

class ExamInfo {
  final String schoolName;
  final List<ExamSchedule> schedules;

  ExamInfo({
    required this.schoolName,
    required this.schedules,
  });
}

class ExamInfoScreen extends StatefulWidget {
  @override
  _ExamInfoScreenState createState() => _ExamInfoScreenState();
}

class _ExamInfoScreenState extends State<ExamInfoScreen> {
  final List<ExamInfo> examInfoList = [
    ExamInfo(
      schoolName: "東京高校",
      schedules: [
        ExamSchedule(
          scheduleName: "A日程",
          examDate: DateTime(2025, 2, 10),
          subjects: ["国語", "数学", "英語", "理科", "社会"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 50, "社会": 50},
          totalScore: 400,
        ),
        ExamSchedule(
          scheduleName: "B日程",
          examDate: DateTime(2025, 2, 15),
          subjects: ["国語", "数学", "英語", "総合"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "総合": 100},
          totalScore: 400,
        ),
      ],
    ),
    ExamInfo(
      schoolName: "横浜高校",
      schedules: [
        ExamSchedule(
          scheduleName: "A日程",
          examDate: DateTime(2025, 2, 12),
          subjects: ["国語", "数学", "英語", "理科"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 100},
          totalScore: 400,
        ),
        ExamSchedule(
          scheduleName: "B日程",
          examDate: DateTime(2025, 2, 18),
          subjects: ["国語", "数学", "英語", "総合"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "総合": 100},
          totalScore: 400,
        ),
      ],
    ),
        ExamInfo(
      schoolName: "群馬高校",
      schedules: [
        ExamSchedule(
          scheduleName: "A日程",
          examDate: DateTime(2025, 2, 12),
          subjects: ["国語", "数学", "英語", "理科"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 100},
          totalScore: 400,
        ),
        ExamSchedule(
          scheduleName: "B日程",
          examDate: DateTime(2025, 2, 18),
          subjects: ["国語", "数学", "英語", "総合"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "総合": 100},
          totalScore: 400,
        ),
      ],
    ),
        ExamInfo(
      schoolName: "埼玉高校",
      schedules: [
        ExamSchedule(
          scheduleName: "A日程",
          examDate: DateTime(2025, 2, 12),
          subjects: ["国語", "数学", "英語", "理科"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 100},
          totalScore: 400,
        ),
        ExamSchedule(
          scheduleName: "B日程",
          examDate: DateTime(2025, 2, 18),
          subjects: ["国語", "数学", "英語", "総合"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "総合": 100},
          totalScore: 400,
        ),
      ],
    ),
        ExamInfo(
      schoolName: "茨城高校",
      schedules: [
        ExamSchedule(
          scheduleName: "A日程",
          examDate: DateTime(2025, 2, 12),
          subjects: ["国語", "数学", "英語", "理科"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 100},
          totalScore: 400,
        ),
        ExamSchedule(
          scheduleName: "B日程",
          examDate: DateTime(2025, 2, 18),
          subjects: ["国語", "数学", "英語", "総合"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "総合": 100},
          totalScore: 400,
        ),
      ],
    ),
        ExamInfo(
      schoolName: "横浜高校",
      schedules: [
        ExamSchedule(
          scheduleName: "A日程",
          examDate: DateTime(2025, 2, 12),
          subjects: ["国語", "数学", "英語", "理科"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 100},
          totalScore: 400,
        ),
        ExamSchedule(
          scheduleName: "B日程",
          examDate: DateTime(2025, 2, 18),
          subjects: ["国語", "数学", "英語", "総合"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "総合": 100},
          totalScore: 400,
        ),
      ],
    ),
        ExamInfo(
      schoolName: "群馬高校",
      schedules: [
        ExamSchedule(
          scheduleName: "A日程",
          examDate: DateTime(2025, 2, 12),
          subjects: ["国語", "数学", "英語", "理科"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 100},
          totalScore: 400,
        ),
        ExamSchedule(
          scheduleName: "B日程",
          examDate: DateTime(2025, 2, 18),
          subjects: ["国語", "数学", "英語", "総合"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "総合": 100},
          totalScore: 400,
        ),
      ],
    ),
        ExamInfo(
      schoolName: "埼玉高校",
      schedules: [
        ExamSchedule(
          scheduleName: "A日程",
          examDate: DateTime(2025, 2, 12),
          subjects: ["国語", "数学", "英語", "理科"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 100},
          totalScore: 400,
        ),
        ExamSchedule(
          scheduleName: "B日程",
          examDate: DateTime(2025, 2, 18),
          subjects: ["国語", "数学", "英語", "総合"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "総合": 100},
          totalScore: 400,
        ),
      ],
    ),
        ExamInfo(
      schoolName: "茨城高校",
      schedules: [
        ExamSchedule(
          scheduleName: "A日程",
          examDate: DateTime(2025, 2, 12),
          subjects: ["国語", "数学", "英語", "理科"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 100},
          totalScore: 400,
        ),
        ExamSchedule(
          scheduleName: "B日程",
          examDate: DateTime(2025, 2, 18),
          subjects: ["国語", "数学", "英語", "総合"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "総合": 100},
          totalScore: 400,
        ),
      ],
    ),
        ExamInfo(
      schoolName: "横浜高校",
      schedules: [
        ExamSchedule(
          scheduleName: "A日程",
          examDate: DateTime(2025, 2, 12),
          subjects: ["国語", "数学", "英語", "理科"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 100},
          totalScore: 400,
        ),
        ExamSchedule(
          scheduleName: "B日程",
          examDate: DateTime(2025, 2, 18),
          subjects: ["国語", "数学", "英語", "総合"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "総合": 100},
          totalScore: 400,
        ),
      ],
    ),
        ExamInfo(
      schoolName: "群馬高校",
      schedules: [
        ExamSchedule(
          scheduleName: "A日程",
          examDate: DateTime(2025, 2, 12),
          subjects: ["国語", "数学", "英語", "理科"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 100},
          totalScore: 400,
        ),
        ExamSchedule(
          scheduleName: "B日程",
          examDate: DateTime(2025, 2, 18),
          subjects: ["国語", "数学", "英語", "総合"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "総合": 100},
          totalScore: 400,
        ),
      ],
    ),
        ExamInfo(
      schoolName: "埼玉高校",
      schedules: [
        ExamSchedule(
          scheduleName: "A日程",
          examDate: DateTime(2025, 2, 12),
          subjects: ["国語", "数学", "英語", "理科"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 100},
          totalScore: 400,
        ),
        ExamSchedule(
          scheduleName: "B日程",
          examDate: DateTime(2025, 2, 18),
          subjects: ["国語", "数学", "英語", "総合"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "総合": 100},
          totalScore: 400,
        ),
      ],
    ),
        ExamInfo(
      schoolName: "茨城高校",
      schedules: [
        ExamSchedule(
          scheduleName: "A日程",
          examDate: DateTime(2025, 2, 12),
          subjects: ["国語", "数学", "英語", "理科"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 100},
          totalScore: 400,
        ),
        ExamSchedule(
          scheduleName: "B日程",
          examDate: DateTime(2025, 2, 18),
          subjects: ["国語", "数学", "英語", "総合"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "総合": 100},
          totalScore: 400,
        ),
      ],
    ),
        ExamInfo(
      schoolName: "横浜高校",
      schedules: [
        ExamSchedule(
          scheduleName: "A日程",
          examDate: DateTime(2025, 2, 12),
          subjects: ["国語", "数学", "英語", "理科"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 100},
          totalScore: 400,
        ),
        ExamSchedule(
          scheduleName: "B日程",
          examDate: DateTime(2025, 2, 18),
          subjects: ["国語", "数学", "英語", "総合"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "総合": 100},
          totalScore: 400,
        ),
      ],
    ),
        ExamInfo(
      schoolName: "群馬高校",
      schedules: [
        ExamSchedule(
          scheduleName: "A日程",
          examDate: DateTime(2025, 2, 12),
          subjects: ["国語", "数学", "英語", "理科"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 100},
          totalScore: 400,
        ),
        ExamSchedule(
          scheduleName: "B日程",
          examDate: DateTime(2025, 2, 18),
          subjects: ["国語", "数学", "英語", "総合"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "総合": 100},
          totalScore: 400,
        ),
      ],
    ),
        ExamInfo(
      schoolName: "埼玉高校",
      schedules: [
        ExamSchedule(
          scheduleName: "A日程",
          examDate: DateTime(2025, 2, 12),
          subjects: ["国語", "数学", "英語", "理科"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 100},
          totalScore: 400,
        ),
        ExamSchedule(
          scheduleName: "B日程",
          examDate: DateTime(2025, 2, 18),
          subjects: ["国語", "数学", "英語", "総合"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "総合": 100},
          totalScore: 400,
        ),
      ],
    ),
        ExamInfo(
      schoolName: "茨城高校",
      schedules: [
        ExamSchedule(
          scheduleName: "A日程",
          examDate: DateTime(2025, 2, 12),
          subjects: ["国語", "数学", "英語", "理科"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 100},
          totalScore: 400,
        ),
        ExamSchedule(
          scheduleName: "B日程",
          examDate: DateTime(2025, 2, 18),
          subjects: ["国語", "数学", "英語", "総合"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "総合": 100},
          totalScore: 400,
        ),
      ],
    ),
    // 他の8校のデータも同様に追加...
  ];

  List<ExamInfo> filteredExamInfoList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredExamInfoList = examInfoList;
  }

  void _filterExamInfo(String query) {
    setState(() {
      filteredExamInfoList = examInfoList
          .where((info) =>
              info.schoolName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('高校受験情報一覧'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: '高校名で検索',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterExamInfo,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredExamInfoList.length,
              itemBuilder: (context, index) {
                final examInfo = filteredExamInfoList[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ExpansionTile(
                    title: Text(examInfo.schoolName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    children: examInfo.schedules.map((schedule) {
                      return ExpansionTile(
                        title: Text(schedule.scheduleName),
                        subtitle: Text('試験日: ${_formatDate(schedule.examDate)}'),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('試験科目:', style: TextStyle(fontWeight: FontWeight.bold)),
                                ...schedule.subjects.map((subject) => Text('• $subject')),
                                SizedBox(height: 8),
                                Text('配点:', style: TextStyle(fontWeight: FontWeight.bold)),
                                ...schedule.subjectScores.entries.map((entry) => Text('• ${entry.key}: ${entry.value}点')),
                                SizedBox(height: 8),
                                Text('合計点: ${schedule.totalScore}点', style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}年${date.month}月${date.day}日';
  }
}