import 'package:flutter/material.dart';

enum PasswordStrength {
  weak,
  medium,
  strong,
}

class PasswordStrengthIndicator extends StatelessWidget {
  const PasswordStrengthIndicator({
    super.key,
    required this.password,
  });

  final String password;

  PasswordStrength _calculateStrength() {
    if (password.isEmpty) return PasswordStrength.weak;
    
    int score = 0;
    
    // Length check
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    
    // Character type checks
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[a-z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score++;
    
    if (score <= 2) return PasswordStrength.weak;
    if (score <= 4) return PasswordStrength.medium;
    return PasswordStrength.strong;
  }

  String _getStrengthLabel() {
    switch (_calculateStrength()) {
      case PasswordStrength.weak:
        return '弱い';
      case PasswordStrength.medium:
        return '普通';
      case PasswordStrength.strong:
        return '強い';
    }
  }

  Color _getStrengthColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (_calculateStrength()) {
      case PasswordStrength.weak:
        return colorScheme.error;
      case PasswordStrength.medium:
        return const Color(0xFFEBA300); // Orange color from wireframe
      case PasswordStrength.strong:
        return const Color(0xFF00C33F); // Green color from wireframe
    }
  }

  double _getStrengthProgress() {
    switch (_calculateStrength()) {
      case PasswordStrength.weak:
        return 0.25;
      case PasswordStrength.medium:
        return 0.65;
      case PasswordStrength.strong:
        return 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strength = _calculateStrength();
    final strengthColor = _getStrengthColor(context);
    
    if (password.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Progress Bar
          Expanded(
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(2),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _getStrengthProgress(),
                child: Container(
                  decoration: BoxDecoration(
                    color: strengthColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Strength Label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: strengthColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              _getStrengthLabel(),
              style: theme.textTheme.bodySmall?.copyWith(
                color: strengthColor,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

