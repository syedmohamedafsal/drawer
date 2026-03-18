import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const LiquidMenuApp());
}

class LiquidMenuApp extends StatelessWidget {
  const LiquidMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LiquidMenu(),
    );
  }
}

class LiquidMenu extends StatefulWidget {
  const LiquidMenu({super.key});

  @override
  State<LiquidMenu> createState() => _LiquidMenuState();
}

class _LiquidMenuState extends State<LiquidMenu> {
  bool isOpen = false;
  bool showMenu = false;

  Duration duration = const Duration(milliseconds: 1500);
  void toggle() {
    setState(() {
      isOpen = !isOpen;
      showMenu = isOpen; // start text animation immediately
    });
  }

  List<BoxShadow> liquidShadow(bool isOpen) {
    return [
      BoxShadow(
        color: const Color.fromARGB(
          177,
          32,
          32,
          32,
        ).withOpacity(isOpen ? 0.18 : 0.25),
        blurRadius: isOpen ? 50 : 3,
        spreadRadius: isOpen ? 25 : 0.5,
        offset: const Offset(0, 0),
      ),
    ];
  }
Widget menuItem(String text, int index) {
  return GestureDetector(
    onTap: () {
      toggle(); // close menu when item is tapped
    },
    child: AnimatedSlide(
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeInOut,
      offset: isOpen ? const Offset(0, 0) : const Offset(-6, 0),
      child: Padding(
        padding: EdgeInsets.only(top: index == 0 ? 0 : 28),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// GOOEY CIRCLES
          GooeyWrapper(
            isOpen: isOpen,
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: duration,
                  curve: Curves.easeInOutCubic,
                  top: isOpen ? -150 : 50,
                  left: isOpen ? -150 : 20,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(300),
                      onTap: toggle,
                      child: AnimatedContainer(
                        duration: duration,
                        width: isOpen ? 400 : 48,
                        height: isOpen ? 400 : 48,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                          boxShadow: liquidShadow(isOpen),
                        ),
                        child: Center(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: isOpen ? 0 : 1,
                            child: const Icon(Icons.menu, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: duration,
                  curve: Curves.easeInOutCubic,
                  top: isOpen ? -150 : -10,
                  right: isOpen ? -150 : -200,
                  child: AnimatedContainer(
                    duration: duration,
                    width: isOpen ? 700 : 200,
                    height: isOpen ? 700 : 200,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      boxShadow: liquidShadow(isOpen),
                    ),
                  ),
                ),

                AnimatedPositioned(
                  duration: duration,
                  curve: Curves.easeInOutCubic,
                  top: isOpen ? -150 : 200,
                  left: isOpen ? -150 : -310,
                  child: AnimatedContainer(
                    duration: duration,
                    width: isOpen ? 1400 : 300,
                    height: isOpen ? 1400 : 300,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      boxShadow: liquidShadow(isOpen),
                    ),
                  ),
                ),

                AnimatedPositioned(
                  duration: duration,
                  curve: Curves.easeInOutCubic,
                  bottom: isOpen ? -150 : 300,
                  right: isOpen ? -150 : -260,
                  child: AnimatedContainer(
                    duration: duration,
                    width: isOpen ? 400 : 250,
                    height: isOpen ? 400 : 250,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      boxShadow: liquidShadow(isOpen),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// MENU ITEMS
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                menuItem("Home", 0),
                menuItem("Services", 1),
                menuItem("About Us", 2),
                menuItem("Catagories", 3),
              ],
            ),
          ),

          /// MENU BUTTON (liquid trigger)

          /// CLOSE BUTTON (slide from right)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
            top: 50,
            right: showMenu ? 20 : -80,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: showMenu ? 1 : 0,
              child: GestureDetector(
                onTap: toggle,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GooeyWrapper extends StatelessWidget {
  final Widget child;
  final bool isOpen;

  const GooeyWrapper({super.key, required this.child, required this.isOpen});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix([
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        0,
        6,
        -10,
      ]),
      child: Stack(
        children: [
          child,
          IgnorePointer(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: isOpen ? 5 : 0,
                  sigmaY: isOpen ? 5 : 0,
                ),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
