import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DetailPage.dart';

class SearchResultsList extends StatefulWidget {
  final String schoolName;
  final String? subject;
  final String? deviationValue;

  SearchResultsList({
    required this.schoolName,
    this.subject,
    this.deviationValue,
  });

  @override
  _SearchResultsListState createState() => _SearchResultsListState();
}

class _SearchResultsListState extends State<SearchResultsList> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('高校検索結果', style: TextStyle(fontSize: 20)),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '第二志望または第三志望の高校名で検索',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('エラーが発生しました: ${snapshot.error}');
            return Center(child: Text('エラーが発生しました', style: TextStyle(color: Colors.red)));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return FutureBuilder<List<QueryDocumentSnapshot>>(
            future: _filterDocuments(snapshot.data!.docs),
            builder: (context, filteredSnapshot) {
              if (filteredSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              var filteredDocs = filteredSnapshot.data ?? [];

              if (filteredDocs.isEmpty) {
                return Center(child: Text('検索結果が見つかりませんでした。'));
              }

              return ListView(
                children: filteredDocs.map((doc) {
                  final userData = doc.data() as Map<String, dynamic>;
                  return FutureBuilder<Map<String, Map<String, dynamic>>>(
                    future: _getHighSchoolPreferences(doc.id),
                    builder: (context, prefSnapshot) {
                      if (prefSnapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox.shrink();
                      }

                      final prefs = prefSnapshot.data ?? {};

                      return Card(
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(userId: doc.id, userData: userData),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userData['schoolName'] ?? '学校名未設定',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 8),
                                      Text('第一志望: ${_formatPreference(prefs['First'])}', style: TextStyle(fontSize: 16)),
                                      Text('第二志望: ${_formatPreference(prefs['Second'])}', style: TextStyle(fontSize: 16)),
                                      Text('第三志望: ${_formatPreference(prefs['Third'])}', style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        prefs['likes']?['likes'] == true ? Icons.favorite : Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                                      onPressed: () => _toggleLike(doc.id),
                                    ),
                                    Text('${prefs['likes']?['likes_count'] ?? 0}'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
  bool _schoolNameMatches(Map<String, dynamic>? pref, String query) {
  return pref != null &&
      pref['name'] != null &&
      pref['name'].toString().toLowerCase().contains(query);
}

Future<List<QueryDocumentSnapshot>> _filterDocuments(List<QueryDocumentSnapshot> docs) async {
  List<QueryDocumentSnapshot> filteredDocs = [];

  for (var doc in docs) {
    if (doc.id == 'SasqYMwGb1YqpRK3PEcU') continue;

    final userData = doc.data() as Map<String, dynamic>;
    final prefs = await _getHighSchoolPreferences(doc.id);

    bool matchesSearch = _searchQuery.isEmpty ||
        _schoolNameMatches(prefs['Second'], _searchQuery) ||
        _schoolNameMatches(prefs['Third'], _searchQuery);

    bool matchesSchoolName = userData['schoolName'].toString().toLowerCase() == widget.schoolName.toLowerCase();

    if (matchesSearch && matchesSchoolName) {
      filteredDocs.add(doc);
    }
  }

  return filteredDocs;
}

  Future<Map<String, Map<String, dynamic>>> _getHighSchoolPreferences(String userId) async {
    final highSchoolDocs = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('highschool')
        .get();

    Map<String, Map<String, dynamic>> prefs = {};
    for (var doc in highSchoolDocs.docs) {
      if (['First', 'Second', 'Third', 'likes'].contains(doc.id)) {
        prefs[doc.id] = doc.data();
      }
    }
    return prefs;
  }

  String _formatPreference(Map<String, dynamic>? pref) {
    if (pref == null) return '未設定';
    return '${pref['name']} ${pref['date']}';
  }

  void _toggleLike(String userId) async {
    final docRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('highschool')
        .doc('likes');

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) {
        transaction.set(docRef, {'likes': true, 'likes_count': 1});
      } else {
        final bool currentLikes = snapshot.data()?['likes'] ?? false;
        final int currentCount = snapshot.data()?['likes_count'] ?? 0;
        transaction.update(docRef, {
          'likes': !currentLikes,
          'likes_count': currentLikes ? currentCount - 1 : currentCount + 1,
        });
      }
    });
  }
}