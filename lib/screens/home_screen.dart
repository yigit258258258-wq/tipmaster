import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'quiz_setup_screen.dart';
import 'stats_screen.dart';
import 'wrong_questions_screen.dart';
import 'add_question_screen.dart';
import 'theme_selector_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final quizProvider = Provider.of<QuizProvider>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.surface,
              theme.scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Üst bar - Logo ve Ayarlar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_awesome, color: primary, size: 28),
                        const SizedBox(width: 10),
                        Text(
                          'TıpMaster',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: primary,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ThemeSelectorScreen()),
                        );
                      },
                      icon: Icon(Icons.palette_outlined,
                          color: theme.colorScheme.onSurface.withOpacity(0.7)),
                    ),
                  ],
                ).animate().fadeIn(duration: 500.ms),

                const SizedBox(height: 8),

                // Motto
                Text(
                  'Bilgi iyileştirir, öğrenmek güçlendirir.',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                    fontStyle: FontStyle.italic,
                  ),
                ).animate().fadeIn(delay: 200.ms, duration: 500.ms),

                const SizedBox(height: 32),

                // Hızlı İstatistik Kartları
                _buildQuickStats(context, quizProvider)
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 600.ms)
                    .slideY(begin: 0.1),

                const SizedBox(height: 32),

                // Ana Menü Başlığı
                Text(
                  'Ne yapmak istersin?',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ).animate().fadeIn(delay: 400.ms, duration: 500.ms),

                const SizedBox(height: 16),

                // Menü Kartları
                _buildMenuCard(
                  context,
                  icon: Icons.play_circle_outline,
                  title: 'Quiz Başlat',
                  subtitle: 'Kategori, süre ve soru sayısını ayarla',
                  color: primary,
                  delay: 500,
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const QuizSetupScreen())),
                ),

                _buildMenuCard(
                  context,
                  icon: Icons.refresh,
                  title: 'Yanlışları Tekrar Çalış',
                  subtitle: '${quizProvider.wrongQuestionPool.length} soru bekliyor',
                  color: theme.colorScheme.error,
                  delay: 600,
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const WrongQuestionsScreen())),
                ),

                _buildMenuCard(
                  context,
                  icon: Icons.bar_chart_rounded,
                  title: 'İstatistikler',
                  subtitle: 'Performansını takip et',
                  color: theme.colorScheme.secondary,
                  delay: 700,
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const StatsScreen())),
                ),

                _buildMenuCard(
                  context,
                  icon: Icons.add_circle_outline,
                  title: 'Soru Ekle',
                  subtitle: 'Kendi sorularını oluştur',
                  color: Colors.amber,
                  delay: 800,
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AddQuestionScreen())),
                ),

                _buildMenuCard(
                  context,
                  icon: Icons.palette_outlined,
                  title: 'Tema Değiştir',
                  subtitle: 'Uygulamayı kişiselleştir',
                  color: Colors.pinkAccent,
                  delay: 900,
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ThemeSelectorScreen())),
                ),

                _buildMenuCard(
                  context,
                  icon: Icons.info_outline,
                  title: 'Hakkında',
                  subtitle: 'Uygulama bilgileri ve kaynaklar',
                  color: Colors.tealAccent,
                  delay: 1000,
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AboutScreen())),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context, QuizProvider provider) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            context,
            value: '${provider.totalQuizzesTaken}',
            label: 'Quiz',
            icon: Icons.quiz_outlined,
          ),
          Container(
            width: 1,
            height: 40,
            color: theme.dividerColor,
          ),
          _buildStatItem(
            context,
            value: '${provider.totalCorrect}',
            label: 'Doğru',
            icon: Icons.check_circle_outline,
            color: Colors.greenAccent,
          ),
          Container(
            width: 1,
            height: 40,
            color: theme.dividerColor,
          ),
          _buildStatItem(
            context,
            value: provider.totalQuizzesTaken > 0
                ? '%${((provider.totalCorrect / (provider.totalCorrect + provider.totalWrong)) * 100).toStringAsFixed(0)}'
                : '%0',
            label: 'Başarı',
            icon: Icons.trending_up,
            color: Colors.amberAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context,
      {required String value,
      required String label,
      required IconData icon,
      Color? color}) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(icon, size: 22, color: color ?? theme.colorScheme.primary),
        const SizedBox(height: 6),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: theme.colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required int delay,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: color.withOpacity(0.15),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right,
                    color: theme.colorScheme.onSurface.withOpacity(0.3)),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay), duration: 500.ms)
        .slideX(begin: 0.05, duration: 500.ms);
  }
}
