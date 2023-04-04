import 'package:flutter/material.dart';

class CGPACalculator extends StatefulWidget {
  const CGPACalculator({Key? key}) : super(key: key);

  @override
  _CGPACalculatorState createState() => _CGPACalculatorState();
}

class _CGPACalculatorState extends State<CGPACalculator> {
  final List<TextEditingController> _gpaControllers = List.generate(
    8,
    (index) => TextEditingController(),
  );

  final List<TextEditingController> _creditControllers = List.generate(
    8,
    (index) => TextEditingController(),
  );

  double? _cgpa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('CGPA Calculator'),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
                color: Colors.grey[900],
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Calculate CGPA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Semester',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'GPA',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Credits',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Colors.grey),
                        for (int i = 0; i < 8; i++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Sem ${i + 1}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 100.0,
                                child: TextField(
                                  controller: _gpaControllers[i],
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  decoration: InputDecoration(
                                    hintText: 'Enter GPA',
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: 100.0,
                                child: TextField(
                                  controller: _creditControllers[i],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'No. of Credits',
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: _calculateCGPA,
                          child: Text('Calculate CGPA'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey[800],
                            onPrimary: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        if (_cgpa != null)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'CGPA: ${_cgpa?.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight
                                        .bold, // add this line to make the text bold
                                  ),
                                  textAlign: TextAlign
                                      .center, // add this line to center the text
                                ),
                              ],
                            ),
                          )
                      ],
                    )))),
      ),
    );
  }

  void _calculateCGPA() {
    double totalCredits = 0;
    double weightedGPA = 0;

    for (int i = 0; i < 8; i++) {
      final gpa = double.tryParse(_gpaControllers[i].text) ?? 0;
      final credits = double.tryParse(_creditControllers[i].text) ?? 0;

      totalCredits += credits;
      weightedGPA += gpa * credits;
    }

    if (totalCredits > 0) {
      setState(() {
        _cgpa = weightedGPA / totalCredits;
      });
    }
  }
}
