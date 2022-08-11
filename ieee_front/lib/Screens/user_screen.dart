import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ieee/Screens/main_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key, this.year, this.college, this.major})
      : super(key: key);
  final dynamic year;
  final dynamic college;
  final dynamic major;

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  void getInit() async {}
  late final List<dynamic> recommendList;
  late final List<dynamic> monthlyList;
  final recommendUrl = Uri.parse('http://10.0.2.2:5000/recommend');
  final monthlyUrl = Uri.parse('http://10.0.2.2:5000/monthly');

  String _selectedYear = "2018";
  String _selectedMonth = "01";

  final List<String> _years = [
    "2017",
    "2018",
    "2019",
    "2020",
    "2021",
  ];
  final List<String> _months = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
  ];

  void recommendGet() async {
    final response1 = await http.get(recommendUrl);
    recommendList =
        jsonDecode(utf8.decode(response1.bodyBytes));
    print("recommend Get");
  }

  @override
  void initState() {
    super.initState();
    recommendGet();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 8.0,
        title: const Text(
          "회원 정보",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: const Icon(Icons.menu_book),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "SSU",
                  style: TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "상위 소속",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.college,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "소속",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.major,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "입학년도",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.year,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      child: DropdownButton(
                          icon: const Icon(Icons.arrow_downward),
                          isDense: true,
                          iconSize: 20,
                          elevation: 16,
                          value: _selectedYear,
                          underline: Container(
                            height: 2,
                            color: Colors.cyan,
                          ),
                          isExpanded: true,
                          items: _years.map((String y) {
                            return DropdownMenuItem(
                              child: Text(
                                y,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              value: y,
                            );
                          }).toList(),
                          onChanged: (dynamic value) {
                            setState(() {
                              _selectedYear = value;
                            });
                          }),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 40,
                      child: DropdownButton(
                          icon: const Icon(Icons.arrow_downward),
                          isDense: true,
                          iconSize: 20,
                          elevation: 16,
                          value: _selectedMonth,
                          underline: Container(
                            height: 2,
                            color: Colors.cyan,
                          ),
                          isExpanded: true,
                          items: _months.map((String m) {
                            return DropdownMenuItem(
                              child: Text(
                                m,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              value: m,
                            );
                          }).toList(),
                          onChanged: (dynamic value) {
                            setState(() {
                              _selectedMonth = value;
                            });
                          }),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    OutlinedButton(
                        onPressed: () async {
                          await http.post(monthlyUrl,
                              body: json.encode({
                                'yearly': _selectedYear,
                                'monthly': _selectedMonth,
                              }));
                          await http.post(recommendUrl,
                              body: json.encode({
                                'college': widget.college,
                                'year': widget.year,
                                'major': widget.major,
                              }));
                          print("저장");
                        },
                        child: const Text("저장")),
                    const SizedBox(
                      width: 5,
                    ),
                    OutlinedButton(
                        onPressed: () async {
                          final response2 = await http.get(monthlyUrl);
                          monthlyList =
                              jsonDecode(utf8.decode(response2.bodyBytes));
                          print("불러오기");
                        },
                        child: const Text("불러오기")),
                  ],
                ),
                OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScreen(
                                    recommend: recommendList,
                                    monthly: monthlyList,
                                    year: widget.year,
                                    major: widget.major,
                                    college: widget.college,
                                    selectedMonth: _selectedMonth,
                                    selectedYear: _selectedYear,
                                  )));
                    },
                    child: const Text(
                      '추천 도서 보기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
