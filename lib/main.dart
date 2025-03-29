import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(),
      
    );
  }
}





class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("MoMo Wrapped"),
        backgroundColor: Colors.yellow[700],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => WrappedStory()),
            );
          },
          child: Text("View My MoMo Wrapped"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow[700],
            foregroundColor: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ),
    );
  }
}




class WrappedStory extends StatefulWidget {
  @override
  _WrappedStoryState createState() => _WrappedStoryState();
}

class _WrappedStoryState extends State<WrappedStory> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  double _opacity = 0.0; // Fade-in control
  double _scale = 0.8;   // Zoom-in control
  Offset _slideOffset = Offset(0, 0.2); // Slide text from below

  final List<Map<String, dynamic>> wrappedSlides = [
    {
      "title": "Total Money Sent",
      "value": "₵5,000",
      "color": Colors.blue[900],
      "icon": Icons.send_rounded,
    },
    {
      "title": "Top Recipient",
      "value": "John Doe - ₵2,500",
      "color": Colors.yellow[700],
      "icon": Icons.person_rounded,
    },
    {
      "title": "Most Used Service",
      "value": "Airtime & Data",
      "color": Colors.blue[600],
      "icon": Icons.phone_android_rounded,
    },
    {
      "title": "Peak Spending Month",
      "value": "October",
      "color": Colors.yellow[800],
      "icon": Icons.calendar_month_rounded,
    },
  ];

  void startAutoPlay() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_currentIndex < wrappedSlides.length - 1) {
        _pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _timer?.cancel();
      }
    });
  }

  void animateContent() {
    setState(() {
      _opacity = 1.0;
      _scale = 1.0;
      _slideOffset = Offset(0, 0);
    });
  }

  @override
  void initState() {
    super.initState();
    startAutoPlay();
    Future.delayed(Duration(milliseconds: 300), animateContent);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapUp: (details) {
          double screenWidth = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < screenWidth / 2) {
            if (_currentIndex > 0) {
              setState(() {
                _opacity = 0.0;
                _scale = 0.8;
                _slideOffset = Offset(0, 0.2);
              });
              Future.delayed(Duration(milliseconds: 200), () {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            }
          } else {
            if (_currentIndex < wrappedSlides.length - 1) {
              setState(() {
                _opacity = 0.0;
                _scale = 0.8;
                _slideOffset = Offset(0, 0.2);
              });
              Future.delayed(Duration(milliseconds: 200), () {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            }
          }
        },
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: wrappedSlides.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                  _opacity = 0.0;
                  _scale = 0.8;
                  _slideOffset = Offset(0, 0.2);
                });
                Future.delayed(Duration(milliseconds: 300), animateContent);
              },
              itemBuilder: (context, index) {
                var data = wrappedSlides[index];
                return AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: _opacity,
                  child: Container(
                    width: double.infinity,
                    color: data["color"],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedScale(
                          scale: _scale,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOutBack,
                          child: Icon(data["icon"], size: 80, color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        AnimatedSlide(
                          duration: Duration(milliseconds: 500),
                          offset: _slideOffset,
                          curve: Curves.easeOut,
                          child: Column(
                            children: [
                              Text(
                                data["title"],
                                style: TextStyle(fontSize: 24, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 10),
                              Text(
                                data["value"],
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // Progress Indicators (Top Bar)
            Positioned(
              top: 40,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  wrappedSlides.length,
                  (index) => Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: index <= _currentIndex ? Colors.white : Colors.white38,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
