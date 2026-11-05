import 'package:flutter/material.dart';

import '../../core/widgets/app_bottom_nav.dart';
import '../../data/cart_repository.dart';
import '../main/home_screen.dart';
import '../main/wishlist_screen.dart';
import '../main/cart_screen.dart';
import '../main/profile_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  static const double _maxWidth = 720;

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SizedBox.expand(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: _maxWidth,
            ),

            child: SizedBox.expand(
              child: IndexedStack(
                index: _index,
                children: const [
                  HomeScreen(),
                  WishlistScreen(),
                  CartScreen(),
                  ProfileScreen(),
                ],
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: ListenableBuilder(
        listenable: CartRepository.instance,

        builder: (context, _) {
          return AppBottomNav(
            currentIndex: _index,
            cartCount: CartRepository.instance.count,
            maxWidth: _maxWidth,

            onTap: (i) {
              setState(() {
                _index = i;
              });
            },
          );
        },
      ),
    );
  }
}