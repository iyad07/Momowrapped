import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnnualWrap extends StatefulWidget {
  const AnnualWrap({super.key});

  @override
  _WrappedStoryState createState() => _WrappedStoryState();
}

class _WrappedStoryState extends State<AnnualWrap>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;
  bool _isPaused = false;
  double _progress = 0.0;

  late AnimationController _animController;
  late Animation<double> _fadeOutAnimation;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;

  final List<Map<String, dynamic>> wrappedSlides = [
    {
      "title": "Your Income Be Like Ghost, E No Show!",
      'insights':
          "Chop Smarter! 🥕  Buy seasonal produce from local markets to save GHS 20.0 in your pocket this month!",
      "value": "₵5,000",
      "color": Colors.yellow[600]
    },
    {
      "title": "Top Recipient",
      "value": "John Doe - ₵2,500",
      "color": Colors.yellow[500],
      "insights":""
    },
    {
      "title": "Most Used Service",
      "value": "Airtime & Data",
      "color": Colors.yellow[400],
      "insights":""
    },
    {
      "title": "Peak Spending Month",
      "value": "October",
      "color": Colors.yellow[500],
      "insights":""
    },
    {
      "title": "Your 2024 Wrapped!",
      "value": "See you next year!",
      "color": Colors.yellow[600],
      "insights":"",
      "isLast": true
    },
  ];

  void startAutoPlay() {
    _timer?.cancel();
    _progress = 0.0;

    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (!_isPaused && _currentIndex < wrappedSlides.length) {
        setState(() {
          _progress += 0.025;
        });

        if (_progress >= 1.0) {
          _progress = 0.0;
          if (_currentIndex < wrappedSlides.length - 1) {
            triggerSlideTransition();
          } else {
            _timer?.cancel();
          }
        }
      }
    });
  }

  void triggerSlideTransition() {
    _animController.reverse().then((_) {
      if (_currentIndex < wrappedSlides.length - 1) {
        _pageController.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
      _animController.forward();
    });
  }

  void stopAutoPlay() {
    setState(() {
      _isPaused = true;
    });
    _timer?.cancel();
  }

  void resumeAutoPlay() {
    setState(() {
      _isPaused = false;
    });
    startAutoPlay();
  }

  void resetCarousel() {
    setState(() {
      _currentIndex = 0;
      _isPaused = false;
      _progress = 0.0;
    });

    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    startAutoPlay();
  }

  @override
  void initState() {
    super.initState();
    startAutoPlay();

    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    _fadeOutAnimation = Tween<double>(begin: 1.0, end: 0.3).animate(
        CurvedAnimation(
            parent: _animController,
            curve: Interval(0.0, 0.5, curve: Curves.easeOut)));

    _fadeInAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(
            parent: _animController,
            curve: Interval(0.5, 1.0, curve: Curves.easeIn)));

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _animController.forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Go back to the landing page
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          stopAutoPlay();
          Future.delayed(Duration(seconds: 5), resumeAutoPlay);
        },
        child: Stack(
          children: [
            // Wrapped Screens with Fade Out -> Fade In + Scale Animation
            PageView.builder(
              controller: _pageController,
              physics: _isPaused
                  ? AlwaysScrollableScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              itemCount: wrappedSlides.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                  _progress = 0.0;
                });
                _animController.reset();
                _animController.forward();
                startAutoPlay();
              },
              itemBuilder: (context, index) {
                var data = wrappedSlides[index];
                return AnimatedBuilder(
                  animation: _animController,
                  builder: (context, child) {
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/anualbackground.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Opacity(
                          opacity: index == _currentIndex
                              ? _fadeInAnimation.value
                              : _fadeOutAnimation.value,
                          child: Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Container(
                              width: double.infinity,
                              color: Colors.black.withOpacity(0.5),
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SlideTransition(
                                        position: Tween<Offset>(
                                          begin: Offset(0, 1),
                                          end: Offset(0, 0),
                                        ).animate(CurvedAnimation(
                                          parent: _animController,
                                          curve: Curves.easeInOut,
                                        )),
                                        child: Text(data["title"],
                                            style: TextStyle(
                                                
                                                fontSize: 24,
                                                color: Colors.white,
                                                fontFamily: 'Roboto')),
                                      ),
                                      SizedBox(height: 10),
                                      SlideTransition(
                                        position: Tween<Offset>(
                                          begin: Offset(0, 1),
                                          end: Offset(0, 0),
                                        ).animate(CurvedAnimation(
                                          parent: _animController,
                                          curve: Curves.easeInOut,
                                        )),
                                        child: Text(
                                          data["value"],
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'Roboto',
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      /*SlideTransition(
                                        position: Tween<Offset>(
                                          begin: Offset(0, 1),
                                          end: Offset(0, 0),
                                        ).animate(CurvedAnimation(
                                          parent: _animController,
                                          curve: Curves.easeInOut,
                                        )),
                                        child: Text(
                                          data["insights"], // Provide an empty string if null
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontFamily: 'Roboto',
                                          ),
                                        ),
                                      ),*/
                                      SizedBox(height: 20),
                                      if (data["isLast"] == true)
                                        ElevatedButton(
                                          onPressed: resetCarousel,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 24),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(FontAwesomeIcons.redo,
                                                  size: 18,
                                                  color: Colors.black),
                                              SizedBox(width: 10),
                                              Text("Replay Wrapped",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: 'Roboto')),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Animated corners
                      ],
                    );
                  },
                );
              },
            ),

            // Progress Bar
            Positioned(
              top: 40,
              left: 20,
              right: 20,
              child: Row(
                children: List.generate(wrappedSlides.length, (index) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: LinearProgressIndicator(
                        value: index == _currentIndex
                            ? _progress
                            : (index < _currentIndex ? 1.0 : 0.0),
                        backgroundColor: Colors.grey[700],
                        color: Colors.white,
                        minHeight: 4,
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Pause/Play Button
            Positioned(
              top: 35,
              right: 20,
              child: IconButton(
                icon: Icon(
                    _isPaused ? FontAwesomeIcons.play : FontAwesomeIcons.pause,
                    color: Colors.white,
                    size: 20),
                onPressed: () {
                  _isPaused ? resumeAutoPlay() : stopAutoPlay();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
