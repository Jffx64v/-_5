import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const BikeGameApp());

class BikeGameApp extends StatelessWidget {
  const BikeGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'لعبة الدراجة',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BikeGameHome(),
    );
  }
}

class BikeGameHome extends StatefulWidget {
  const BikeGameHome({Key? key}) : super(key: key);

  @override
  _BikeGameHomeState createState() => _BikeGameHomeState();
}

class _BikeGameHomeState extends State<BikeGameHome> {
  double _bikePosition = 0.0;
  bool _isImageVisible = false;
  late Timer _timer;
  int _timeLimit = 5; // الوقت المحدد بالثواني

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(Duration(seconds: _timeLimit), () {
      setState(() {
        _isImageVisible = false;
      });
    });
    setState(() {
      _isImageVisible = true;
    });
  }

  void _moveBike() {
    setState(() {
      _bikePosition += 20;
    });
  }

  void _onImageTapped() {
    // هنا يمكنك إضافة منطق النقاط أو أي شيء آخر تريده عند لمس الصورة
    print('صورة لمست!');
    _timer.cancel(); // إلغاء المؤقت عند اللمس
    _isImageVisible = false; // إخفاء الصورة بعد اللمس
    _startTimer(); // إعادة بدء المؤقت
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لعبة الدراجة'),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.green,
            child: Center(
              child: Container(
                width: 300,
                height: 10,
                color: Colors.brown,
              ),
            ),
          ),
          Positioned(
            left: _bikePosition,
            bottom: 50,
            child: Icon(
              Icons.directions_bike,
              size: 50,
              color: Colors.blue,
            ),
          ),
          if (_isImageVisible)
            Positioned(
              top: 100,
              left: 100,
              child: GestureDetector(
                onTap: _onImageTapped,
                child: Image.asset(
                  'assets/image.png', // تأكد من إضافة الصورة في مجلد الأصول
                  width: 100,
                  height: 100,
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _moveBike,
        tooltip: 'تحرك',
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
