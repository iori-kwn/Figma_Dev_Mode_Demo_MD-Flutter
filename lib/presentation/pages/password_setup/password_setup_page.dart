import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_router.dart';
import '../../widgets/common/primary_button.dart';
import '../../widgets/common/secondary_button.dart';
import '../../widgets/common/progress_header.dart';
import '../../widgets/forms/password_input_field.dart';
import '../../widgets/forms/password_requirement_checker.dart';

class PasswordSetupPage extends StatefulWidget {
  const PasswordSetupPage({super.key});

  @override
  State<PasswordSetupPage> createState() => _PasswordSetupPageState();
}

class _PasswordSetupPageState extends State<PasswordSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  // パスワード要件チェック（フィグマワイヤーフレームに基づく）
  bool get _hasMinLength => _passwordController.text.length >= 8;
  bool get _hasLetter => _passwordController.text.contains(RegExp(r'[a-zA-Z]'));
  bool get _hasNumber => _passwordController.text.contains(RegExp(r'[0-9]'));
  bool get _passwordsMatch => _passwordController.text == _confirmPasswordController.text && _passwordController.text.isNotEmpty;
  
  bool get _isPasswordValid => _hasMinLength && _hasLetter && _hasNumber;
  
  String? _passwordMismatchError;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleContinue() async {
    // 確認パスワードが入力されている場合は一致を確認
    if (_confirmPasswordController.text.isNotEmpty && !_passwordsMatch) {
      setState(() {
        _passwordMismatchError = 'パスワードが一致しません';
      });
      return;
    }

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() => _isLoading = false);
      context.go(AppRouter.interestCategories);
    }
  }

  void _validatePasswordMatch() {
    setState(() {
      if (_confirmPasswordController.text.isNotEmpty && !_passwordsMatch) {
        _passwordMismatchError = 'パスワードが一致しません';
      } else {
        _passwordMismatchError = null;
      }
    });
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
              currentStep: 5,
              totalSteps: 8,
              title: 'パスワード設定',
              subtitle: '安全なパスワードを設定してください',
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(21.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Page Title
                    Text(
                      'パスワードを設定',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Password Requirements Checker
                    PasswordRequirementChecker(password: _passwordController.text),

                    const SizedBox(height: 24),

                    // Password Field with Strength Indicator
                    PasswordInputField(
                      controller: _passwordController,
                      label: 'パスワード',
                      showStrengthIndicator: true,
                      onChanged: (value) {
                        setState(() {});
                        _validatePasswordMatch();
                      },
                    ),

                    const SizedBox(height: 24),

                    // Confirm Password Field
                    PasswordInputField(
                      controller: _confirmPasswordController,
                      label: 'パスワード確認',
                      errorText: _passwordMismatchError,
                      onChanged: (value) {
                        _validatePasswordMatch();
                      },
                    ),

                    const SizedBox(height: 32),
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
                      onPressed: _isPasswordValid && 
                          (_confirmPasswordController.text.isEmpty || _passwordsMatch)
                          ? _handleContinue
                          : null,
                      text: '続ける',
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
