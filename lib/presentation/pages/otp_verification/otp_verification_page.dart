import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_router.dart';
import '../../widgets/common/primary_button.dart';
import '../../widgets/common/progress_header.dart';
import '../../widgets/forms/otp_input_field.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _otpController = TextEditingController();
  bool _isLoading = false;
  int _remainingSeconds = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      _remainingSeconds = 60;
      _canResend = false;
    });

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;

      setState(() => _remainingSeconds--);

      if (_remainingSeconds <= 0) {
        setState(() => _canResend = true);
        return false;
      }
      return true;
    });
  }

  Future<void> _handleContinue() async {
    if (_otpController.text.length != 6) return;

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() => _isLoading = false);
      context.go(AppRouter.basicInfo);
    }
  }

  Future<void> _handleResendCode() async {
    // Simulate resend API call
    await Future.delayed(const Duration(milliseconds: 500));
    _startCountdown();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('確認コードを再送信しました'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Progress Header
            ProgressHeader(
              currentStep: 3,
              totalSteps: 8,
              onBackPressed: () => context.go(AppRouter.emailInput),
            ),
            
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 200,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                    const SizedBox(height: 24),
                    
                    // Title
                    Text(
                      '確認コードを入力',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Email Info with Icon
                    Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onSurface.withOpacity(0.7),
                              ),
                              children: [
                                TextSpan(text: widget.email),
                                const TextSpan(text: ' に送信されたコードを入力してください'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    
                    // OTP Input Field
                    OtpInputField(
                      controller: _otpController,
                      onCompleted: (value) => _handleContinue(),
                      onChanged: (value) => setState(() {}),
                    ),
                    const SizedBox(height: 24),
                    
                    // Resend Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _canResend ? '' : '残り ${_remainingSeconds}秒',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                        TextButton(
                          onPressed: _canResend ? _handleResendCode : null,
                          child: const Text('コードを再送'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Change Email Button
                    TextButton(
                      onPressed: () => context.go(AppRouter.emailInput),
                      child: const Text('メールアドレスを変更'),
                    ),
                    const SizedBox(height: 32),
                    
                    // Continue Button
                    PrimaryButton(
                      text: '続ける',
                      onPressed: _handleContinue,
                      isLoading: _isLoading,
                      isEnabled: _otpController.text.length == 6,
                    ),
                  ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
