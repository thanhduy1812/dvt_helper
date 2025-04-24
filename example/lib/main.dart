import 'package:flutter/material.dart';
import 'package:gtd_helper/helper/helper.dart';
import 'package:gtd_helper/helper/custom_ui/gtd_button.dart';
import 'package:gtd_helper/helper/custom_ui/gtd_lunar_calendar/gtd_calendar_helper.dart';
import 'package:gtd_helper/helper/extension/date_time_extension.dart';
import 'package:intl/intl.dart';

void main() {
  // Set up logger
  Logger.setLogLevel(Logger.DEBUG);
  Logger.i("Starting GTD Helper Example App");
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GTD Helper Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1AA260),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _encryptedValue = "Initial value";
  String _decryptedValue = "";
  Color _color = Colors.blue;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GTD Helper Demo'),
        backgroundColor: _color,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GTD Helper Example',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Package Version: ${GtdVersion.version}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            
            // Encryption Example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Encryption Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 8),
                    Text('Encrypted: $_encryptedValue'),
                    Text('Decrypted: $_decryptedValue'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _performEncryption,
                      child: const Text('Encrypt/Decrypt'),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Color Extension Example
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Color Extensions Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildColorBox(_color, 'Original'),
                        _buildColorBox(_color.darken(30), 'Darken 30%'),
                        _buildColorBox(_color.lighten(30), 'Lighten 30%'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _changeColor,
                      child: const Text('Change Color'),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Button Demo
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('GtdButton Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 16),
                    GtdButton(
                      text: 'Enabled Button',
                      color: _color,
                      height: 50,
                      borderRadius: 25,
                      onPressed: () {
                        Logger.i("Button pressed!");
                      },
                    ),
                    const SizedBox(height: 8),
                    GtdButton(
                      text: 'Disabled Button',
                      color: _color,
                      isEnable: false,
                      height: 50,
                      borderRadius: 25,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Date Utils Demo
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Date Extensions Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 8),
                    Text('Current Date: ${DateTime.now().localDate("EEEE, dd/MM/yyyy")}'),
                    Text('Tomorrow: ${DateTime.now().add(const Duration(days: 1)).localDate("dd/MM/yyyy")}'),
                    Text('Next Week: ${DateTime.now().add(const Duration(days: 7)).localDate("dd/MM/yyyy")}'),
                    Text('Next Month: ${DateTime.now().add(const Duration(days: 30)).localDate("MMMM yyyy")}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showLunarCalendar,
        child: const Icon(Icons.calendar_month),
      ),
    );
  }
  
  Widget _buildColorBox(Color color, String label) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
  
  void _performEncryption() {
    final testValue = "Hello GTD Helper!";
    final encrypted = GlobalFunctions.encryptHmacSha256(value: testValue);
    
    setState(() {
      _encryptedValue = encrypted;
      _decryptedValue = testValue;
    });
    
    Logger.d("Encrypted: $encrypted");
    Logger.d("Original: $testValue");
  }
  
  void _changeColor() {
    setState(() {
      // Generate a random color
      _color = Color.fromRGBO(
        (DateTime.now().millisecond % 255),
        (DateTime.now().microsecond % 255),
        (DateTime.now().second * 4 % 255),
        1.0,
      );
    });
  }
  
  void _showLunarCalendar() {
    GtdCalendarHelper.presentLunaCalendar(
      context: context,
      title: "Select Date",
      dayStartLabel: "Start",
      dayEndLabel: "End",
      mainColor: _color,
      onSelected: (dates) {
        Logger.i("Selected dates: ${dates.startDate?.localDate("dd/MM/yyyy")} - ${dates.endDate?.localDate("dd/MM/yyyy")}");
      },
    );
  }
} 