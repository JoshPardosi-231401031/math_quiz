import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../utils/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import 'quiz_screen.dart';

/// Home Screen - Input Username & NIM
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _usernameController = TextEditingController();
  final _nimController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _canStart = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_checkCanStart);
    _nimController.addListener(_checkCanStart);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _nimController.dispose();
    super.dispose();
  }

  void _checkCanStart() {
    setState(() {
      _canStart = _usernameController.text.isNotEmpty &&
          _nimController.text.isNotEmpty;
    });
  }

  void _startQuiz() {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<QuizProvider>(context, listen: false);
      provider.setUserInfo(
        _usernameController.text,
        _nimController.text,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const QuizScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final maxWidth = Responsive.getMaxWidth(context);

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,

      // App Bar
      appBar: AppBar(
        backgroundColor: isDark
            ? AppColors.cardBackgroundDark
            : AppColors.cardBackgroundLight,
        elevation: 0,
        title: Row(
          children: [
            Icon(
              Icons.calculate_outlined,
              size: Responsive.getIconSize(context, mobile: 24),
              color: isDark
                  ? AppColors.primaryDark
                  : AppColors.primaryLight,
            ),
            SizedBox(width: Responsive.getSpacing(context, 8)),
            Text(
              'Math Quiz',
              style: AppTextStyles.headingSmall(context).copyWith(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
            ),
          ],
        ),
        actions: [
          Consumer<QuizProvider>(
            builder: (context, provider, _) {
              return IconButton(
                icon: Icon(
                  provider.isDarkMode
                      ? Icons.light_mode
                      : Icons.dark_mode_outlined,
                ),
                onPressed: () {
                  provider.toggleTheme();
                },
              );
            },
          ),
        ],
      ),

      // Body
      body: Center(
        child: SingleChildScrollView(
          padding: Responsive.getPadding(context),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Welcome Card
                  _buildWelcomeCard(isDark),

                  SizedBox(height: Responsive.getSpacing(context, 24)),

                  // Info Card
                  _buildInfoCard(isDark),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(bool isDark) {
    return Container(
      padding: EdgeInsets.all(Responsive.getSpacing(context, 40)),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.cardBackgroundDark
            : AppColors.cardBackgroundLight,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Calculator Icon
          Container(
            width: Responsive.isMobile(context) ? 64 : 80,
            height: Responsive.isMobile(context) ? 64 : 80,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.primaryDarkBg
                  : AppColors.primaryLightBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.calculate_outlined,
              size: Responsive.isMobile(context) ? 32 : 40,
              color: isDark
                  ? AppColors.primaryDark
                  : AppColors.primaryLight,
            ),
          ),

          SizedBox(height: Responsive.getSpacing(context, 24)),

          // Welcome Text
          Text(
            'Welcome!',
            style: AppTextStyles.headingLarge(context).copyWith(
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: Responsive.getSpacing(context, 8)),

          Text(
            'Silakan isi data Anda untuk memulai quiz matematika',
            style: AppTextStyles.bodyRegular(context).copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: Responsive.getSpacing(context, 32)),

          // Form
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 448),
            child: Column(
              children: [
                // Username Input
                CustomInput(
                  label: 'Username',
                  controller: _usernameController,
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username tidak boleh kosong';
                    }
                    return null;
                  },
                ),

                SizedBox(height: Responsive.getSpacing(context, 24)),

                // NIM Input
                CustomInput(
                  label: 'NIM',
                  controller: _nimController,
                  prefixIcon: Icons.numbers,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'NIM tidak boleh kosong';
                    }
                    return null;
                  },
                ),

                SizedBox(height: Responsive.getSpacing(context, 24)),

                // Start Button
                CustomButton(
                  text: 'Mulai Math Quiz',
                  onPressed: _canStart ? _startQuiz : null,
                  icon: Icons.play_arrow,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(bool isDark) {
    return Container(
      padding: EdgeInsets.all(Responsive.getSpacing(context, 24)),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.cardBackgroundDark
            : AppColors.cardBackgroundLight,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: Responsive.getIconSize(context, mobile: 20),
                color: isDark
                    ? AppColors.primaryDark
                    : AppColors.primaryLight,
              ),
              SizedBox(width: Responsive.getSpacing(context, 8)),
              Text(
                'Tentang Quiz',
                style: AppTextStyles.bodyMedium(context).copyWith(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          SizedBox(height: Responsive.getSpacing(context, 12)),

          Text(
            'Quiz ini berisi 10 soal tentang barisan deret aritmatika dan geometri. '
                'Setiap jawaban akan memberikan feedback langsung dengan warna hijau untuk benar '
                'dan merah untuk salah.',
            style: AppTextStyles.bodyRegular(context).copyWith(
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
          ),

          SizedBox(height: Responsive.getSpacing(context, 12)),

          // Stats
          Row(
            children: [
              _buildStatItem('5', 'Soal Aritmatika', isDark),
              SizedBox(width: Responsive.getSpacing(context, 16)),
              _buildStatItem('5', 'Soal Geometri', isDark),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.backgroundDark
              : AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTextStyles.headingMedium(context).copyWith(
                color: isDark
                    ? AppColors.primaryDark
                    : AppColors.primaryLight,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.bodySmall(context).copyWith(
                color: isDark
                    ? AppColors.textMutedDark
                    : AppColors.textMutedLight,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
