import 'package:flutter/material.dart';

class PasswordRequirementChecker extends StatelessWidget {
  const PasswordRequirementChecker({
    super.key,
    required this.password,
  });

  final String password;

  bool get _hasMinLength => password.length >= 8;
  bool get _hasLetter => password.contains(RegExp(r'[a-zA-Z]'));
  bool get _hasNumber => password.contains(RegExp(r'[0-9]'));

  Widget _buildRequirementItem(
    BuildContext context,
    String text,
    bool isValid,
  ) {
    final theme = Theme.of(context);
    final color = isValid 
        ? const Color(0xFF00A63E) // Green from wireframe
        : theme.colorScheme.onSurfaceVariant.withOpacity(0.6);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isValid ? color : Colors.transparent,
              border: Border.all(
                color: color,
                width: 1.5,
              ),
            ),
            child: isValid
                ? Icon(
                    Icons.check,
                    size: 10,
                    color: Colors.white,
                  )
                : null,
          ),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isValid ? color : theme.colorScheme.onSurfaceVariant,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '以下の条件を満たすパスワードを設定してください：',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          _buildRequirementItem(context, '8文字以上', _hasMinLength),
          _buildRequirementItem(context, '英字を含む', _hasLetter),
          _buildRequirementItem(context, '数字を含む', _hasNumber),
        ],
      ),
    );
  }
}

