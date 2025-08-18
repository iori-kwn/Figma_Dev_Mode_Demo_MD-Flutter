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
  bool _acceptTermsAndPrivacy = false; // Combined as shown in wireframe
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

  Widget _buildCheckboxItem({
    required String text,
    required bool value,
    required ValueChanged<bool?> onChanged,
    bool isRequired = false,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(right: 12, top: 2),
            decoration: BoxDecoration(
              color: value ? theme.colorScheme.onSurface : Colors.transparent,
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.6),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: value
                ? Icon(
                    Icons.check,
                    size: 14,
                    color: Colors.white,
                  )
                : null,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(!value),
              child: Text(
                text,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontSize: 14,
                  fontWeight: isRequired ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
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
    final canContinue = _acceptTermsAndPrivacy;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Progress Header
            const ProgressHeader(
              currentStep: 7,
              totalSteps: 8,
              title: '利用規約・プライバシーポリシー',
              subtitle: '必須項目にご同意ください',
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
                      '利用規約・プライバシーポリシー',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Summary Box (Based on wireframe)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.colorScheme.outline.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '利用規約・プライバシーポリシーの要約',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Summary List
                          ...[
                            '• お客様の個人情報を適切に保護します',
                            '• サービス向上のためのデータ活用について',
                            '• 禁止行為とアカウント停止について',
                            '• お客様の権利と義務について',
                          ].map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              item,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontSize: 14,
                              ),
                            ),
                          )),

                          const SizedBox(height: 16),

                          // Detail Links
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: _showTermsDialog,
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  child: Text(
                                    '利用規約全文',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.primary,
                                      decoration: TextDecoration.underline,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: _showPrivacyDialog,
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  child: Text(
                                    'プライバシーポリシー全文',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.primary,
                                      decoration: TextDecoration.underline,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Agreement Checkboxes
                    _buildCheckboxItem(
                      text: '利用規約およびプライバシーポリシーに同意します（必須）',
                      value: _acceptTermsAndPrivacy,
                      onChanged: (value) => setState(() => _acceptTermsAndPrivacy = value ?? false),
                      isRequired: true,
                    ),

                    const SizedBox(height: 8),

                    // Divider
                    Container(
                      height: 1,
                      color: theme.colorScheme.outline.withOpacity(0.2),
                    ),

                    const SizedBox(height: 16),

                    _buildCheckboxItem(
                      text: 'キャンペーン・お得な情報をメールで受け取る（任意）',
                      value: _acceptMarketing,
                      onChanged: (value) => setState(() => _acceptMarketing = value ?? false),
                      isRequired: false,
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
                      onPressed: canContinue ? _handleContinue : null,
                      text: '同意して登録',
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
