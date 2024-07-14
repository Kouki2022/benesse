import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExamSchedule {
  final String scheduleName;
  final DateTime examDate;
  final List<String> subjects;
  final Map<String, int> subjectScores;
  final int totalScore;
  final DateTime documentSubmissionDate; // 追加
  final double competitionRate; // 追加
  final DateTime resultAnnouncementDate; // 追加

  ExamSchedule({
    required this.scheduleName,
    required this.examDate,
    required this.subjects,
    required this.subjectScores,
    required this.totalScore,
    required this.documentSubmissionDate, // 追加
    required this.competitionRate, // 追加
    required this.resultAnnouncementDate, // 追加
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
          documentSubmissionDate: DateTime(2025, 1, 20), // 追加
          competitionRate: 2.5, // 追加
          resultAnnouncementDate: DateTime(2025, 2, 15), // 追加
        ),
        ExamSchedule(
          scheduleName: "B日程",
          examDate: DateTime(2025, 2, 15),
          subjects: ["国語", "数学", "英語", "総合"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "総合": 100},
          totalScore: 400,
          documentSubmissionDate: DateTime(2025, 1, 25), // 追加
          competitionRate: 2.3, // 追加
          resultAnnouncementDate: DateTime(2025, 2, 20), // 追加
        ),
      ],
    ),
    ExamInfo(
    schoolName: "東京学園高等学校",
    schedules: [
      ExamSchedule(
        scheduleName: "A日程",
        examDate: DateTime(2025, 2, 10),
        subjects: ["国語", "数学", "英語", "理科", "社会"],
        subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 50, "社会": 50},
        totalScore: 400,
        documentSubmissionDate: DateTime(2025, 1, 20),
        competitionRate: 2.5,
        resultAnnouncementDate: DateTime(2025, 2, 15),
      ),
      ExamSchedule(
        scheduleName: "B日程",
        examDate: DateTime(2025, 2, 15),
        subjects: ["国語", "数学", "英語", "総合"],
        subjectScores: {"国語": 100, "数学": 100, "英語": 100, "総合": 100},
        totalScore: 400,
        documentSubmissionDate: DateTime(2025, 1, 25),
        competitionRate: 2.3,
        resultAnnouncementDate: DateTime(2025, 2, 20),
      ),
    ],
  ),
  ExamInfo(
    schoolName: "横浜未来高等学校",
    schedules: [
      ExamSchedule(
        scheduleName: "前期",
        examDate: DateTime(2025, 2, 3),
        subjects: ["国語", "数学", "英語", "理科"],
        subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 100},
        totalScore: 400,
        documentSubmissionDate: DateTime(2025, 1, 15),
        competitionRate: 3.0,
        resultAnnouncementDate: DateTime(2025, 2, 8),
      ),
    ],
  ),
  ExamInfo(
    schoolName: "千葉総合高等学校",
    schedules: [
      ExamSchedule(
        scheduleName: "一般入試",
        examDate: DateTime(2025, 2, 12),
        subjects: ["国語", "数学", "英語", "理科", "社会"],
        subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 50, "社会": 50},
        totalScore: 400,
        documentSubmissionDate: DateTime(2025, 1, 22),
        competitionRate: 2.8,
        resultAnnouncementDate: DateTime(2025, 2, 17),
      ),
    ],
  ),
  ExamInfo(
    schoolName: "埼玉進学高等学校",
    schedules: [
      ExamSchedule(
        scheduleName: "第1回",
        examDate: DateTime(2025, 2, 5),
        subjects: ["国語", "数学", "英語"],
        subjectScores: {"国語": 100, "数学": 100, "英語": 100},
        totalScore: 300,
        documentSubmissionDate: DateTime(2025, 1, 18),
        competitionRate: 2.2,
        resultAnnouncementDate: DateTime(2025, 2, 10),
      ),
      ExamSchedule(
        scheduleName: "第2回",
        examDate: DateTime(2025, 2, 20),
        subjects: ["国語", "数学", "英語", "面接"],
        subjectScores: {"国語": 100, "数学": 100, "英語": 100, "面接": 50},
        totalScore: 350,
        documentSubmissionDate: DateTime(2025, 2, 5),
        competitionRate: 1.8,
        resultAnnouncementDate: DateTime(2025, 2, 25),
      ),
    ],
  ),
  ExamInfo(
    schoolName: "神奈川科学高等学校",
    schedules: [
      ExamSchedule(
        scheduleName: "特別選抜",
        examDate: DateTime(2025, 1, 25),
        subjects: ["数学", "理科", "面接"],
        subjectScores: {"数学": 150, "理科": 150, "面接": 50},
        totalScore: 350,
        documentSubmissionDate: DateTime(2025, 1, 10),
        competitionRate: 4.5,
        resultAnnouncementDate: DateTime(2025, 1, 30),
      ),
      ExamSchedule(
        scheduleName: "一般入試",
        examDate: DateTime(2025, 2, 15),
        subjects: ["国語", "数学", "英語", "理科"],
        subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 100},
        totalScore: 400,
        documentSubmissionDate: DateTime(2025, 1, 30),
        competitionRate: 3.2,
        resultAnnouncementDate: DateTime(2025, 2, 20),
      ),
    ],
  ),
  ExamInfo(
    schoolName: "静岡文化高等学校",
    schedules: [
      ExamSchedule(
        scheduleName: "総合型選抜",
        examDate: DateTime(2025, 2, 8),
        subjects: ["小論文", "面接", "実技"],
        subjectScores: {"小論文": 100, "面接": 100, "実技": 100},
        totalScore: 300,
        documentSubmissionDate: DateTime(2025, 1, 20),
        competitionRate: 2.0,
        resultAnnouncementDate: DateTime(2025, 2, 13),
      ),
    ],
  ),
  ExamInfo(
    schoolName: "群馬国際高等学校",
    schedules: [
      ExamSchedule(
        scheduleName: "英語特別",
        examDate: DateTime(2025, 2, 1),
        subjects: ["英語", "面接"],
        subjectScores: {"英語": 200, "面接": 100},
        totalScore: 300,
        documentSubmissionDate: DateTime(2025, 1, 15),
        competitionRate: 3.5,
        resultAnnouncementDate: DateTime(2025, 2, 6),
      ),
      ExamSchedule(
        scheduleName: "一般入試",
        examDate: DateTime(2025, 2, 18),
        subjects: ["国語", "数学", "英語", "社会"],
        subjectScores: {"国語": 100, "数学": 100, "英語": 100, "社会": 100},
        totalScore: 400,
        documentSubmissionDate: DateTime(2025, 2, 1),
        competitionRate: 2.7,
        resultAnnouncementDate: DateTime(2025, 2, 23),
      ),
    ],
    ),
    ExamInfo(
      schoolName: "茨城未来創造高等学校",
      schedules: [
        ExamSchedule(
          scheduleName: "推薦入試",
          examDate: DateTime(2025, 1, 28),
          subjects: ["小論文", "面接"],
          subjectScores: {"小論文": 100, "面接": 100},
          totalScore: 200,
          documentSubmissionDate: DateTime(2025, 1, 10),
          competitionRate: 1.5,
          resultAnnouncementDate: DateTime(2025, 2, 2),
        ),
        ExamSchedule(
          scheduleName: "一般入試",
          examDate: DateTime(2025, 2, 22),
          subjects: ["国語", "数学", "英語", "理科", "社会"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 50, "社会": 50},
          totalScore: 400,
          documentSubmissionDate: DateTime(2025, 2, 5),
          competitionRate: 2.4,
          resultAnnouncementDate: DateTime(2025, 2, 27),
        ),
      ],
    ),
    ExamInfo(
      schoolName: "栃木総合学園高等学校",
      schedules: [
        ExamSchedule(
          scheduleName: "専願入試",
          examDate: DateTime(2025, 2, 2),
          subjects: ["国語", "数学", "英語", "面接"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "面接": 50},
          totalScore: 350,
          documentSubmissionDate: DateTime(2025, 1, 15),
          competitionRate: 1.8,
          resultAnnouncementDate: DateTime(2025, 2, 7),
        ),
        ExamSchedule(
          scheduleName: "一般入試",
          examDate: DateTime(2025, 2, 25),
          subjects: ["国語", "数学", "英語", "理科", "社会"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "理科": 50, "社会": 50},
          totalScore: 400,
          documentSubmissionDate: DateTime(2025, 2, 8),
          competitionRate: 2.6,
          resultAnnouncementDate: DateTime(2025, 3, 1),
        ),
      ],
    ),
    ExamInfo(
      schoolName: "山梨芸術高等学校",
      schedules: [
        ExamSchedule(
          scheduleName: "芸術特別選抜",
          examDate: DateTime(2025, 1, 30),
          subjects: ["実技", "面接"],
          subjectScores: {"実技": 200, "面接": 100},
          totalScore: 300,
          documentSubmissionDate: DateTime(2025, 1, 12),
          competitionRate: 2.2,
          resultAnnouncementDate: DateTime(2025, 2, 4),
        ),
        ExamSchedule(
          scheduleName: "一般入試",
          examDate: DateTime(2025, 2, 28),
          subjects: ["国語", "数学", "英語", "実技"],
          subjectScores: {"国語": 100, "数学": 100, "英語": 100, "実技": 100},
          totalScore: 400,
          documentSubmissionDate: DateTime(2025, 2, 10),
          competitionRate: 1.9,
          resultAnnouncementDate: DateTime(2025, 3, 5),
        ),
      ],
    ),
    // 他の学校のデータも同様に更新...
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
                                Text('書類提出日: ${_formatDate(schedule.documentSubmissionDate)}'),
                                Text('倍率: ${schedule.competitionRate.toStringAsFixed(1)}倍'),
                                Text('合格発表日: ${_formatDate(schedule.resultAnnouncementDate)}'),
                                SizedBox(height: 8),
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
    return DateFormat('yyyy年MM月dd日').format(date);
  }
}