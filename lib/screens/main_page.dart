import 'package:financer/screens/portfolio.dart';
import 'package:flutter/material.dart';
import 'dashboard.dart';

class MainPage extends StatefulWidget {
  static String route = '/home';
  final int defaultIndex;
  const MainPage({Key? key, this.defaultIndex = 0}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _selectedIndex;
  static const List<Widget> _widgetOptions = [Dashboard(), Portfolio()];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.defaultIndex;
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF3F8),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
            activeIcon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stairs_rounded),
            label: 'Portfolio',
            activeIcon: Icon(
              Icons.stairs_outlined,
              color: Colors.blue,
            ),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        selectedLabelStyle: const TextStyle(color: Colors.blue),
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
