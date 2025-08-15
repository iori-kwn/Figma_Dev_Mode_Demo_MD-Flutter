import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_router.dart';
import '../../widgets/common/app_logo.dart';
import '../../widgets/common/feature_card.dart';
import '../../widgets/common/primary_button.dart';
import '../../widgets/common/secondary_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              const SizedBox(height: 40),
              
              // App Logo and Title
              const AppLogo(),
              const SizedBox(height: 32),
              
              // Main Heading
              Text(
                'ようこそ、\n新しい体験の始まりへ',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              
              // Subtitle
              Text(
                'あなたにぴったりのスタイルを見つけて、\n毎日をもっと特別なものにしませんか？',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              
              // Feature Cards
              const FeatureCard(
                icon: Icons.person_outline,
                title: 'パーソナライズされた提案',
                description: 'あなたの好みに合わせたコンテンツ',
              ),
              const SizedBox(height: 16),
              
              const FeatureCard(
                icon: Icons.security_outlined,
                title: '安全なプライバシー保護',
                description: '最高レベルのセキュリティ',
              ),
              const SizedBox(height: 16),
              
              const FeatureCard(
                icon: Icons.devices_outlined,
                title: 'いつでもどこでも',
                description: 'すべてのデバイスで同期',
              ),
              const SizedBox(height: 48),
              
              // Primary Action Button
              PrimaryButton(
                text: '新規登録',
                onPressed: () => context.go(AppRouter.emailInput),
              ),
              const SizedBox(height: 16),
              
              // Login Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'すでにアカウントをお持ちですか？ ',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to login
                    },
                    child: const Text('ログイン'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Terms and Privacy
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // TODO: Show terms
                    },
                    child: Text(
                      '利用規約',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Text(
                    ' ・ ',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Show privacy policy
                    },
                    child: Text(
                      'プライバシーポリシー',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}
