import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Sidebar Example',
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

class _HomeScreenState extends State<HomeScreen> {
  bool _isSidebarOpen = false;

  void toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Sidebar Example'),
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
          // Sidebar
          if (_isSidebarOpen)
            GestureDetector(
              onTap: toggleSidebar,
              child: Container(
                color: Colors.black54,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 250,
                    color: Colors.blue,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 100),
                        _buildMenuItem(Icons.home, 'Home', () {}),
                        _buildMenuItem(Icons.search, 'Search', () {}),
                        _buildMenuItem(Icons.person, 'Profile', () {}),
                        _buildMenuItem(Icons.settings, 'Settings', () {}),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
