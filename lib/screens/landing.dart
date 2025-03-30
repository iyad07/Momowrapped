import 'package:flutter/material.dart';
import 'package:momowrapped/screens/intro_slides.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003366), // Dark blue
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Account Icon
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: Color(0xFFFFCC00), width: 2), // Solid yellow ring
              ),
              child: Center(
                child: SizedBox(
                  width: 40, // Set a fixed width for the icon
                  height: 40, // Set a fixed height for the icon
                  child: IconButton(
                    //iconSize: 40,
                    icon: Icon(Icons.account_circle, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            // Logo
            /*Image.asset(
              'assets/logo.png', // Replace with your logo asset
              width: 50,
              height: 50,
            ),*/
            // Approvals Icon
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Details Card
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF003366), // Dark blue
                borderRadius: BorderRadius.circular(18),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '053 466 9344',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'GHS ***********',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      IconButton(
                        icon: Icon(Icons.visibility, color: Colors.amber),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Tabs
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 38, 77),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              //side: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              children: [
                                Icon(Icons.arrow_downward, color: Colors.white),
                                SizedBox(height: 4),
                                Text(
                                  'Allow Cashout',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 3,
                        height: 40,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 38, 77),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              children: [
                                Icon(Icons.swap_horiz, color: Colors.white),
                                SizedBox(height: 4),
                                Text(
                                  'Transactions',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Tabs (PAY and SERVICES)
            /*Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFD700), // Yellow
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'PAY',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'TOPUP',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'SERVICES',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),*/
            SizedBox(height: 16),

            // Grid of Icons
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildGridTile(
                  icon: Icons.money,
                  label: 'Send money',
                ),
                _buildGridTile(
                  icon: Icons.account_balance,
                  label: 'Bank services',
                ),
                _buildGridTile(
                  icon: Icons.file_copy,
                  label: 'MTN services',
                ),
                _buildGridTile(
                  icon: Icons.directions_car,
                  label: 'Transport',
                ),
                _buildGridTile(
                  icon: Icons.tv,
                  label: 'TV',
                ),
                _buildGridTile(
                  icon: Icons.lightbulb,
                  label: 'ECG',
                ),
                _buildGridTile(
                  icon: Icons.calendar_today,
                  label: 'Schedule',
                ),
                _buildGridTile(
                  icon: Icons.percent,
                  label: 'More Bills',
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: _buildBouncingFAB(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF003366), // Dark blue
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send),
            label: 'Send',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'MoMoPay',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Offers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }

  // Helper function to build grid tiles
  Widget _buildGridTile({required IconData icon, required String label}) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Color(0xFF003366)), // Dark blue
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                  fontSize: 14, color: Color(0xFF003366)), // Dark blue
            ),
          ],
        ),
      ),
    );
  }

  // New method to build the bouncing floating action button
  Widget _buildBouncingFAB() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: 1 + 0.1 * _animationController.value,
          child: FloatingActionButton(
            onPressed: () {
              // Navigate to the WrappedStory screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => IntroSlides()),
              );
            },
            shape: CircleBorder(),
            foregroundColor: Color(0xFF000000),
            backgroundColor: Color(0xFFFFCC00),
            child: Icon(Icons.card_giftcard),
          ),
        );
      },
    );
  }

  // Method to show the dialog
  /*
 void _showDialog(BuildContext context) {
  String selectedOption = 'Last week'; // Default selection
  List<String> options = ['Last week', 'Last month', 'This year'];

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Select a wrapped option'),
            content: Column(
              mainAxisSize: MainAxisSize.min, // Prevent unnecessary expansion
              children: [
                DropdownButton<String>(
                  value: selectedOption,
                  isExpanded: true, // Ensures proper UI layout
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedOption = newValue;
                      });
                    }
                  },
                  items: options.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center ,
            actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFCC00), // Yellow color
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: StadiumBorder(), // Makes the button circular
                side: BorderSide(width: 2, color: Color(0xFFFFCC00)), // Adds a border to create a glowing effect
                shadowColor: Color(0xFFFFCC00), // Adds a shadow to create a glowing effect
                elevation: 10, // Increases the elevation to make the button more prominent
              ),

              child: Text('Generate wrapped'),
            ),
            ],
          );
        },
      );
    },
  );
}
*/

}

// Custom painter for dashed circle
class DashedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFFFFCC00) // Yellow color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    double radius = size.width / 2;
    double dashWidth = 5;
    double dashSpace = 0.1;
    double startAngle = 0;

    while (startAngle < 2 * 3.14159265358979323846) {
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        startAngle,
        dashWidth,
        false,
        paint,
      );
      startAngle += dashWidth + dashSpace; // Create space between dashes
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
