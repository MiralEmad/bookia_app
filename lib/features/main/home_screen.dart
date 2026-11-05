import 'dart:async';
import 'package:flutter/material.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/responsive/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_logo.dart';
import '../../core/widgets/book_card.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/small_action_button.dart';
import '../../data/book_model.dart';
import '../../data/books_data.dart';
import '../../data/cart_repository.dart';
import '../main/book_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _bannerCount = 3;

  static const _bannerColors = [
    [Color(0xFFD9726B), Color(0xFFB85450)],
    [Color(0xFFC4A04F), Color(0xFF8C6F2B)],
    [Color(0xFF6F86A6), Color(0xFF475A78)],
  ];

  final _pageController = PageController();
  final _search = TextEditingController();

  Timer? _timer;
  int _page = 0;
  bool _searching = false;
  String _query = '';

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_pageController.hasClients || _searching) return;

      _pageController.animateToPage(
        (_page + 1) % _bannerCount,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _search.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _searching = !_searching;

      if (!_searching) {
        _search.clear();
        _query = '';
      }
    });
  }

  Future<void> _addToCart(Book book) async {
    await CartRepository.instance.add(book.id);

    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(context.tr('addedToCart')),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    final q = _query.trim().toLowerCase();

    final books = kBooks.where((b) {
      return q.isEmpty ||
          b.title(lang).toLowerCase().contains(q) ||
          b.author(lang).toLowerCase().contains(q);
    }).toList();

    final pad = context.sp(16);

    return ColoredBox(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(pad),
                child: _searching
                    ? _searchBar(context)
                    : _header(context),
              ),
            ),

            if (!_searching) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: pad),
                  child: _banner(context),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: context.sp(10)),
              ),
              SliverToBoxAdapter(child: _dots()),
            ],

            // Best Seller
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  pad,
                  context.sp(18),
                  pad,
                  pad,
                ),
                child: Text(
                  context.tr('bestSeller'),
                  style: TextStyle(
                    fontSize: context.sp(20),
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),

            if (books.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  icon: Icons.search_off_rounded,
                  title: context.tr('noResults'),
                ),
              )
            else
              SliverPadding(
                padding: EdgeInsets.fromLTRB(pad, 0, pad, pad),
                sliver: SliverGrid(
                  gridDelegate: bookGridDelegate,
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final book = books[i];

                      return BookCard(
                        book: book,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  BookDetailsScreen(book: book),
                            ),
                          );
                        },
                        trailing: SmallActionButton(
                          icon: Icons.add_rounded,
                          tooltip: context.tr('addToCart'),
                          onTap: () => _addToCart(book),
                        ),
                      );
                    },
                    childCount: books.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) => Row(
        children: [
          const AppLogo(size: 22),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.search_rounded,
              color: Colors.black,
            ),
            tooltip: context.tr('searchBooks'),
            onPressed: _toggleSearch,
          ),
        ],
      );

  Widget _searchBar(BuildContext context) => Row(
        children: [
          Expanded(
            child: TextField(
              controller: _search,
              autofocus: true,
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: context.tr('searchBooks'),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  size: 20,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: _toggleSearch,
          ),
        ],
      );

  Widget _banner(BuildContext context) => AspectRatio(
        aspectRatio: 2.4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: PageView.builder(
            controller: _pageController,
            itemCount: _bannerCount,
            onPageChanged: (i) => setState(() => _page = i),
            itemBuilder: (_, i) => Image.asset(
              'assets/images/banner_${i + 1}.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _bannerColors[i],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.auto_stories_rounded,
                    size: 48,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget _dots() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_bannerCount, (i) {
          final active = i == _page;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: active ? 24 : 8,
            height: 6,
            decoration: BoxDecoration(
              color: active ? AppColors.primary : AppColors.border,
              borderRadius: BorderRadius.circular(3),
            ),
          );
        }),
      );
}