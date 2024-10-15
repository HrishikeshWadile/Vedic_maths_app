// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.teal, // Sea green color for the header
          titleTextStyle:
              TextStyle(color: Colors.white, fontSize: 20), // White title text
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.black, // Black background in dark mode
        appBarTheme: const AppBarTheme(
          color: Colors.teal, // Sea green color for the header
          titleTextStyle:
              TextStyle(color: Colors.white, fontSize: 20), // White title text
        ),
      ),
      themeMode:
          ThemeMode.system, // Automatically switch between light and dark mode
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Operations'),
      ),
      body: ListView(children: [
        _buildButton(context, 'Multiplication', const MultiplicationScreen()),
        _buildButton(context, 'Square', const SquareScreen()),
        _buildButton(context, 'Cube', const CubeScreen()),
        _buildButton(context, 'Division', const DivisionScreen()),
        _buildButton(
            context, 'Divisibility Test', const DivisibilityTestScreen()),
        _buildButton(context, 'Highest Common Factor', const HCFScreen()),
        _buildButton(context, 'Multiplication of Polynomial',
            const PolynomialMultiplicationScreen()),
        _buildButton(context, 'Division of Polynomial',
            const PolynomialDivisionScreen()),
        _buildButton(context, 'Linear Equation', const LinearEquationScreen()),
        _buildButton(
            context, 'Quadratic Equation', const QuadraticEquationScreen()),
        _buildButton(context, 'Cubic Polynomial Factorization',
            const CubicPolynomialScreen()),
        _buildButton(context, 'Magic Squares', const MagicSquaresScreen()),
        _buildButton(
            context, 'Dates and Calendar', const DatesCalendarScreen()),
        _buildButton(context, 'Determinant', const DeterminantScreen()),
        _buildButton(
            context, 'Coordinate Geometry', const CoordinateGeometryScreen()),
        _buildButton(context, 'Differentiation', const DifferentiationScreen()),
        _buildButton(context, 'Integration', const IntegrationScreen()),
        _buildButton(context, 'Trigonometry', const TrigonometryScreen()),
      ]),
    );
  }

  Widget _buildButton(BuildContext context, String title, Widget screen) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(
              double.infinity, 50), // Full width buttons with a height of 50
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        child: Text(title, style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}

// Helper function to build header cells
Widget _buildHeaderCell(String text) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    color: Colors.grey[300], // Background color for header
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

// Helper function to build regular cells
Widget _buildCell(String text) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      textAlign: TextAlign.center,
    ),
  );
}

// Define screens for each operation (example screens provided)
class MultiplicationScreen extends StatefulWidget {
  const MultiplicationScreen({super.key});

  @override
  _MultiplicationScreenState createState() => _MultiplicationScreenState();
}

class _MultiplicationScreenState extends State<MultiplicationScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  String? _errorText1;
  String? _errorText2;
  List<String> temp = [];
  List<List<String>> rows1 = [];
  int rows1Insert = 0;
  List<List<String>> rows2 = [];
  List<List<String>> rows3 = [];
  List<List<String>> rows4 = [];

  String _step1 = '';
  String _step2 = '';
  String _step3 = '';
  String _step4 = '';

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vedic Multiplication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInputField(context, _controller1, _errorText1),
                Text(
                  '×',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                _buildInputField(context, _controller2, _errorText2),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                _validateInputs();
                if (_errorText1 == null && _errorText2 == null) {
                  setState(() {
                    // Clear existing results
                    _step1 = '';
                    _step2 = '';
                    _step3 = '';
                    _step4 = '';
                    rows1.clear();
                    rows1Insert = 0;
                    rows2.clear();
                    rows3.clear();
                    rows4.clear();

                    // Perform new calculation
                    _calculateMultiplication(
                      int.parse(_controller1.text),
                      int.parse(_controller2.text),
                    );
                  });
                }
              },
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_step1.isNotEmpty) _buildStep1(),
                    if (_step2.isNotEmpty) _buildStep2(),
                    if (_step3.isNotEmpty) _buildStep3(),
                    if (_step4.isNotEmpty) _buildStep4(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(BuildContext context,
      TextEditingController controller, String? errorText) {
    return SizedBox(
      width: 100,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.yellow,
          border: const OutlineInputBorder(),
          hintText: 'Enter number',
          errorText: errorText,
          errorStyle: const TextStyle(color: Colors.red),
          hintStyle: const TextStyle(color: Colors.black54),
        ),
      ),
    );
  }

  void _validateInputs() {
    setState(() {
      _errorText1 = _controller1.text.isEmpty ? 'Field cannot be empty' : null;
      _errorText2 = _controller2.text.isEmpty ? 'Field cannot be empty' : null;
    });
  }

  void _calculateMultiplication(int num1, int num2) {
    String xStr = num1.toString();
    String yStr = num2.toString();

    int n = xStr.length;
    int m = yStr.length;

    List<String> uniqueYStr = [
      '',
      for (int idx = 0; idx < yStr.length; idx++) yStr[idx]
    ];
    rows1.insert(rows1Insert, uniqueYStr);
    rows1Insert++;

    Map<int, List<int>> additionDict = {};

    StringBuffer gridTable = StringBuffer();

    for (int i = 0; i < n; i++) {
      gridTable.write('${xStr[i]} | ');
      temp.add(xStr[i]);
      for (int j = 0; j < m; j++) {
        int product = int.parse(xStr[i]) * int.parse(yStr[j]);
        int position = i + j + 1;
        gridTable.write('${xStr[i]} x ${yStr[j]} = $product ($position) | ');
        temp.add('${xStr[i]} x ${yStr[j]} = $product ($position)');

        if (!additionDict.containsKey(position)) {
          additionDict[position] = [];
        }
        additionDict[position]?.add(product);
      }
      gridTable.writeln();
      rows1.insert(rows1Insert, temp);
      rows1Insert++;
      temp = [];
    }

    _step1 = gridTable.toString();

    StringBuffer additionTable = StringBuffer()
      ..writeln("\nStep 2: Addition Table")
      ..writeln("Note: See bracket values in Step-1 table for below columns");

    List<String> additionRow = [];
    List<String> resultRow = [];
    for (int i = 1; i <= additionDict.keys.length; i++) {
      if (additionDict.containsKey(i)) {
        additionRow.add(additionDict[i]!.join(" + "));
        resultRow.add(additionDict[i]!.reduce((a, b) => a + b).toString());
      } else {
        resultRow.add("0");
      }
    }
    additionTable
      ..writeln(additionRow.join(' | '))
      ..writeln(resultRow.join(' | '));

    rows2.insert(0, [for (int i = 1; i <= resultRow.length; i++) "$i"]);
    rows2.insert(1, additionRow);
    rows2.insert(2, resultRow);

    // print(rows2);

    _step2 = additionTable.toString();

    List<String> carryRow = ['0'];
    List<String> finalResultRow = [];
    List<String> sumRow = [];
    int carry = 0;
    for (int i = resultRow.length - 1; i >= 0; i--) {
      int result = carry + int.parse(resultRow[i]);
      carry = result ~/ 10;
      carryRow.insert(0, carry.toString());
      sumRow.insert(0, result.toString());
      finalResultRow.insert(0, (result % 10).toString());
      if (i == 0) {
        sumRow.insert(0, "");
        finalResultRow.insert(0, (result ~/ 10).toString());
      }
    }

    StringBuffer step3Table = StringBuffer()
      ..writeln("\nStep 3: Intermediate Results with Carry")
      ..writeln("Carry: ${carryRow.join(' | ')}")
      ..writeln("Sum: ${sumRow.join(' | ')}")
      ..writeln("Unit Place: ${finalResultRow.join(' | ')}");

    List<String> resultRow1 = finalResultRow;
    _step3 = step3Table.toString();
    rows3 = [];
    carryRow.insert(0, "Carry");
    rows3.insert(0, carryRow);
    List<String> resultRow2 = resultRow.toList();
    resultRow2.insert(0, "Step 2 Results");
    resultRow2.insert(1, '');
    rows3.insert(1, resultRow2);
    sumRow.insert(0, "Sum");
    rows3.insert(2, sumRow);

    finalResultRow.insert(0, "Result");
    rows3.insert(3, finalResultRow);

    // print(rows3);

    // finalResultRow.removeAt(0);

    String finalAns = resultRow1.join();
    StringBuffer resultTable = StringBuffer()
      ..writeln("\nStep 4: Result Table")
      ..writeln(
          "Calculated Answer: ${finalAns.length > 6 ? finalAns.substring(6) : finalAns}")
      ..writeln("Expected Answer: ${num1 * num2}");

    _step4 = resultTable.toString();

    List<String> result1 = [
      "Calculated Answer",
      (finalAns.length > 6 ? finalAns.substring(6) : finalAns)
    ];
    List<String> result2 = ["Expected Answer", "${num1 * num2}"];
    rows4.add(result1);
    rows4.add(result2);
  }

  Widget _buildStep1() {
    try {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "\nStep 1: Create the multiplication grid",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                // Header Row
                TableRow(
                  children: rows1[0]
                      .map((header) => _buildHeaderCell(header))
                      .toList(),
                ),
                // Data Rows
                ...rows1.sublist(1).map(
                  (row) {
                    return TableRow(
                      children: [
                        // Header Column
                        _buildHeaderCell(row[0]),
                        // Regular Cells
                        ...row.sublist(1).map((cell) => _buildCell(cell)),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      return _buildErrorWidget();
    }
  }

  Widget _buildStep2() {
    try {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Step 2: Addition Table",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Note: See bracket values in Step-1 table for below columns",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                // Header Row (excluding column 0)
                TableRow(
                  children: rows2[0]
                      .sublist(0, 3)
                      .map((header) => _buildHeaderCell(header))
                      .toList(),
                ),
                // Data Rows (excluding column 0)
                ...rows2.sublist(1).map(
                  (row) {
                    final correctedRow =
                        row.sublist(0, 3); // Skip the first column (index 0)
                    return TableRow(
                      children:
                          correctedRow.map((cell) => _buildCell(cell)).toList(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      return _buildErrorWidget();
    }
  }

  Widget _buildStep3() {
    try {
      // Determine the maximum length of rows3
      int maxLength =
          rows3.map((row) => row.length).reduce((a, b) => a > b ? a : b);

      // Ensure all rows have the same length
      for (int i = 0; i < rows3.length; i++) {
        if (rows3[i].length < maxLength) {
          int diff = maxLength - rows3[i].length;
          rows3[i].addAll(
              List<String>.filled(diff, '')); // Add empty cells to fill the row
        }
      }

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Step 3: Intermediate Results with Carry",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Sum row is addition of 'Carry row' and 'Step 2 results row'",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                // Header Row
                TableRow(
                  children: rows3[0]
                      .map((header) => _buildHeaderCell(header))
                      .toList(),
                ),
                // Data Rows
                ...rows3.sublist(1).map(
                  (row) {
                    return TableRow(
                      children: row.map((cell) => _buildCell(cell)).toList(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      return _buildErrorWidget();
    }
  }

  Widget _buildStep4() {
    try {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the formatted text if necessary
            const Text(
              "\nStep 4: Result Table",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Create the Table widget
            Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                // Header Row
                TableRow(
                  children: rows4[0]
                      .map((header) => _buildHeaderCell(header))
                      .toList(),
                ),
                // Data Rows
                ...rows4.sublist(1).map(
                  (row) {
                    return TableRow(
                      children: row.map((cell) => _buildCell(cell)).toList(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      return _buildErrorWidget();
    }
  }

  Widget _buildErrorWidget() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Oops! An error has occurred. We are still trying to update our app.",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Icon(Icons.error, color: Colors.red, size: 50),
        ],
      ),
    );
  }
}

class SquareScreen extends StatefulWidget {
  const SquareScreen({super.key});

  @override
  _SquareScreenState createState() => _SquareScreenState();
}

class _SquareScreenState extends State<SquareScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  List<String> temp = [];
  List<List<String>> rows1 = [];
  int rows1Insert = 0;
  List<List<String>> rows2 = [];
  List<List<String>> rows3 = [];
  List<List<String>> rows4 = [];

  String _step1 = '';
  String _step2 = '';
  String _step3 = '';
  String _step4 = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Square'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.topCenter,
              child: _buildInputField(context, _controller, _errorText),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _validateInput();
                if (_errorText == null && _errorText == null) {
                  setState(() {
                    // Clear existing results
                    _step1 = '';
                    _step2 = '';
                    _step3 = '';
                    _step4 = '';
                    rows1.clear();
                    rows1Insert = 0;
                    rows2.clear();
                    rows3.clear();
                    rows4.clear();

                    // Perform new calculation
                    _calculateMultiplication(
                      int.parse(_controller.text),
                      int.parse(_controller.text),
                    );
                  });
                }
              },
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_step1.isNotEmpty) _buildStep1(),
                    if (_step2.isNotEmpty) _buildStep2(),
                    if (_step3.isNotEmpty) _buildStep3(),
                    if (_step4.isNotEmpty) _buildStep4(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(BuildContext context,
      TextEditingController controller, String? errorText) {
    return SizedBox(
      width: 150,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.yellow,
          border: const OutlineInputBorder(),
          hintText: 'Enter number',
          errorText: errorText,
          errorStyle: const TextStyle(color: Colors.red),
          hintStyle: const TextStyle(color: Colors.black54),
        ),
      ),
    );
  }

  void _validateInput() {
    setState(() {
      _errorText = _controller.text.isEmpty ? 'Field cannot be empty' : null;
    });
  }

  void _calculateMultiplication(int num1, int num2) {
    String xStr = num1.toString();
    String yStr = num2.toString();

    int n = xStr.length;
    int m = yStr.length;

    List<String> uniqueYStr = [
      '',
      for (int idx = 0; idx < yStr.length; idx++) yStr[idx]
    ];
    rows1.insert(rows1Insert, uniqueYStr);
    rows1Insert++;

    Map<int, List<int>> additionDict = {};

    StringBuffer gridTable = StringBuffer();

    for (int i = 0; i < n; i++) {
      gridTable.write('${xStr[i]} | ');
      temp.add(xStr[i]);
      for (int j = 0; j < m; j++) {
        int product = int.parse(xStr[i]) * int.parse(yStr[j]);
        int position = i + j + 1;
        gridTable.write('${xStr[i]} x ${yStr[j]} = $product ($position) | ');
        temp.add('${xStr[i]} x ${yStr[j]} = $product ($position)');

        if (!additionDict.containsKey(position)) {
          additionDict[position] = [];
        }
        additionDict[position]?.add(product);
      }
      gridTable.writeln();
      rows1.insert(rows1Insert, temp);
      rows1Insert++;
      temp = [];
    }

    _step1 = gridTable.toString();

    StringBuffer additionTable = StringBuffer()
      ..writeln("\nStep 2: Addition Table")
      ..writeln("Note: See bracket values in Step-1 table for below columns");

    List<String> additionRow = [];
    List<String> resultRow = [];
    for (int i = 1; i <= additionDict.keys.length; i++) {
      if (additionDict.containsKey(i)) {
        additionRow.add(additionDict[i]!.join(" + "));
        resultRow.add(additionDict[i]!.reduce((a, b) => a + b).toString());
      } else {
        resultRow.add("0");
      }
    }
    additionTable
      ..writeln(additionRow.join(' | '))
      ..writeln(resultRow.join(' | '));

    rows2.insert(0, [for (int i = 1; i <= resultRow.length; i++) "$i"]);
    rows2.insert(1, additionRow);
    rows2.insert(2, resultRow);

    // print(rows2);

    _step2 = additionTable.toString();

    List<String> carryRow = ['0'];
    List<String> finalResultRow = [];
    List<String> sumRow = [];
    int carry = 0;
    for (int i = resultRow.length - 1; i >= 0; i--) {
      int result = carry + int.parse(resultRow[i]);
      carry = result ~/ 10;
      carryRow.insert(0, carry.toString());
      sumRow.insert(0, result.toString());
      finalResultRow.insert(0, (result % 10).toString());
      if (i == 0) {
        sumRow.insert(0, "");
        finalResultRow.insert(0, (result ~/ 10).toString());
      }
    }

    StringBuffer step3Table = StringBuffer()
      ..writeln("\nStep 3: Intermediate Results with Carry")
      ..writeln("Carry: ${carryRow.join(' | ')}")
      ..writeln("Sum: ${sumRow.join(' | ')}")
      ..writeln("Unit Place: ${finalResultRow.join(' | ')}");

    List<String> resultRow1 = finalResultRow;
    _step3 = step3Table.toString();
    rows3 = [];
    carryRow.insert(0, "Carry");
    rows3.insert(0, carryRow);
    List<String> resultRow2 = resultRow.toList();
    resultRow2.insert(0, "Step 2 Results");
    resultRow2.insert(1, '');
    rows3.insert(1, resultRow2);
    sumRow.insert(0, "Sum");
    rows3.insert(2, sumRow);

    finalResultRow.insert(0, "Result");
    rows3.insert(3, finalResultRow);

    // print(rows3);

    // finalResultRow.removeAt(0);

    String finalAns = resultRow1.join();
    StringBuffer resultTable = StringBuffer()
      ..writeln("\nStep 4: Result Table")
      ..writeln(
          "Calculated Answer: ${finalAns.length > 6 ? finalAns.substring(6) : finalAns}")
      ..writeln("Expected Answer: ${num1 * num2}");

    _step4 = resultTable.toString();

    List<String> result1 = [
      "Calculated Answer",
      (finalAns.length > 6 ? finalAns.substring(6) : finalAns)
    ];
    List<String> result2 = ["Expected Answer", "${num1 * num2}"];
    rows4.add(result1);
    rows4.add(result2);
  }

  Widget _buildStep1() {
    try {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "\nStep 1: Create the multiplication grid",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                // Header Row
                TableRow(
                  children: rows1[0]
                      .map((header) => _buildHeaderCell(header))
                      .toList(),
                ),
                // Data Rows
                ...rows1.sublist(1).map(
                  (row) {
                    return TableRow(
                      children: [
                        // Header Column
                        _buildHeaderCell(row[0]),
                        // Regular Cells
                        ...row.sublist(1).map((cell) => _buildCell(cell)),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      return _buildErrorWidget();
    }
  }

  Widget _buildStep2() {
    try {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Step 2: Addition Table",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Note: See bracket values in Step-1 table for below columns",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                // Header Row (excluding column 0)
                TableRow(
                  children: rows2[0]
                      .sublist(0, 3)
                      .map((header) => _buildHeaderCell(header))
                      .toList(),
                ),
                // Data Rows (excluding column 0)
                ...rows2.sublist(1).map(
                  (row) {
                    final correctedRow =
                        row.sublist(0, 3); // Skip the first column (index 0)
                    return TableRow(
                      children:
                          correctedRow.map((cell) => _buildCell(cell)).toList(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      return _buildErrorWidget();
    }
  }

  Widget _buildStep3() {
    try {
      // Determine the maximum length of rows3
      int maxLength =
          rows3.map((row) => row.length).reduce((a, b) => a > b ? a : b);

      // Ensure all rows have the same length
      for (int i = 0; i < rows3.length; i++) {
        if (rows3[i].length < maxLength) {
          int diff = maxLength - rows3[i].length;
          rows3[i].addAll(
              List<String>.filled(diff, '')); // Add empty cells to fill the row
        }
      }

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Step 3: Intermediate Results with Carry",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Sum row is addition of 'Carry row' and 'Step 2 results row'",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                // Header Row
                TableRow(
                  children: rows3[0]
                      .map((header) => _buildHeaderCell(header))
                      .toList(),
                ),
                // Data Rows
                ...rows3.sublist(1).map(
                  (row) {
                    return TableRow(
                      children: row.map((cell) => _buildCell(cell)).toList(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      return _buildErrorWidget();
    }
  }

  Widget _buildStep4() {
    try {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the formatted text if necessary
            const Text(
              "\nStep 4: Result Table",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Create the Table widget
            Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                // Header Row
                TableRow(
                  children: rows4[0]
                      .map((header) => _buildHeaderCell(header))
                      .toList(),
                ),
                // Data Rows
                ...rows4.sublist(1).map(
                  (row) {
                    return TableRow(
                      children: row.map((cell) => _buildCell(cell)).toList(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      return _buildErrorWidget();
    }
  }

  Widget _buildErrorWidget() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Oops! An error has occurred. We are still trying to update our app.",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Icon(Icons.error, color: Colors.red, size: 50),
        ],
      ),
    );
  }
}

class CubeScreen extends StatefulWidget {
  const CubeScreen({super.key});

  @override
  _CubeScreenState createState() => _CubeScreenState();
}

class _CubeScreenState extends State<CubeScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;
  List<int> _results = [];
  List<int> _carry = [];
  List<int> _sum = [];
  final List<String> _units = [];
  String _final = "";


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cube Calculator'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      _buildInputField(context, _controller, _errorText),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _results.clear();
                            _carry.clear();
                            _sum.clear();
                            _units.clear();
                          });
                          _validateInput();
                          if (_errorText == null) {
                            _calculateCubeSteps(_controller.text);
                          }
                        },
                        child: const Text('Calculate Cube'),
                      ),
                      const SizedBox(height: 20),
                      _buildExplanation(),
                      const SizedBox(height: 20),
                      _results.isNotEmpty ? _buildCubeTable() : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputField(BuildContext context,
      TextEditingController controller, String? errorText) {
    return SizedBox(
      width: 150,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.yellow,
          border: const OutlineInputBorder(),
          hintText: 'Enter a number',
          errorText: errorText,
          errorStyle: const TextStyle(color: Colors.red),
          hintStyle: const TextStyle(color: Colors.black54),
        ),
      ),
    );
  }

  Widget _buildExplanation() {
    String explanation = '';
    if (_results.isNotEmpty) {
      final int a = int.parse(_controller.text[0]);
      final int b = int.parse(_controller.text[1]);

      final int a3 = a * a * a; // a³
      final int a2b = 3 * (a * a) * b; // 3a²b
      final int ab2 = 3 * a * (b * b); // 3ab²
      final int b3 = b * b * b; // b³

      explanation = '''
1. Split the number into two parts: a = $a and b = $b.

2. Use the formula: a³ + 3a²b + 3ab² + b³.

   Here:
   - a³: Cube of the first digit.
     - $a³ = $a * $a * $a = $a3

   - 3a²b: Three times the square of the first digit times the second digit.
     - 3 * $a² * $b = 3 * ${a * a} * $b = $a2b

   - 3ab²: Three times the first digit times the square of the second digit.
     - 3 * $a * $b² = 3 * $a * ${b * b} = $ab2

   - b³: Cube of the second digit.
     - $b³ = $b * $b * $b = $b3
    ''';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Steps to Cube a Two-Digit Number:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 10),
        Text(
          explanation,
          style: const TextStyle(fontSize: 18), // Set text size to 20
        ),
      ],
    );
  }

  void _calculateCubeSteps(String number) {


      if (number.length == 2) {
        int a = int.parse(number[0]);
        int b = int.parse(number[1]);

        int a3 = a * a * a; // a³
        int a2b = 3 * (a * a) * b; // 3a²b
        int ab2 = 3 * a * (b * b); // 3ab²
        int b3 = b * b * b; // b³

        _results = [0, a3, a2b, ab2, b3]; // Store the results in the list

        List<int> intermediateSums = [a3, a2b, ab2, b3, 0];
        List<int> carries = List.filled(intermediateSums.length, 0);
        List<int> sums = List.filled(intermediateSums.length, 0);
        List<int> sum1 = List.filled(intermediateSums.length, 0);

        int carry = 0;
        for (int i = intermediateSums.length - 1; i >= 0; i--) {
          int currentSum = intermediateSums[i] + carry;
          carry = currentSum ~/ 10;
          sums[i] = currentSum % 10;
          sum1[i] = currentSum;

          carries[i] = carry;
        }
        // sums[0] = intermediateSums[0] + carry; // Handle the first position separately
        _carry = carries;
        _sum = sum1;
        _units.insert(0, ((sum1[3]%10).toString()));
        _units.insert(0, ((sum1[2]%10).toString()));
        _units.insert(0, ((sum1[1]%10).toString()));
        _units.insert(0, ((sum1[0]%10).toString()));
        _units.insert(0, (((sum1[0] - sum1[0]%10)~/10).toString()));

        // Handle units place separately
        // _units = [sums.fold(0, (prev, element) => prev + element) % 10];
        _final = sums.join();

      } else {
        _errorText = "Enter a valid 2-digit number.";
      }
  }


  Widget _buildCubeTable() {
    return Column(
      children: [
        Table(
          border: TableBorder.all(color: Colors.black),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
            5: FlexColumnWidth(1),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(children: [
              _buildCell("Carry"),
              _buildCell(_carry.isNotEmpty ? _carry[0].toString() : '0'),
              _buildCell(_carry.isNotEmpty ? _carry[1].toString() : '0'),
              _buildCell(_carry.isNotEmpty ? _carry[2].toString() : '0'),
              _buildCell(_carry.isNotEmpty ? _carry[3].toString() : '0'),
              _buildCell("0"),
            ]),
            TableRow(children: [
              _buildCell("Calculation"),
              _buildCell(""),
              _buildCell(_results.isNotEmpty ? "${_results[1]}" : ''),
              _buildCell(_results.isNotEmpty ? "${_results[2]}" : ''),
              _buildCell(_results.isNotEmpty ? "${_results[3]}" : ''),
              _buildCell(_results.isNotEmpty ? "${_results[4]}" : ''),
            ]),
            TableRow(children: [
              _buildCell("Sum"),
              _buildCell(''),
              _buildCell(_sum.isNotEmpty ? _sum[0].toString() : ''),
              _buildCell(_sum.isNotEmpty ? _sum[1].toString() : ''),
              _buildCell(_sum.isNotEmpty ? _sum[2].toString() : ''),
              _buildCell(_sum.isNotEmpty ? _sum[3].toString() : ''),
            ]),
            TableRow(children: [
              _buildCell("Results (Units)"),
              _buildCell(_sum.isNotEmpty ? _units[0] : ''),
              _buildCell(_sum.isNotEmpty ? _units[1] : ''),
              _buildCell(_sum.isNotEmpty ? _units[2] : ''),
              _buildCell(_sum.isNotEmpty ? _units[3] : ''),
              _buildCell(_sum.isNotEmpty ? _units[4] : ''),
            ])
          ],
        ),
        const SizedBox(height: 20),
        _buildFinalResultTable(),
      ],
    );
  }


  Widget _buildFinalResultTable() {
    int expectedResult = _controller.text.length == 2
        ? int.parse(_controller.text) * int.parse(_controller.text) * int.parse(_controller.text)
        : 0;

    String calculatedResult = _units.join();

    return Table(
      border: TableBorder.all(color: Colors.black),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(children: [
          _buildHeaderCell('Expected Result'),
          _buildHeaderCell('Calculated Result'),
        ]),
        TableRow(children: [
          _buildCell(expectedResult.toString()),
          _buildCell(calculatedResult.toString()),
        ]),
      ],
    );
  }

  Widget _buildCell(String text) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text, textAlign: TextAlign.center),
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
  void _validateInput() {
    setState(() {
      _errorText = _controller.text.isEmpty
          ? 'Field cannot be empty'
          : (_controller.text.length != 2 ? 'Please enter a 2-digit number' : null);
      _results.clear();
    });
  }
}


class DivisionScreen extends StatefulWidget {
  const DivisionScreen({super.key});

  @override
  _DivisionScreenState createState() => _DivisionScreenState();
}

class _DivisionScreenState extends State<DivisionScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  String? _errorText1;
  String? _errorText2;
  List<String> _steps = [];
  String? _result;

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Division Using Dhwajank Method'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInputField(context, _controller1, _errorText1),
                Text(
                  '/',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                _buildInputField(context, _controller2, _errorText2),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _validateInputs();
                if (_errorText1 == null && _errorText2 == null) {
                  _performDivision();
                }
              },
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),
            if (_steps.isNotEmpty)
              ..._steps.map((step) => Text(
                step,
                style: TextStyle(
                  fontSize: 18,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              )),
            if (_result != null)
              Text(
                'Result: $_result',
                style: TextStyle(
                  fontSize: 20,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(BuildContext context,
      TextEditingController controller, String? errorText) {
    return SizedBox(
      width: 100,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.yellow,
          border: const OutlineInputBorder(),
          hintText: 'Enter number',
          errorText: errorText,
          errorStyle: const TextStyle(color: Colors.red),
          hintStyle: const TextStyle(color: Colors.black54),
        ),
      ),
    );
  }

  void _validateInputs() {
    setState(() {
      _errorText1 = _controller1.text.isEmpty ? 'Field cannot be empty' : null;
      _errorText2 = _controller2.text.isEmpty ? 'Field cannot be empty' : null;
      if (_controller2.text.isNotEmpty &&
          int.tryParse(_controller2.text) == 0) {
        _errorText2 = 'Cannot divide by zero';
      }
    });
  }

  void _performDivision() {
    setState(() {
      final num1 = int.tryParse(_controller1.text) ?? 0;
      final num2 = int.tryParse(_controller2.text) ?? 1;

      if (num2 == 0) {
        _result = 'Cannot divide by zero';
        _steps = [];
        return;
      }

      _steps = [];
      int dividend = num1;
      int divisor = num2;
      int quotient = 0;
      int remainder = 0;

      int divisorDigit = divisor;
      int dividendPart = dividend;

      while (dividendPart >= divisor) {
        int tempDivisor = divisorDigit;
        int tempDividend = dividendPart;

        int partialQuotient = 0;
        int currentStep = 0;

        while (tempDividend >= tempDivisor) {
          tempDivisor *= 10;
          partialQuotient++;
          currentStep++;
        }

        tempDivisor ~/= 10;
        partialQuotient--;

        int partQuotient = tempDividend ~/ tempDivisor;
        int tempRemainder = tempDividend - (partQuotient * tempDivisor);

        quotient = quotient * 10 + partQuotient;
        remainder = tempRemainder;

        dividendPart = remainder;

        _steps.add('Divide part $dividendPart by $divisor: Quotient part = $partQuotient');
        _steps.add('Remaining: $remainder');
      }

      _result = quotient.toString();
    });
  }
}

class DivisibilityTestScreen extends StatefulWidget {
  const DivisibilityTestScreen({super.key});

  @override
  _DivisibilityTestScreenState createState() => _DivisibilityTestScreenState();
}

class _DivisibilityTestScreenState extends State<DivisibilityTestScreen> {
  String _selectedDivisor = '2'; // Default divisor
  final TextEditingController _numberController = TextEditingController();
  String? _numberErrorText;
  String _resultText = "";

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Divisibility Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Input field
                Expanded(
                  flex: 1,
                  child: _buildInputField(
                      context, _numberController, _numberErrorText),
                ),
                const SizedBox(width: 20),
                // Dropdown
                Expanded(
                  flex: 1,
                  child: DropdownButton<String>(
                    value: _selectedDivisor,
                    items: ['2', '3', '4', '5', '6', '7', '8', '9', '11', '12']
                        .map((divisor) => DropdownMenuItem<String>(
                              value: divisor,
                              child: Text(divisor),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDivisor = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Calculate button
            ElevatedButton(
              onPressed: () {
                _validateInput();
                if (_numberErrorText == null) {
                  // Parse the text as an integer and pass it to the _calculateDivisibility function
                  int? number = int.tryParse(_numberController.text);
                  if (number != null) {
                    _calculateDivisibility(number);
                  } else {
                    setState(() {
                      _numberErrorText = 'Please enter a valid number';
                    });
                  }
                }
              },
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),
            // Result display
            Text(
              _resultText,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(BuildContext context,
      TextEditingController controller, String? errorText) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.yellow,
        border: const OutlineInputBorder(),
        hintText: 'Enter number',
        errorText: errorText,
        errorStyle: const TextStyle(color: Colors.red),
        hintStyle: const TextStyle(color: Colors.black54),
      ),
    );
  }

  void _validateInput() {
    setState(() {
      _numberErrorText =
          _numberController.text.isEmpty ? 'Field cannot be empty' : null;
    });
  }

  void _calculateDivisibility(int number) {
    int divisor = int.parse(_selectedDivisor);
    _displayDivisibility(number, divisor);
  }

  void _displayDivisibility(int number, int divisor) {
    setState(() {
      if (divisor == 2) {
        // Divisibility by 2 logic
        _resultText =
            "Check if the units place of the number consists of 0, 2, 4, 6, or 8.\nIf any of these numbers appears at the unit's place, the number is divisible by 2.";
        if (number % 2 == 0) {
          _resultText += "\n\nThe number $number is divisible by 2.";
        } else {
          _resultText += "\n\nThe number $number is not divisible by 2.";
        }
      } else if (divisor == 3) {
        // Divisibility by 3 logic
        List<int> digits =
            number.toString().split('').map((char) => int.parse(char)).toList();

        int sumOfDigits = digits.reduce((a, b) => a + b);

        String digitSumProcess =
            digits.map((digit) => digit.toString()).join(' + ');

        _resultText =
            "Calculate the sum of the digits of the number: $digitSumProcess = $sumOfDigits";

        if (sumOfDigits % 3 == 0) {
          _resultText +=
              "\n\nSince the sum of digits $sumOfDigits is divisible by 3, the number $number is divisible by 3.";
        } else {
          _resultText +=
              "\n\nSince the sum of digits $sumOfDigits is not divisible by 3, the number $number is not divisible by 3.";
        }
      } else if (divisor == 4) {
        // Divisibility by 4 logic
        String lastTwoDigitsStr = number.toString().length >= 2
            ? number.toString().substring(number.toString().length - 2)
            : number
                .toString(); // Get last two digits or the full number if it's less than 2 digits

        int lastTwoDigits = int.parse(lastTwoDigitsStr);

        _resultText =
            "For divisibility by 4, check if the last two digits of the number ($lastTwoDigitsStr) are divisible by 4.\n";

        if (lastTwoDigits % 4 == 0) {
          _resultText +=
              "\nSince $lastTwoDigits is divisible by 4, the number $number is divisible by 4.";
        } else {
          _resultText +=
              "\nSince $lastTwoDigits is not divisible by 4, the number $number is not divisible by 4.";
        }
      } else if (divisor == 5) {
        _resultText =
            "Check if the units place of the number consists of 0 or 5.\nIf any of these numbers appears at the unit's place, the number is divisible by 5.";
        if (number % 5 == 0) {
          _resultText += "\n\nThe number $number is divisible by 5.";
        } else {
          _resultText += "\n\nThe number $number is not divisible by 5.";
        }
      } else if (divisor == 6) {
        // Divisibility by 6 logic
        bool divisibleBy2 = number % 2 == 0; // Check divisibility by 2
        List<int> digits =
            number.toString().split('').map((char) => int.parse(char)).toList();

        int sumOfDigits = digits.reduce((a, b) => a + b); // Sum of digits
        bool divisibleBy3 = sumOfDigits % 3 == 0; // Check divisibility by 3

        _resultText = "For divisibility by 6:\n";

        // Check divisibility by 2
        if (divisibleBy2) {
          _resultText +=
              "1. The number is divisible by 2 (last digit is even).\n";
        } else {
          _resultText +=
              "1. The number is not divisible by 2 (last digit is not even).\n";
        }

        // Check divisibility by 3
        String digitSumProcess =
            digits.map((digit) => digit.toString()).join(' + ');
        _resultText +=
            "2. Calculate the sum of digits: $digitSumProcess = $sumOfDigits.\n";

        if (divisibleBy3) {
          _resultText += "The sum of digits $sumOfDigits is divisible by 3.\n";
        } else {
          _resultText +=
              "The sum of digits $sumOfDigits is not divisible by 3.\n";
        }

        // Final result for divisibility by 6
        if (divisibleBy2 && divisibleBy3) {
          _resultText +=
              "\nSince the number is divisible by both 2 and 3, the number $number is divisible by 6.";
        } else {
          _resultText +=
              "\nSince the number is not divisible by both 2 and 3, the number $number is not divisible by 6.";
        }
      } else if (divisor == 7) {
        // Divisibility by 7 logic
        int lastDigit = number % 10; // Get the last digit
        int remainingPart =
            number ~/ 10; // Get the number without the last digit
        int modifiedNumber = remainingPart - (2 * lastDigit); // Apply the rule

        _resultText =
            "For divisibility by 7, take the last digit ($lastDigit), multiply it by 2, and subtract it from the rest of the number ($remainingPart).\n";
        _resultText +=
            "The result is: $remainingPart - 2 * $lastDigit = $modifiedNumber.\n";

        // Check if the result is divisible by 7
        if (modifiedNumber % 7 == 0) {
          _resultText +=
              "\nSince $modifiedNumber is divisible by 7, the number $number is divisible by 7.";
        } else {
          _resultText +=
              "\nSince $modifiedNumber is not divisible by 7, the number $number is not divisible by 7.";
        }
      } else if (divisor == 8) {
        // Divisibility by 8 logic
        String lastThreeDigitsStr = number.toString().length >= 3
            ? number.toString().substring(number.toString().length - 3)
            : number
                .toString(); // Get last three digits or the full number if it's less than 3 digits

        int lastThreeDigits = int.parse(lastThreeDigitsStr);

        _resultText =
            "For divisibility by 8, check if the number formed by the last three digits ($lastThreeDigitsStr) is divisible by 8.\n";

        if (lastThreeDigits % 8 == 0) {
          _resultText +=
              "\nSince $lastThreeDigits is divisible by 8, the number $number is divisible by 8.";
        } else {
          _resultText +=
              "\nSince $lastThreeDigits is not divisible by 8, the number $number is not divisible by 8.";
        }
      } else if (divisor == 9) {
        // Divisibility by 9 logic
        List<int> digits =
            number.toString().split('').map((char) => int.parse(char)).toList();

        int sumOfDigits = digits.reduce((a, b) => a + b);

        String digitSumProcess =
            digits.map((digit) => digit.toString()).join(' + ');

        _resultText =
            "Calculate the sum of the digits of the number: $digitSumProcess = $sumOfDigits";

        if (sumOfDigits % 9 == 0) {
          _resultText +=
              "\n\nSince the sum of digits $sumOfDigits is divisible by 9, the number $number is divisible by 9.";
        } else {
          _resultText +=
              "\n\nSince the sum of digits $sumOfDigits is not divisible by 9, the number $number is not divisible by 9.";
        }
      } else if (divisor == 10) {
        _resultText =
            "Check if the units place of the number consists of 0.\nIf 0 appears at the unit's place, the number is divisible by 10.";
        if (number % 10 == 0) {
          _resultText += "\n\nThe number $number is divisible by 10.";
        } else {
          _resultText += "\n\nThe number $number is not divisible by 10.";
        }
      } else if (divisor == 11) {
        // Divisibility by 11 logic
        List<int> digits =
            number.toString().split('').map((char) => int.parse(char)).toList();

        int sumOddPlaces = 0;
        int sumEvenPlaces = 0;

        for (int i = 0; i < digits.length; i++) {
          if ((i + 1) % 2 == 0) {
            // Even place
            sumEvenPlaces += digits[i];
          } else {
            // Odd place
            sumOddPlaces += digits[i];
          }
        }

        int difference =
            (sumOddPlaces - sumEvenPlaces).abs(); // Get absolute difference

        _resultText =
            "For divisibility by 11, calculate the sum of digits at odd places and even places.\n";
        _resultText +=
            "Sum of digits at odd places: $sumOddPlaces\nSum of digits at even places: $sumEvenPlaces\n";
        _resultText +=
            "Difference: |$sumOddPlaces - $sumEvenPlaces| = $difference\n";

        if (difference % 11 == 0) {
          _resultText +=
              "\nSince $difference is divisible by 11, the number $number is divisible by 11.";
        } else {
          _resultText +=
              "\nSince $difference is not divisible by 11, the number $number is not divisible by 11.";
        }
      } else if (divisor == 12) {
        // Divisibility by 12 logic
        bool divisibleBy3 = false;
        bool divisibleBy4 = false;

        // Divisibility by 3 logic (sum of digits divisible by 3)
        List<int> digits =
            number.toString().split('').map((char) => int.parse(char)).toList();
        int sumOfDigits = digits.reduce((a, b) => a + b);

        if (sumOfDigits % 3 == 0) {
          divisibleBy3 = true;
        }

        // Divisibility by 4 logic (last two digits divisible by 4)
        String lastTwoDigitsStr = number.toString().length >= 2
            ? number.toString().substring(number.toString().length - 2)
            : number
                .toString(); // Get last two digits or full number if < 2 digits
        int lastTwoDigits = int.parse(lastTwoDigitsStr);

        if (lastTwoDigits % 4 == 0) {
          divisibleBy4 = true;
        }

        _resultText =
            "For divisibility by 12, the number must be divisible by both 3 and 4.\n";
        _resultText +=
            "1. Check divisibility by 3: Sum of digits = $sumOfDigits.\n";
        _resultText += divisibleBy3
            ? "Since $sumOfDigits is divisible by 3, the number is divisible by 3.\n"
            : "Since $sumOfDigits is not divisible by 3, the number is not divisible by 3.\n";

        _resultText +=
            "2. Check divisibility by 4: Last two digits = $lastTwoDigits.\n";
        _resultText += divisibleBy4
            ? "Since $lastTwoDigits is divisible by 4, the number is divisible by 4.\n"
            : "Since $lastTwoDigits is not divisible by 4, the number is not divisible by 4.\n";

        if (divisibleBy3 && divisibleBy4) {
          _resultText +=
              "\nSince the number is divisible by both 3 and 4, it is divisible by 12.";
        } else {
          _resultText +=
              "\nSince the number is not divisible by both 3 and 4, it is not divisible by 12.";
        }
      }
    });
  }
}

class HCFScreen extends StatefulWidget {
  const HCFScreen({super.key});

  @override
  _HCFScreenState createState() => _HCFScreenState();
}

class _HCFScreenState extends State<HCFScreen> {
  final List<TextEditingController> _controllers = [];
  final List<String?> _errorTexts = [];
  final List<String> _results = [];

  int _selectedNumberOfInputs = 2;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _initializeControllers() {
    _controllers.clear();
    _errorTexts.clear();
    for (int i = 0; i < _selectedNumberOfInputs; i++) {
      _controllers.add(TextEditingController());
      _errorTexts.add(null);
    }
  }

  void _disposeControllers() {
    for (final controller in _controllers) {
      controller.dispose();
    }
  }

  void _validateInputs() {
    setState(() {
      _errorTexts.clear();
      for (int i = 0; i < _controllers.length; i++) {
        _errorTexts
            .add(_controllers[i].text.isEmpty ? 'Field cannot be empty' : null);
      }
    });
  }

  List<int> _computeDifferences(List<int> numbers) {
    final List<int> differences = [];
    for (int i = 0; i < numbers.length; i++) {
      for (int j = i + 1; j < numbers.length; j++) {
        differences.add((numbers[j] - numbers[i]).abs());
      }
    }
    return differences;
  }


  List<int> _findFactors(int number) {
    final List<int> factors = [];
    for (int i = 1; i <= number; i++) {
      if (number % i == 0) factors.add(i);
    }
    return factors;
  }

  void _calculateHCF() {
    _validateInputs();

    if (_errorTexts.any((text) => text != null)) {
      setState(() {
        _results.clear();
      });
      return;
    }

    final List<int> numbers = _controllers.map((c) => int.parse(c.text)).toList();
    final List<int> differences = _computeDifferences(numbers);
    final int minDifference = differences.isNotEmpty
        ? differences.reduce((a, b) => a < b ? a : b)
        : 0;
    final List<int> factors = _findFactors(minDifference).reversed.toList();

    setState(() {
      _results.clear();
      _results.add('Differences between numbers: ${differences.join(', ')}');
      _results.add('Minimum difference: $minDifference');
      _results.add('Factors of difference:\n$factors');
      _results.add('Testing if each number is multiple of factor \n(Start from the largest factor)');

      if (minDifference == 0) {
        _results.add('All numbers are identical.');
        return;
      }

      for (int factor in factors) {
        bool isDivisible = numbers.every((number) => number % factor == 0);
        if (isDivisible) {
          _results.add('HCF found: $factor');
          return;  // Exit as soon as we find the largest factor that divides all numbers
        }
        else {
          _results.add('$factor is not multiple of each number');
        }
      }

      _results.add('No common factor found.');
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Highest Common Factor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            _buildDropdown(),
            const SizedBox(height: 20),
            _buildInputRow(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateHCF,
              child: const Text('Calculate HCF'),
            ),
            const SizedBox(height: 20),
            ..._results.map((result) => Text(
                result,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButton<int>(
      value: _selectedNumberOfInputs,
      items: List.generate(4, (index) => index + 2).map((value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text('$value inputs'),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedNumberOfInputs = value;
            _initializeControllers();
          });
        }
      },
    );
  }

  Widget _buildInputRow() {
    final inputFields = List.generate(_selectedNumberOfInputs, (index) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: TextField(
            controller: _controllers[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.yellow,
              border: const OutlineInputBorder(),
              hintText: 'Enter number',
              errorText: _errorTexts[index],
              errorStyle: const TextStyle(color: Colors.red),
              hintStyle: const TextStyle(color: Colors.black54),
            ),
          ),
        ),
      );
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: inputFields,
    );
  }
}

class PolynomialMultiplicationScreen extends StatefulWidget {
  const PolynomialMultiplicationScreen({super.key});

  @override
  _PolynomialMultiplicationScreenState createState() =>
      _PolynomialMultiplicationScreenState();
}

class _PolynomialMultiplicationScreenState extends State<PolynomialMultiplicationScreen> {
  int _degree1 = 2; // Default degree for the first polynomial
  int _degree2 = 2; // Default degree for the second polynomial

  final List<TextEditingController> _controllers1 = [];
  final List<TextEditingController> _controllers2 = [];

  List<String> _steps = [];
  String? _result;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _controllers1.clear();
    _controllers2.clear();

    for (int i = 0; i < _degree1; i++) {
      _controllers1.add(TextEditingController());
    }

    for (int i = 0; i < _degree2; i++) {
      _controllers2.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiplication of Polynomial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Row for Degree Dropdowns
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<int>(
                  value: _degree1,
                  items: List.generate(4, (index) => index + 2)
                      .map((degree) => DropdownMenuItem<int>(
                    value: degree,
                    child: Text(degree.toString()),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _degree1 = value!;
                      _initializeControllers();
                    });
                  },
                ),
                DropdownButton<int>(
                  value: _degree2,
                  items: List.generate(4, (index) => index + 2)
                      .map((degree) => DropdownMenuItem<int>(
                    value: degree,
                    child: Text(degree.toString()),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _degree2 = value!;
                      _initializeControllers();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Row for First Polynomial Inputs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                _degree1,
                    (index) => SizedBox(
                  width: 80,
                  child: TextField(
                    controller: _controllers1[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.yellow,
                      border: const OutlineInputBorder(),
                      hintText: 'x${_superscript(_degree1 - index - 1)}',
                      hintStyle: const TextStyle(color: Colors.black54),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Row for Second Polynomial Inputs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                _degree2,
                    (index) => SizedBox(
                  width: 80,
                  child: TextField(
                    controller: _controllers2[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blue,
                      border: const OutlineInputBorder(),
                      hintText: 'x${_superscript(_degree1 - index - 1)}',
                      hintStyle: const TextStyle(color: Colors.black54),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Calculate Button
            ElevatedButton(
              onPressed: () {
                _calculatePolynomialMultiplication();
              },
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),
            // Display Steps and Result
            if (_steps.isNotEmpty)
              ..._steps.map((step) => Text(
                step,
                style: const TextStyle(fontSize: 18),
              )),
            if (_result != null)
              Text(
                'Result: $_result',
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _calculatePolynomialMultiplication() {
    setState(() {
      final coefficients1 = _controllers1
          .map((controller) => int.tryParse(controller.text) ?? 0)
          .toList();
      final coefficients2 = _controllers2
          .map((controller) => int.tryParse(controller.text) ?? 0)
          .toList();

      // Prepare polynomials as lists of coefficients
      final poly1 = coefficients1;
      final poly2 = coefficients2;

      // Initialize result polynomial
      final resultDegree = _degree1 + _degree2 - 2;
      final resultPoly = List<int>.filled(resultDegree + 1, 0);

      // Calculate polynomial multiplication
      _steps = [];
      _steps.add('Polynomial 1: ${_formatPolynomial(poly1)}');
      _steps.add('Polynomial 2: ${_formatPolynomial(poly2)}');

      final step1 = '(${_formatPolynomial(poly1)}) * (${_formatPolynomial(poly2)})';
      _steps.add(step1);

      String intermediateSteps = '';
      for (int i = 0; i < poly1.length; i++) {
        for (int j = 0; j < poly2.length; j++) {
          final product = poly1[i] * poly2[j];
          resultPoly[i + j] += product;
          intermediateSteps += '${poly1[i]}x${_superscript(_degree1 - i - 1)} * ${poly2[j]}x${_superscript(_degree2 - j - 1)} + ';
        }
      }
      // Remove the trailing ' + ' and add final steps
      intermediateSteps = intermediateSteps.substring(0, intermediateSteps.length - 3);

      _steps.add(
        intermediateSteps,
      );
      _steps.add('Result Polynomial: ${_formatPolynomial(resultPoly)}');
      _result = _formatPolynomial(resultPoly);
    });
  }

  String _formatPolynomial(List<int> coefficients) {
    final terms = <String>[];
    for (int i = 0; i < coefficients.length; i++) {
      if (coefficients[i] != 0) {
        final degree = coefficients.length - i - 1;
        String term;
        if (degree > 1) {
          term = '${coefficients[i]}x${_superscript(degree)}';
        } else if (degree == 1) {
          term = '${coefficients[i]}x';
        } else {
          term = '${coefficients[i]}';
        }
        terms.add(term);
      }
    }
    return terms.join(' + ').replaceAll('+ -', '- ');
  }

  String _superscript(int number) {
    final superscripts = {
      0: '⁰',
      1: '¹',
      2: '²',
      3: '³',
      4: '⁴',
      5: '⁵',
      6: '⁶',
      7: '⁷',
      8: '⁸',
      9: '⁹'
    };

    final digits = number.toString().split('').map((d) => superscripts[int.parse(d)]!).join('');
    return digits;
  }
}


class PolynomialDivisionScreen extends StatefulWidget {
  const PolynomialDivisionScreen({super.key});

  @override
  _PolynomialDivisionScreenState createState() =>
      _PolynomialDivisionScreenState();
}

class _PolynomialDivisionScreenState extends State<PolynomialDivisionScreen> {
  int _degree1 = 2; // Default degree for the first polynomial
  int _degree2 = 2; // Default degree for the second polynomial

  final List<TextEditingController> _controllers1 = [];
  final List<TextEditingController> _controllers2 = [];
  final List<String> _divisionSteps = [];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _controllers1.clear();
    _controllers2.clear();

    for (int i = 0; i < _degree1 + 1; i++) {
      _controllers1.add(TextEditingController());
    }

    for (int i = 0; i < _degree2 + 1; i++) {
      _controllers2.add(TextEditingController());
    }
  }

  void _performDivision() {
    // Clear previous division steps
    _divisionSteps.clear();

    // Parse inputs from TextFields
    List<double> dividend = List.generate(
      _degree1 + 1,
          (index) => double.tryParse(_controllers1[index].text) ?? 0.0,
    );
    List<double> divisor = List.generate(
      _degree2 + 1,
          (index) => double.tryParse(_controllers2[index].text) ?? 0.0,
    );

    // Initialize quotient and remainder
    List<double> quotient = List.filled(_degree1 - _degree2 + 1, 0.0);
    List<double> remainder = List.from(dividend);

    // Polynomial Division Algorithm
    for (int i = 0; i <= _degree1 - _degree2; i++) {
      // Find the leading term of the quotient
      quotient[i] = remainder[i] / divisor[0];

      // Generate the multiplication term for subtraction
      List<double> subtraction = List.filled(remainder.length, 0.0);
      for (int j = 0; j <= _degree2; j++) {
        subtraction[i + j] = quotient[i] * divisor[j];
      }

      // Subtract from the remainder
      for (int k = 0; k < remainder.length; k++) {
        remainder[k] -= subtraction[k];
      }

      // Store the current step for display
      _divisionSteps.add(
        "Step ${i + 1}: Quotient term = ${quotient[i]}x^${_degree1 - _degree2 - i}, Remainder = $remainder",
      );
    }

    // Store final result
    String quotientString = quotient.map((q) => q.toString()).join('x^');
    String remainderString = remainder.map((r) => r.toString()).join('x^');
    _divisionSteps.add("Final Quotient: $quotientString");
    _divisionSteps.add("Final Remainder: $remainderString");

    // Update UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Division of Polynomial'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Row for Degree Dropdowns
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Dropdown for the first polynomial's degree
                  DropdownButton<int>(
                    value: _degree1,
                    items: List.generate(5, (index) => index + 2) // Degrees 2 to 6
                        .map((degree) => DropdownMenuItem<int>(
                      value: degree,
                      child: Text(degree.toString()),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _degree1 = value!;
                        // Ensure _degree2 doesn't exceed _degree1
                        if (_degree2 > _degree1) {
                          _degree2 = _degree1;
                        }
                        _initializeControllers();
                      });
                    },
                  ),
                  // Dropdown for the second polynomial's degree
                  DropdownButton<int>(
                    value: _degree2,
                    items: List.generate(_degree1, (index) => index + 1) // Degrees 1 to _degree1
                        .map((degree) => DropdownMenuItem<int>(
                      value: degree,
                      child: Text(degree.toString()),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _degree2 = value!;
                        _initializeControllers();
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Row for First Polynomial Inputs
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  _degree1 + 1,
                      (index) => SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _controllers1[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.yellow,
                        border: const OutlineInputBorder(),
                        hintText: 'x^${_degree1 - index}', // Display as x^4, x^3, etc.
                        hintStyle: const TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Row for Second Polynomial Inputs
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  _degree2 + 1,
                      (index) => SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _controllers2[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blue,
                        border: const OutlineInputBorder(),
                        hintText: 'x^${_degree2 - index}', // Display as x^3, x^2, etc.
                        hintStyle: const TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Calculate Button
              ElevatedButton(
                onPressed: () {
                  _performDivision();
                },
                child: const Text('Calculate'),
              ),
              const SizedBox(height: 20),
              // Display Steps
              _divisionSteps.isNotEmpty
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _divisionSteps
                    .map((step) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(step),
                ))
                    .toList(),
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}


class LinearEquationScreen extends StatefulWidget {
  const LinearEquationScreen({super.key});

  @override
  _LinearEquationScreenState createState() => _LinearEquationScreenState();
}

class _LinearEquationScreenState extends State<LinearEquationScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  final TextEditingController _controller6 = TextEditingController();

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    _controller6.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Linear Equation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Label for the Linear Equation
            const Text(
              'ax + by = c',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Row for Yellow Input Boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInputField(_controller1, Colors.yellow, 'a1'),
                _buildInputField(_controller2, Colors.yellow, 'b1'),
                _buildInputField(_controller3, Colors.yellow, 'c1'),
              ],
            ),
            const SizedBox(height: 20),
            // Row for Blue Input Boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInputField(_controller4, Colors.blue, 'a2'),
                _buildInputField(_controller5, Colors.blue, 'b2'),
                _buildInputField(_controller6, Colors.blue, 'c2'),
              ],
            ),
            const SizedBox(height: 20),
            // Calculate Button
            ElevatedButton(
              onPressed: () {
                // Calculation logic will go here
              },
              child: const Text('Calculate'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
      TextEditingController controller, Color color, String hint) {
    return SizedBox(
      width: 80,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: color,
          border: const OutlineInputBorder(),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black54),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}

class QuadraticEquationScreen extends StatefulWidget {
  const QuadraticEquationScreen({super.key});

  @override
  _QuadraticEquationScreenState createState() =>
      _QuadraticEquationScreenState();
}

class _QuadraticEquationScreenState extends State<QuadraticEquationScreen> {
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerB = TextEditingController();
  final TextEditingController _controllerC = TextEditingController();

  final List<String> _steps = [];

  @override
  void dispose() {
    _controllerA.dispose();
    _controllerB.dispose();
    _controllerC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quadratic Equation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Label for the Quadratic Equation
            const Text(
              'ax² + bx + c = 0',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Row for Input Boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInputField(_controllerA, 'a'),
                _buildInputField(_controllerB, 'b'),
                _buildInputField(_controllerC, 'c'),
              ],
            ),
            const SizedBox(height: 20),
            // Calculate Button
            ElevatedButton(
              onPressed: _calculateQuadraticEquation,
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 20),
            // Display Steps
            Expanded(
              child: ListView(
                children: _steps.map((step) => Text(
                  step,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hint) {
    return SizedBox(
      width: 80,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.yellow,
          border: const OutlineInputBorder(),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black54),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
        ],
      ),
    );
  }

  void _calculateQuadraticEquation() {
    setState(() {
      _steps.clear();

      final a = int.tryParse(_controllerA.text) ?? 1;
      final b = int.tryParse(_controllerB.text) ?? 0;
      final c = int.tryParse(_controllerC.text) ?? 0;

      if (a == 0) {
        _steps.add('Coefficient "a" cannot be zero.');
        return;
      }

      // Step 1: Display Polynomial
      _steps.add('Polynomial: \n${_formatPolynomial(a, b, c)}');

      // Step 2: Find Factors of a * c
      final ac = a * c;
      final factorPairs = _findFactorPairs(ac);
      _steps.add('Factor pairs of $ac: \n${factorPairs.map((p) => '(${p[0]}, ${p[1]})').join(', ')}');

      // Step 3: Find Factor Pair that Sums to b
      final pair = _findPairSummingToB(factorPairs, b);
      if (pair.isEmpty) {
        _steps.add('This quadratic equation cannot be solved by simple factorization.');
        return;
      }
      _steps.add('Required pair: \n(${pair[0]}, ${pair[1]})');

      // Step 4: Rewrite Polynomial with Factors
      final term1 = pair[0];
      final term2 = pair[1];
      final rewritten = '${a}x² + ${term1}x + ${term2}x + $c';
      _steps.add('Rewritten Polynomial: \n$rewritten');

      // Step 5: Factor by Grouping
      final factoredForm = _factorByGrouping(a, term1, term2, c);
      _steps.add('Factored Form: \n$factoredForm');
    });
  }

  String _formatPolynomial(int a, int b, int c) {
    final terms = <String>[];
    if (a != 0) terms.add('${a}x²');
    if (b != 0) terms.add('${b}x');
    if (c != 0) terms.add('$c');
    return terms.join(' + ').replaceAll('+ -', '- ');
  }

  List<List<int>> _findFactorPairs(int number) {
    final factorPairs = <List<int>>[];
    for (int i = 1; i <= number.abs(); i++) {
      if (number % i == 0) {
        factorPairs.add([i, number ~/ i]);
        factorPairs.add([-i, -(number ~/ i)]); // Include negative factor pairs
      }
    }
    return factorPairs;
  }

  List<int> _findPairSummingToB(List<List<int>> factorPairs, int sum) {
    for (var pair in factorPairs) {
      if (pair[0] + pair[1] == sum) {
        return pair;
      }
    }
    return [];
  }

  String _factorByGrouping(int a, int term1, int term2, int c) {
    // Group the terms and factor by grouping
    // First group: a*x² + term1*x
    // Second group: term2*x + c
    final gcf1 = _gcd(a, term1);  // Find GCF of first group
    final gcf2 = _gcd(term2, c);  // Find GCF of second group

    // Ensure the signs are handled properly based on the GCF
    final binomial1 = '${gcf1}x(${a ~/ gcf1}x + ${term1 ~/ gcf1})';

    // If the GCF of the second group is negative, adjust the sign
    final gcf2SignAdjusted = term2 < 0 ? -gcf2 : gcf2;
    final binomial2 = '$gcf2SignAdjusted(${term2 ~/ gcf2SignAdjusted}x + ${c ~/ gcf2SignAdjusted})';

    // The common factor binomial
    final commonFactor = '${a ~/ gcf1}x + ${term1 ~/ gcf1}';

    return '($commonFactor)(${gcf1}x + $gcf2SignAdjusted)';
  }

  int _gcd(int a, int b) {
    a = a.abs();
    b = b.abs();
    while (b != 0) {
      final temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

}


class CubicPolynomialScreen extends StatefulWidget {
  const CubicPolynomialScreen({super.key});

  @override
  _CubicPolynomialScreenState createState() => _CubicPolynomialScreenState();
}

class _CubicPolynomialScreenState extends State<CubicPolynomialScreen> {
  final TextEditingController _controllerA = TextEditingController();
  final TextEditingController _controllerB = TextEditingController();
  final TextEditingController _controllerC = TextEditingController();
  final TextEditingController _controllerD = TextEditingController();

  @override
  void dispose() {
    _controllerA.dispose();
    _controllerB.dispose();
    _controllerC.dispose();
    _controllerD.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cubic Polynomial Factorization'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Label for the Cubic Polynomial Equation
            const Text(
              'ax³ + bx² + cx + d = 0',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Row for Input Boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInputField(_controllerA, 'a'),
                _buildInputField(_controllerB, 'b'),
                _buildInputField(_controllerC, 'c'),
                _buildInputField(_controllerD, 'd'),
              ],
            ),
            const SizedBox(height: 20),
            // Calculate Button
            ElevatedButton(
              onPressed: () {
                // Calculation logic will go here
              },
              child: const Text('Calculate'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hint) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.yellow,
          border: const OutlineInputBorder(),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black54),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}

class MagicSquaresScreen extends StatefulWidget {
  const MagicSquaresScreen({super.key});

  @override
  _MagicSquaresScreenState createState() => _MagicSquaresScreenState();
}

class _MagicSquaresScreenState extends State<MagicSquaresScreen> {
  int _selectedSize = 3; // Default size for the magic square
  int _magicSum = 0;
  int _yValue = 0;
  List<List<int>> magicSquare = [];
  List<List<String>> calculationTable = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magic Squares'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton<int>(
                value: _selectedSize,
                items: List.generate(8, (index) => index + 3)
                    .map((size) => DropdownMenuItem<int>(
                  value: size,
                  child: Text(size.toString()),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSize = value!;
                  });
                },
                isExpanded: true,
                hint: const Text('Select Size'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    magicSquareCalc(_selectedSize);
                  });
                },
                child: const Text('Calculate'),
              ),
              const SizedBox(height: 20),
              Text('x = $_selectedSize, y = $_yValue, magic_sum = $_magicSum\n'),
              const SizedBox(height: 20),
              const Text('Calculation Table:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              // Text('Calculation Table (showing x, y coordinates):', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              calculationTable.isNotEmpty
                  ? Column(
                children: List.generate(
                  calculationTable.length,
                      (i) => Text(
                    calculationTable[i].join(' '),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              )
                  : const Text('No table calculated yet'),
              // const SizedBox(height: 20),
              // Text('Magic Square:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              // magicSquare.isNotEmpty
              //     ? Column(
              //   children: List.generate(
              //     _selectedSize,
              //         (i) => Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: List.generate(
              //         _selectedSize,
              //             (j) => Container(
              //           width: 50,
              //           height: 50,
              //           alignment: Alignment.center,
              //           decoration: BoxDecoration(
              //             border: Border.all(color: Colors.black),
              //           ),
              //           child: Text(
              //             '${magicSquare[i][j]}',
              //             style: const TextStyle(fontSize: 18),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // )
              //     : const Text('No magic square calculated yet'),
            ],
          ),
        ),
      ),
    );
  }

  // Function to calculate the magic square
  void magicSquareCalc(int x) {
    magicSquare.clear();

    if (x % 2 == 1) {
      oddMagicSquare(x); // Odd-order magic square (Siamese method)
    } else if (x % 4 == 0) {
      doublyEvenMagicSquare(x); // Doubly even-order magic square
    } else {
      singlyEvenMagicSquare(x); // Singly even-order magic square
    }

    _magicSum = x * (x * x + 1) ~/ 2;
    _yValue = _magicSum ~/ x;

    // Update the calculation table
    calculationTable = [];
    for (int i = 0; i < x; i++) {
      List<String> rowCalc = [];
      for (int j = 0; j < x; j++) {
        // rowCalc.add('(${i + 1},${j + 1}): ${magicSquare[i][j]}');
        rowCalc.add('${magicSquare[i][j]}');
      }
      calculationTable.add(rowCalc);
    }
  }

  // Odd-order magic square (Siamese method)
  void oddMagicSquare(int n) {
    magicSquare = List.generate(n, (i) => List<int>.filled(n, 0));
    int num = 1;
    int row = 0;
    int col = n ~/ 2;

    while (num <= n * n) {
      magicSquare[row][col] = num;
      num++;
      int newRow = (row - 1 + n) % n;
      int newCol = (col + 1) % n;

      if (magicSquare[newRow][newCol] != 0) {
        row = (row + 1) % n;
      } else {
        row = newRow;
        col = newCol;
      }
    }
  }

  // Doubly-even magic square
  void doublyEvenMagicSquare(int n) {
    magicSquare = List.generate(n, (i) => List<int>.filled(n, 0));
    int num = 1;

    // Fill the square in order
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        magicSquare[i][j] = num;
        num++;
      }
    }

    // Swap values based on specific positions
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        if ((i % 4 == j % 4) || ((i + j) % 4 == 3)) {
          magicSquare[i][j] = (n * n + 1) - magicSquare[i][j];
        }
      }
    }
  }

  void singlyEvenMagicSquare(int n) {
    int halfN = n ~/ 2;
    int subSquareSize = halfN * halfN;

    // Create a smaller odd-order magic square for halfN
    List<List<int>> subMagicSquare = List.generate(halfN, (i) => List<int>.filled(halfN, 0));
    oddMagicSquare(halfN);  // Assuming this correctly fills subMagicSquare for the odd halfN

    // Initialize the full magic square
    magicSquare = List.generate(n, (i) => List<int>.filled(n, 0));

    // Copy smaller square into four quadrants
    for (int i = 0; i < halfN; i++) {
      for (int j = 0; j < halfN; j++) {
        magicSquare[i][j] = subMagicSquare[i][j];  // Top-left
        magicSquare[i + halfN][j] = subMagicSquare[i][j] + 2 * subSquareSize;  // Bottom-left
        magicSquare[i][j + halfN] = subMagicSquare[i][j] + 3 * subSquareSize;  // Top-right
        magicSquare[i + halfN][j + halfN] = subMagicSquare[i][j] + subSquareSize;  // Bottom-right
      }
    }

    // Swap columns
    int colsToSwap = halfN ~/ 2;
    for (int i = 0; i < halfN; i++) {
      for (int j = 0; j < colsToSwap; j++) {
        // Avoid swapping the central column in the first half
        if (j == colsToSwap - 1 && i >= halfN ~/ 2) {
          continue;
        }
        // Swap top-left and bottom-left quadrants
        int temp = magicSquare[i][j];
        magicSquare[i][j] = magicSquare[i + halfN][j];
        magicSquare[i + halfN][j] = temp;
      }
    }

    // Swap rightmost columns
    for (int i = 0; i < halfN; i++) {
      for (int j = n - colsToSwap + 1; j < n; j++) {
        // Swap top-right and bottom-right quadrants
        int temp = magicSquare[i][j];
        magicSquare[i][j] = magicSquare[i + halfN][j];
        magicSquare[i + halfN][j] = temp;
      }
    }
  }
}


class DatesCalendarScreen extends StatefulWidget {
  const DatesCalendarScreen({super.key});

  @override
  _DatesCalendarScreenState createState() => _DatesCalendarScreenState();
}

class _DatesCalendarScreenState extends State<DatesCalendarScreen> {
  int _selectedDate = 1; // Default date
  String _selectedMonth = 'January'; // Default month
  final TextEditingController _yearController = TextEditingController();
  String? _yearErrorText;
  List<int> _daysInMonth =
      List.generate(31, (index) => index + 1); // Days in month

  @override
  void initState() {
    super.initState();
    _updateDaysInMonth(); // Update days in month on initialization
  }

  @override
  void dispose() {
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dates and Calendar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Day dropdown
                SizedBox(
                  width: 50,
                  child: DropdownButton<int>(
                    value: _selectedDate,
                    items: _daysInMonth
                        .map((day) => DropdownMenuItem<int>(
                              value: day,
                              child: Text('$day'),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDate = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 20),
                // Month dropdown
                SizedBox(
                  width: 110,
                  child: DropdownButton<String>(
                    value: _selectedMonth,
                    items: [
                      'January',
                      'February',
                      'March',
                      'April',
                      'May',
                      'June',
                      'July',
                      'August',
                      'September',
                      'October',
                      'November',
                      'December',
                    ]
                        .map((month) => DropdownMenuItem<String>(
                              value: month,
                              child: Text(month),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedMonth = value!;
                        _updateDaysInMonth(); // Update days when month changes
                      });
                    },
                  ),
                ),
                const SizedBox(width: 20),
                // Year input field
                SizedBox(
                  width: 100,
                  child: TextField(
                    controller: _yearController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.yellow,
                      border: const OutlineInputBorder(),
                      hintText: 'Enter year',
                      errorText: _yearErrorText,
                      errorStyle: const TextStyle(color: Colors.red),
                      hintStyle: const TextStyle(color: Colors.black54),
                    ),
                    maxLength: 4,
                    onChanged: (value) {
                      _updateDaysInMonth(); // Update days when year changes
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _validateYear();
                if (_yearErrorText == null) {
                  // Logic for handling selected date, month, and year
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _validateYear() {
    setState(() {
      _yearErrorText = _yearController.text.isEmpty
          ? 'Year cannot be empty'
          : _yearController.text.length != 4
              ? 'Enter a 4-digit year'
              : null;
    });
  }

  void _updateDaysInMonth() {
    int daysInMonth = _getDaysInMonth(_selectedMonth, _getYear());
    if (_selectedDate > daysInMonth) {
      _selectedDate = daysInMonth;
    }
    setState(() {
      _daysInMonth = List.generate(daysInMonth, (index) => index + 1);
    });
  }

  int _getYear() {
    final year = int.tryParse(_yearController.text);
    return year ??
        DateTime.now().year; // Default to current year if empty or invalid
  }

  int _getDaysInMonth(String month, int year) {
    switch (month) {
      case 'April':
      case 'June':
      case 'September':
      case 'November':
        return 30;
      case 'February':
        return _isLeapYear(year) ? 29 : 28;
      default:
        return 31;
    }
  }

  bool _isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }
}

class DeterminantScreen extends StatefulWidget {
  const DeterminantScreen({super.key});

  @override
  _DeterminantScreenState createState() => _DeterminantScreenState();
}

class _DeterminantScreenState extends State<DeterminantScreen> {
  int matrixSize = 2; // Initial size for the 2x2 matrix
  List<TextEditingController> controllers = [];
  String result = '';

  @override
  void initState() {
    super.initState();
    _generateControllers();
  }

  void _generateControllers() {
    controllers = List.generate(matrixSize * matrixSize, (index) => TextEditingController());
  }

  void _onMatrixSizeChanged(int? newSize) {
    if (newSize != null) {
      setState(() {
        matrixSize = newSize;
        _generateControllers();
        result = ''; // Reset result when matrix size changes
      });
    }
  }

  List<String> _generateLabels() {
    const String alphabet = 'abcdefghijklmnopqrstuvwxyz';
    return List.generate(matrixSize * matrixSize, (index) => alphabet[index % alphabet.length]);
  }

  void _calculateDeterminant() {
    if (matrixSize == 2) {
      _calculate2x2Determinant();
    } else if (matrixSize == 3) {
      _calculate3x3Determinant();
    } else if (matrixSize == 4) {
      _calculate4x4Determinant();
    }
  }

  void _calculate2x2Determinant() {
    // Parsing the values from the text controllers
    double a = double.parse(controllers[0].text);
    double b = double.parse(controllers[1].text);
    double c = double.parse(controllers[2].text);
    double d = double.parse(controllers[3].text);

    double determinant = (a * d) - (b * c);

    setState(() {
      result = '(a * d) - (b * c)\n($a * $d) - ($b * $c)\n${a * d} - ${b * c} = $determinant';
    });
  }

  void _calculate3x3Determinant() {
    // Parsing the values for a 3x3 matrix
    double a = double.parse(controllers[0].text);
    double b = double.parse(controllers[1].text);
    double c = double.parse(controllers[2].text);
    double d = double.parse(controllers[3].text);
    double e = double.parse(controllers[4].text);
    double f = double.parse(controllers[5].text);
    double g = double.parse(controllers[6].text);
    double h = double.parse(controllers[7].text);
    double i = double.parse(controllers[8].text);

    // 3x3 determinant formula
    double determinant = a * (e * i - f * h) - b * (d * i - f * g) + c * (d * h - e * g);

    setState(() {
      result = 'a * (e * i - f * h) - b * (d * i - f * g) + c * (d * h - e * g)\n$a * ($e * $i - $f * $h) - $b * ($d * $i - $f * $g) + $c * ($d * $h - $e * $g)\n${a * (e * i - f * h)} - ${b * (d * i - f * g)} + ${c * (d * h - e * g)} = $determinant';
    });
  }

  void _calculate4x4Determinant() {
    // Parsing the values for a 4x4 matrix
    double a = double.parse(controllers[0].text);
    double b = double.parse(controllers[1].text);
    double c = double.parse(controllers[2].text);
    double d = double.parse(controllers[3].text);
    double e = double.parse(controllers[4].text);
    double f = double.parse(controllers[5].text);
    double g = double.parse(controllers[6].text);
    double h = double.parse(controllers[7].text);
    double i = double.parse(controllers[8].text);
    double j = double.parse(controllers[9].text);
    double k = double.parse(controllers[10].text);
    double l = double.parse(controllers[11].text);
    double m = double.parse(controllers[12].text);
    double n = double.parse(controllers[13].text);
    double o = double.parse(controllers[14].text);
    double p = double.parse(controllers[15].text);

    // 3x3 determinants used in the 4x4 determinant calculation
    double det1 = a * (f * ((k * p) - (l * o)) - g * ((j * p) - (l * n)) + h * ((j * o) - (k * n)));
    double det2 = b * (e * ((k * p) - (l * o)) - g * ((i * p) - (l * m)) + h * ((i * o) - (k * m)));
    double det3 = c * (e * ((j * p) - (l * n)) - f * ((i * p) - (l * m)) + h * ((i * n) - (j * m)));
    double det4 = d * (e * ((j * o) - (k * n)) - f * ((i * o) - (k * m)) + g * ((i * n) - (j * m)));

    double determinant = det1 - det2 + det3 - det4;

    setState(() {
      result = 'Determinant calculation for 4x4 matrix:\n'
          'a * (f * ((k * p) - (l * o)) - g * ((j * p) - (l * n)) + h * ((j * o) - (k * n)))\n'
          '- b * (e * ((k * p) - (l * o)) - g * ((i * p) - (l * m)) + h * ((i * o) - (k * m)))\n'
          '+ c * (e * ((j * p) - (l * n)) - f * ((i * p) - (l * m)) + h * ((i * n) - (j * m)))\n'
          '- d * (e * ((j * o) - (k * n)) - f * ((i * o) - (k * m)) + g * ((i * n) - (j * m)))\n'
          '$a * ($f * (($k * $p) - ($l * $o)) - $g * (($j * $p) - ($l * $n)) + $h * (($j * $o) - ($k * $n)))\n'
          '- $b * ($e * (($k * $p) - ($l * $o)) - $g * (($i * $p) - ($l * $m)) + $h * (($i * $o) - ($k * $m)))\n'
          '+ $c * ($e * (($j * $p) - ($l * $n)) - $f * (($i * $p) - ($l * $m)) + $h * (($i * $n) - ($j * $m)))\n'
          '- $d * ($e * (($j * $o) - ($k * $n)) - $f * (($i * $o) - ($k * $m)) + $g * (($i * $n) - ($j * $m)))\n'
          // "$det1 , $det2, $det3, $det4"
          'Result: $determinant';
    });
  }


  @override
  Widget build(BuildContext context) {
    final labels = _generateLabels();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Determinant'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Matrix Size:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButton<int>(
              value: matrixSize,
              items: const [
                DropdownMenuItem(value: 2, child: Text('2x2 Matrix')),
                DropdownMenuItem(value: 3, child: Text('3x3 Matrix')),
                DropdownMenuItem(value: 4, child: Text('4x4 Matrix')),
              ],
              onChanged: _onMatrixSizeChanged,
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              itemCount: matrixSize * matrixSize,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: matrixSize,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TextField(
                      controller: controllers[index],
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      labels[index],
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _calculateDeterminant,
                child: const Text('Calculate Determinant'),
              ),
            ),
            const SizedBox(height: 20),
            if (result.isNotEmpty) ...[
              const Text(
                'Steps:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                result,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}


class CoordinateGeometryScreen extends StatelessWidget {
  const CoordinateGeometryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coordinate Geometry'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Content for Coordinate Geometry Operation',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Text(
              'The logic for this is yet to be integrated',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DifferentiationScreen extends StatelessWidget {
  const DifferentiationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Differentiation'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Content for Differentiation Operation',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Text(
              'The logic for this is yet to be integrated',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IntegrationScreen extends StatelessWidget {
  const IntegrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Integration'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Content for Integration Operation',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            Text(
              'The logic for this is yet to be integrated',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrigonometryScreen extends StatelessWidget {
  const TrigonometryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trigonometry'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Content for Trigonometry Operation',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'The logic for this is yet to be integrated',
              style: TextStyle(
                color: Colors.red, // Apply red color to the text
              ),
            ),
          ],
        ),
      ),
    );
  }
}
