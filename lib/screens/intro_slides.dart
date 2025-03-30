import 'dart:async';
import 'package:flutter/material.dart';
import 'package:momowrapped/screens/wraps/annual_wrap.dart';
import 'package:momowrapped/screens/wraps/monthly_wrapped.dart';
import 'package:momowrapped/screens/wraps/weekly_wrapped.dart';

class IntroSlides extends StatefulWidget {
  @override
  _IntroSlidesState createState() => _IntroSlidesState();
}

class _IntroSlidesState extends State<IntroSlides>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);

    // Fade-in animation controller
    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    _fadeController.forward(); // Start fade animation

    // Auto-slide to Selection Page
    Timer(Duration(seconds: 3), () {
      if (_currentPage < 1) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(), // Disable manual swiping
        children: [
          FadeTransition(opacity: _fadeAnimation, child: IntroductionPage()),
          SelectionPage(),
        ],
      ),
    );
  }
}

// 📌 Animated Introduction Slide
class IntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/introbackground.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale:
                  Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
                      parent: AnimationController(
                        vsync: Navigator.of(context),
                        duration: Duration(seconds: 1),
                      )..forward(),
                      curve: Curves.elasticOut)),
              child: Icon(Icons.card_giftcard_rounded,
                  size: 100, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              "Welcome to Your Wrapped!",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              "Discover your top trends of the year!",
              style: TextStyle(fontSize: 18, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// 📌 Selection Slide with Animated Buttons
class SelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.close_rounded,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/optionsbackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Choose Your Wrapped 🗓️:",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 30),
              AnimatedOptionButton(
                  text: "Weekly Wrapped",
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WeeklyWrapped()))),
              AnimatedOptionButton(
                  text: "Monthly Wrapped",
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MonthlyWrapped()))),
              AnimatedOptionButton(
                  text: "Annual Wrapped",
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AnnualWrap()))),
            ],
          ),
        ),
      ),
    );
  }
}

// 📌 Animated Button Effect
class AnimatedOptionButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  const AnimatedOptionButton({super.key, required this.text, this.onPressed});

  @override
  _AnimatedOptionButtonState createState() => _AnimatedOptionButtonState();
}

class _AnimatedOptionButtonState extends State<AnimatedOptionButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
          shadowColor: Colors.black54,
        ),
        child: Text(widget.text),
      ),
    );
  }
}
