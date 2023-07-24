import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomeScreen());
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0; // Make sure this is outside build(), otherwise every setState will chage the value back to 0

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('appbarTitleHome'),
      ),
      body: Center(
        child: Text(
            'You are looking at the message for bottom navigation item $_index'),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (tappedItemIndex) =>
              setState(() {
                _index = tappedItemIndex;
              }),
          currentIndex: _index,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.av_timer), label: 'navBarItem1Text'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add), label: 'navBarItem2Text')
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            setState(() {
              _index = 0;
            }),
        tooltip: 'Reset Navigation Index',
        child: const Icon(Icons.clear), //Change Icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, //Change for different locations
    );
  }
}
