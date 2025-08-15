import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../pages/welcome/welcome_page.dart';
import '../pages/email_input/email_input_page.dart';
import '../pages/otp_verification/otp_verification_page.dart';
import '../pages/basic_info/basic_info_page.dart';
import '../pages/password_setup/password_setup_page.dart';
import '../pages/interest_categories/interest_categories_page.dart';
import '../pages/terms_agreement/terms_agreement_page.dart';
import '../pages/registration_success/registration_success_page.dart';

class AppRouter {
  AppRouter._();

  // Route names
  static const String welcome = '/';
  static const String emailInput = '/email-input';
  static const String otpVerification = '/otp-verification';
  static const String basicInfo = '/basic-info';
  static const String passwordSetup = '/password-setup';
  static const String interestCategories = '/interest-categories';
  static const String termsAgreement = '/terms-agreement';
  static const String registrationSuccess = '/registration-success';

  static final GoRouter router = GoRouter(
    initialLocation: welcome,
    routes: [
      // Welcome Screen
      GoRoute(
        path: welcome,
        name: 'welcome',
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const WelcomePage(),
        ),
      ),

      // Email Input Screen
      GoRoute(
        path: emailInput,
        name: 'email-input',
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const EmailInputPage(),
        ),
      ),

      // OTP Verification Screen
      GoRoute(
        path: otpVerification,
        name: 'otp-verification',
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          OtpVerificationPage(
            email: state.extra as String? ?? '',
          ),
        ),
      ),

      // Basic Info Screen
      GoRoute(
        path: basicInfo,
        name: 'basic-info',
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const BasicInfoPage(),
        ),
      ),

      // Password Setup Screen
      GoRoute(
        path: passwordSetup,
        name: 'password-setup',
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const PasswordSetupPage(),
        ),
      ),

      // Interest Categories Screen
      GoRoute(
        path: interestCategories,
        name: 'interest-categories',
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const InterestCategoriesPage(),
        ),
      ),

      // Terms Agreement Screen
      GoRoute(
        path: termsAgreement,
        name: 'terms-agreement',
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const TermsAgreementPage(),
        ),
      ),

      // Registration Success Screen
      GoRoute(
        path: registrationSuccess,
        name: 'registration-success',
        pageBuilder: (context, state) => _buildPageWithTransition(
          context,
          state,
          const RegistrationSuccessPage(),
        ),
      ),
    ],
  );

  // Custom page transition builder
  static Page<void> _buildPageWithTransition(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
