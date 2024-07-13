

import 'package:benesse1/SearchResult.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? _selectedDeviationValue;
  TextEditingController _schoolController = TextEditingController();
  String? _selectedPriority;

  final List<String> _deviationValues = ['50-55', '55-60', '60-65', '65-70', '70以上'];
  final List<String> _priorities = ['学習時間', '参考書の数', '模試の回数', 'その他'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('先輩の記録を検索'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: '偏差値',
                border: OutlineInputBorder(),
              ),
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
            ),
            SizedBox(height: 16),
            TextField(
              controller: _schoolController,
              decoration: InputDecoration(
                labelText: '第一志望の高校',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: '重視したこと',
                border: OutlineInputBorder(),
              ),
              value: _selectedPriority,
              items: _priorities.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedPriority = newValue;
                });
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
              child: Text("検索"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                // 検索処理を実装
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchResultScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}