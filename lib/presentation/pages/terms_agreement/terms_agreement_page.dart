import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../routes/app_router.dart';
import '../../widgets/common/primary_button.dart';
import '../../widgets/common/secondary_button.dart';
import '../../widgets/common/progress_header.dart';

class TermsAgreementPage extends StatefulWidget {
  const TermsAgreementPage({super.key});

  @override
  State<TermsAgreementPage> createState() => _TermsAgreementPageState();
}

class _TermsAgreementPageState extends State<TermsAgreementPage> {
  bool _isLoading = false;
  bool _acceptTerms = false;
  bool _acceptPrivacy = false;
  bool _acceptMarketing = false;

  Future<void> _handleContinue() async {
    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() => _isLoading = false);
      context.go(AppRouter.registrationSuccess);
    }
  }

  Widget _buildAgreementItem({
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool?> onChanged,
    bool isRequired = false,
    VoidCallback? onViewDetails,
  }) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value
              ? theme.colorScheme.primary
              : theme.colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: value,
                onChanged: onChanged,
                activeColor: theme.colorScheme.primary,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (isRequired) ...[
                          const SizedBox(width: 4),
                          Text(
                            '(必須)',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.error,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (onViewDetails != null)
                TextButton(
                  onPressed: onViewDetails,
                  child: Text(
                    '詳細',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('利用規約'),
        content: const SingleChildScrollView(
          child: Text(
            '【利用規約】\n\n'
            '第1条（適用）\n'
            '本規約は、本サービスの利用に関して、当社とユーザーとの間の権利義務関係を定めることを目的とし、ユーザーと当社との間で締結される契約です。\n\n'
            '第2条（利用登録）\n'
            '本サービスにおいては、登録希望者が本規約に同意の上、当社の定める方法によって利用登録を申請し、当社がこれを承認することによって利用登録が完了するものとします。\n\n'
            '第3条（禁止事項）\n'
            'ユーザーは、本サービスの利用にあたり、以下の行為をしてはなりません。\n'
            '・法令または公序良俗に違反する行為\n'
            '・犯罪行為に関連する行為\n'
            '・当社、本サービスの他のユーザー、または第三者のサーバーまたはネットワークの機能を破壊したり、妨害したりする行為\n\n'
            '第4条（本サービスの提供の停止等）\n'
            '当社は、以下のいずれかの事由があると判断した場合、ユーザーに事前に通知することなく本サービスの全部または一部の提供を停止または中断することができるものとします。',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('プライバシーポリシー'),
        content: const SingleChildScrollView(
          child: Text(
            '【プライバシーポリシー】\n\n'
            '当社は、本サービスにおけるユーザーの個人情報の取扱いについて、以下のとおりプライバシーポリシーを定めます。\n\n'
            '第1条（個人情報）\n'
            '「個人情報」とは、個人情報保護法にいう「個人情報」を指すものとし、生存する個人に関する情報であって、当該情報に含まれる氏名、生年月日、住所、電話番号、連絡先その他の記述等により特定の個人を識別できる情報及び容貌、指紋、声紋にかかるデータ、及び健康保険証の保険者番号などの当該情報単体から特定の個人を識別できる情報を指します。\n\n'
            '第2条（個人情報の収集方法）\n'
            '当社は、ユーザーが利用登録をする際に氏名、生年月日、住所、電話番号、メールアドレス、銀行口座番号、クレジットカード番号、運転免許証番号などの個人情報をお尋ねすることがあります。\n\n'
            '第3条（個人情報を収集・利用する目的）\n'
            '当社が個人情報を収集・利用する目的は、以下のとおりです。\n'
            '・本サービスの提供・運営のため\n'
            '・ユーザーからのお問い合わせに回答するため\n'
            '・ユーザーが利用中のサービスの新機能、更新情報、キャンペーン等及び当社が提供する他のサービスの案内のメールを送付するため',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final canContinue = _acceptTerms && _acceptPrivacy;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Progress Header
            const ProgressHeader(
              currentStep: 7,
              totalSteps: 8,
              title: '利用規約への同意',
              subtitle: '必須項目にご同意ください',
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Header Message
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: theme.colorScheme.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'サービスを利用するために、以下の規約をお読みいただき、同意してください。',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Terms Agreement
                    _buildAgreementItem(
                      title: '利用規約',
                      description: 'サービスの利用条件や禁止事項について定めた規約です。',
                      value: _acceptTerms,
                      onChanged: (value) => setState(() => _acceptTerms = value ?? false),
                      isRequired: true,
                      onViewDetails: _showTermsDialog,
                    ),

                    // Privacy Policy Agreement
                    _buildAgreementItem(
                      title: 'プライバシーポリシー',
                      description: '個人情報の取り扱いについて定めたポリシーです。',
                      value: _acceptPrivacy,
                      onChanged: (value) => setState(() => _acceptPrivacy = value ?? false),
                      isRequired: true,
                      onViewDetails: _showPrivacyDialog,
                    ),

                    // Marketing Agreement (Optional)
                    _buildAgreementItem(
                      title: 'マーケティング情報の受信',
                      description: '新機能やキャンペーン情報をメールでお知らせします。',
                      value: _acceptMarketing,
                      onChanged: (value) => setState(() => _acceptMarketing = value ?? false),
                      isRequired: false,
                    ),

                    const SizedBox(height: 24),

                    // Agreement Status
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: canContinue
                            ? theme.colorScheme.primaryContainer
                            : theme.colorScheme.errorContainer.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: canContinue
                              ? theme.colorScheme.primary
                              : theme.colorScheme.error,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            canContinue ? Icons.check_circle : Icons.error_outline,
                            color: canContinue
                                ? theme.colorScheme.primary
                                : theme.colorScheme.error,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              canContinue
                                  ? '必須項目にすべて同意いただきました'
                                  : '必須項目への同意が必要です',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: canContinue
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.error,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Additional Notice
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.colorScheme.outlineVariant,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.security,
                                color: theme.colorScheme.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'セキュリティについて',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '• 個人情報は暗号化して安全に保存されます\n'
                            '• 同意はいつでも設定画面から変更可能です\n'
                            '• マーケティング情報は配信停止できます',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
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
                      onPressed: canContinue ? _handleContinue : null,
                      text: '同意して登録完了',
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
