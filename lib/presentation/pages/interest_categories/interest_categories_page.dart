import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_router.dart';
import '../../widgets/common/primary_button.dart';
import '../../widgets/common/secondary_button.dart';
import '../../widgets/common/progress_header.dart';

class InterestCategoriesPage extends StatefulWidget {
  const InterestCategoriesPage({super.key});

  @override
  State<InterestCategoriesPage> createState() => _InterestCategoriesPageState();
}

class _InterestCategoriesPageState extends State<InterestCategoriesPage> {
  bool _isLoading = false;
  final Set<String> _selectedCategories = {};

  final List<InterestCategory> _categories = [
    InterestCategory('technology', 'テクノロジー', Icons.computer, '最新のIT技術やガジェット'),
    InterestCategory('sports', 'スポーツ', Icons.sports_soccer, 'サッカー、野球、テニスなど'),
    InterestCategory('music', '音楽', Icons.music_note, 'J-POP、クラシック、ジャズなど'),
    InterestCategory('travel', '旅行', Icons.flight, '国内・海外旅行、観光地情報'),
    InterestCategory('food', 'グルメ', Icons.restaurant, 'レストラン、料理、食べ歩き'),
    InterestCategory('fashion', 'ファッション', Icons.checkroom, 'トレンド、ブランド、コーデ'),
    InterestCategory('movies', '映画・ドラマ', Icons.movie, '邦画、洋画、ドラマ作品'),
    InterestCategory('books', '読書', Icons.book, '小説、ビジネス書、漫画'),
    InterestCategory('health', '健康・フィットネス', Icons.fitness_center, 'トレーニング、健康管理'),
    InterestCategory('art', 'アート・文化', Icons.palette, '美術館、展示会、文化活動'),
    InterestCategory('games', 'ゲーム', Icons.games, 'モバイルゲーム、コンソール'),
    InterestCategory('business', 'ビジネス', Icons.business, '投資、起業、キャリア'),
  ];

  Future<void> _handleContinue() async {
    if (_selectedCategories.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('3つ以上のカテゴリを選択してください'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() => _isLoading = false);
      context.go(AppRouter.termsAgreement);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Progress Header
            const ProgressHeader(
              currentStep: 6,
              totalSteps: 8,
              title: '興味のあるカテゴリ',
              subtitle: '3つ以上選択してください',
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Selection Count Indicator
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: _selectedCategories.length >= 3
                            ? theme.colorScheme.primaryContainer
                            : theme.colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _selectedCategories.length >= 3
                              ? theme.colorScheme.primary
                              : theme.colorScheme.outlineVariant,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _selectedCategories.length >= 3
                                ? Icons.check_circle
                                : Icons.info_outline,
                            color: _selectedCategories.length >= 3
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${_selectedCategories.length}/12 選択中 (最低3つ)',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: _selectedCategories.length >= 3
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Categories Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final isSelected = _selectedCategories.contains(category.id);

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedCategories.remove(category.id);
                              } else {
                                _selectedCategories.add(category.id);
                              }
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? theme.colorScheme.primaryContainer
                                  : theme.colorScheme.surfaceContainerLowest,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.outlineVariant,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Selection Indicator
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      isSelected
                                          ? Icons.check_circle
                                          : Icons.radio_button_unchecked,
                                      color: isSelected
                                          ? theme.colorScheme.primary
                                          : theme.colorScheme.onSurfaceVariant,
                                      size: 20,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  // Category Icon
                                  Icon(
                                    category.icon,
                                    size: 32,
                                    color: isSelected
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.onSurfaceVariant,
                                  ),

                                  const SizedBox(height: 12),

                                  // Category Name
                                  Text(
                                    category.name,
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      color: isSelected
                                          ? theme.colorScheme.primary
                                          : theme.colorScheme.onSurface,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  const SizedBox(height: 4),

                                  // Category Description
                                  Text(
                                    category.description,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: isSelected
                                          ? theme.colorScheme.primary
                                          : theme.colorScheme.onSurfaceVariant,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 32),

                    // Additional Info
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.colorScheme.outlineVariant,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            color: theme.colorScheme.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '選択した興味に基づいて、パーソナライズされたコンテンツを提供します。後で設定から変更可能です。',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Actions
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: theme.colorScheme.outlineVariant,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      onPressed: () => context.pop(),
                      text: '戻る',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: PrimaryButton(
                      onPressed: _selectedCategories.length >= 3 ? _handleContinue : null,
                      text: '次へ',
                      isLoading: _isLoading,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InterestCategory {
  final String id;
  final String name;
  final IconData icon;
  final String description;

  InterestCategory(this.id, this.name, this.icon, this.description);
}
