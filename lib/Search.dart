import 'package:flutter/material.dart';
import 'package:benesse1/SearchResult.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedDeviationValue;
  TextEditingController _schoolController = TextEditingController();
  String? _selectedSubject;

  final List<String> _deviationValues = ['50~55', '55~60', '60~65', '65~70', '70以上'];
  final List<String> _likesubject = ['数学', '国語', '英語', '理科', '社会'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('先輩の記録を検索'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '自分と似た状況の先輩の体験を参考にしよう！',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 24),
                _buildSearchField(
                  icon: Icons.school,
                  label: '偏差値',
                  child: DropdownButtonFormField<String>(
                    value: _selectedDeviationValue,
                    items: _deviationValues.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedDeviationValue = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return '偏差値を選択してください';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '偏差値を選択',
                    ),
                  ),
                ),
                SizedBox(height: 16),
                _buildSearchField(
                  icon: Icons.location_city,
                  label: '第一志望の高校',
                  child: TextFormField(
                    controller: _schoolController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '高校名を入力',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '高校名を入力してください';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),
                _buildSearchField(
                  icon: Icons.star,
                  label: '得意科目',
                  child: DropdownButtonFormField<String>(
                    value: _selectedSubject,
                    items: _likesubject.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedSubject = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return '得意科目を選択してください';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '得意科目を選択',
                    ),
                  ),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  child: Text("体験記を検索", style: TextStyle(fontSize: 18,color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // ここを修正：フォームのバリデーションと検索条件の渡し方を変更
                    if (_formKey.currentState?.validate() ?? false) {
                      if (_schoolController.text.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchResultsList(
                              schoolName: _schoolController.text,
                              subject: _selectedSubject,
                              deviationValue: _selectedDeviationValue,
                            ),
                          ),
                        );
                      } else {
                        // 第一志望の高校が空の場合、エラーメッセージを表示
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('第一志望の高校を入力してください')),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField({
    required IconData icon,
    required String label,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            Row(
              children: [
                Icon(icon, color: Theme.of(context).primaryColor),
                SizedBox(width: 16),
                Expanded(child: child),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
