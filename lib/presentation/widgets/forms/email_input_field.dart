import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailInputField extends StatefulWidget {
  const EmailInputField({
    super.key,
    required this.controller,
    this.onFieldSubmitted,
    this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;

  @override
  State<EmailInputField> createState() => _EmailInputFieldState();
}

class _EmailInputFieldState extends State<EmailInputField> {
  bool _hasInteracted = false;

  String? _validateEmail(String? value) {
    if (!_hasInteracted) return null;
    
    if (value == null || value.isEmpty) {
      return 'メールアドレスを入力してください';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return '有効なメールアドレスを入力してください';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          'メールアドレス',
          style: theme.textTheme.labelLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        
        // Text Field
        TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autocorrect: false,
          enableSuggestions: true,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')), // No spaces
          ],
          decoration: InputDecoration(
            hintText: 'example@email.com',
            prefixIcon: Icon(
              Icons.email_outlined,
              color: colorScheme.onSurfaceVariant,
            ),
            suffixIcon: widget.controller.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      widget.controller.clear();
                      widget.onChanged?.call('');
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.clear,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  )
                : null,
          ),
          validator: _validateEmail,
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: (value) {
            if (!_hasInteracted) {
              setState(() => _hasInteracted = true);
            }
            widget.onChanged?.call(value);
            setState(() {}); // Update suffix icon
          },
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        
        // Helper Text
        const SizedBox(height: 8),
        Text(
          '確認のため、有効なメールアドレスをご入力ください',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
