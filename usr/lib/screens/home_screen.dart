import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCity = 'القاهرة';
  final List<String> _cities = [
    'القاهرة',
    'الإسكندرية',
    'الجيزة',
    'أسوان',
    'الأقصر',
    'شرم الشيخ'
  ];

  final Map<String, Map<String, String>> _prayerTimes = {
    'القاهرة': {
      'الفجر': '04:00 ص',
      'الشروق': '05:30 ص',
      'الظهر': '12:30 م',
      'العصر': '04:00 م',
      'المغرب': '07:00 م',
      'العشاء': '08:30 م',
    },
    'الإسكندرية': {
      'الفجر': '04:05 ص',
      'الشروق': '05:35 ص',
      'الظهر': '12:35 م',
      'العصر': '04:05 م',
      'المغرب': '07:05 م',
      'العشاء': '08:35 م',
    },
    'الجيزة': {
      'الفجر': '04:01 ص',
      'الشروق': '05:31 ص',
      'الظهر': '12:31 م',
      'العصر': '04:01 م',
      'المغرب': '07:01 م',
      'العشاء': '08:31 م',
    },
    'أسوان': {
      'الفجر': '04:10 ص',
      'الشروق': '05:40 ص',
      'الظهر': '12:20 م',
      'العصر': '03:45 م',
      'المغرب': '06:45 م',
      'العشاء': '08:10 م',
    },
    'الأقصر': {
      'الفجر': '04:08 ص',
      'الشروق': '05:38 ص',
      'الظهر': '12:25 م',
      'العصر': '03:50 م',
      'المغرب': '06:50 م',
      'العشاء': '08:15 م',
    },
    'شرم الشيخ': {
      'الفجر': '03:55 ص',
      'الشروق': '05:25 ص',
      'الظهر': '12:15 م',
      'العصر': '03:40 م',
      'المغرب': '06:40 م',
      'العشاء': '08:05 م',
    },
  };

  String _currentDate = '';

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ar_EG', null).then((_) {
      _updateDate();
    });
  }

  void _updateDate() {
    setState(() {
      _currentDate = DateFormat.yMMMMEEEEd('ar_EG').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    final times = _prayerTimes[_selectedCity]!;
    final prayerNames = times.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('مواقيت الصلاة في مصر'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal, Colors.greenAccent],
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: prayerNames.length,
                itemBuilder: (context, index) {
                  final prayerName = prayerNames[index];
                  final prayerTime = times[prayerName]!;
                  return _buildPrayerTimeCard(prayerName, prayerTime);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            _currentDate,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: DropdownButton<String>(
              value: _selectedCity,
              isExpanded: true,
              icon: const Icon(Icons.location_on, color: Colors.teal),
              underline: const SizedBox(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedCity = newValue;
                  });
                }
              },
              items: _cities.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerTimeCard(String prayerName, String prayerTime) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        title: Text(
          prayerName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        trailing: Text(
          prayerTime,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
