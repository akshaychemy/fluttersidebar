import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Sidebar Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isSidebarOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleSidebar() {
    setState(() {
      if (_isSidebarOpen) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Sidebar Example'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: toggleSidebar,
        ),
      ),
      body: Stack(
        children: [
          // Main content
          Container(
            padding: const EdgeInsets.all(16),
            child: const Center(
              child: Text('Home Screen'),
            ),
          ),
          // Animated Sidebar
          AnimatedBuilder(
            animation: _animation,
            builder: (context, _) {
              double slide = 250 * _animation.value;
              double scale = 1 - (_animation.value * 0.3);
              return Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: _isSidebarOpen ? _buildSidebar() : Container(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 350,
      color: Colors.blue,
      child: Column(
        children: [
          const SizedBox(height: 100),
          _buildMenuItem(Icons.home, 'Home', () {}),
          _buildMenuItem(Icons.search, 'Search', () {}),
          _buildMenuItem(Icons.person, 'Profile', () {}),
          _buildMenuItem(Icons.settings, 'Settings', () {}),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
