import 'package:cgpa/any_semGPA.dart';
import 'package:flutter/material.dart';

class GPA extends StatefulWidget {
  @override
  _GPAState createState() => _GPAState();
}

class _GPAState extends State<GPA> {
  final List<String> grades = ['S', 'A', 'B', 'C', 'D', 'E'];
  final List<int> credits = [1, 2, 3, 4];

  List<String> _selectedGrades = [];
  List<int> _selectedCredits = [];

  double _gpa = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('VIT GPA Calculator')),
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.black,
              child: ListView.builder(
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 8,
                      color: Colors.grey.shade900,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: DropdownButton<int>(
                                value: _selectedCredits.length > index
                                    ? _selectedCredits[index]
                                    : null,
                                hint: const Text(
                                  'Select credit',
                                  style: TextStyle(color: Colors.white),
                                ),
                                dropdownColor: Colors.grey.shade900,
                                onChanged: (int? newValue) {
                                  setState(
                                    () {
                                      if (_selectedCredits.length > index) {
                                        _selectedCredits[index] = newValue!;
                                      } else {
                                        _selectedCredits.add(newValue!);
                                      }
                                    },
                                  );
                                  _calculateGPA();
                                },
                                items: credits
                                    .map<DropdownMenuItem<int>>((int value) {
                                  return DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(
                                      '$value',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: DropdownButton<String>(
                                value: _selectedGrades.length > index
                                    ? _selectedGrades[index]
                                    : null,
                                hint: const Text(
                                  'Select grade',
                                  style: TextStyle(color: Colors.white),
                                ),
                                dropdownColor: Colors.grey.shade900,
                                onChanged: (String? newValue) {
                                  setState(
                                    () {
                                      if (_selectedGrades.length > index) {
                                        _selectedGrades[index] = newValue!;
                                      } else {
                                        _selectedGrades.add(newValue!);
                                      }
                                    },
                                  );
                                  _calculateGPA();
                                },
                                items: grades.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      '$value',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0.0),
                topRight: Radius.circular(0.0),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'GPA: ${_gpa.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.laptop,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Made by drowsycoder',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calculate),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CGPACalculator(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _calculateGPA() {
    double totalCredits = 0;
    double totalGradePoints = 0;

    for (int i = 0; i < _selectedGrades.length; i++) {
      if (_selectedGrades[i] != null && _selectedCredits[i] != null) {
        totalCredits += _selectedCredits[i];
        switch (_selectedGrades[i]) {
          case 'S':
            totalGradePoints += (_selectedCredits[i] * 10);
            break;
          case 'A':
            totalGradePoints += (_selectedCredits[i] * 9);
            break;
          case 'B':
            totalGradePoints += (_selectedCredits[i] * 8);
            break;
          case 'C':
            totalGradePoints += (_selectedCredits[i] * 7);
            break;
          case 'D':
            totalGradePoints += (_selectedCredits[i] * 6);
            break;
          case 'E':
            totalGradePoints += (_selectedCredits[i] * 5);
            break;
        }
      }
    }
    if (totalCredits > 0) {
      setState(() {
        _gpa = totalGradePoints / totalCredits;
      });
    } else {
      setState(() {
        _gpa = 0;
      });
    }
  }
}
