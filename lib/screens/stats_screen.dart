import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/quiz_provider.dart';
import '../data/question_bank.dart';
import 'result_screen.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text('İstatistikler', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          Consumer<QuizProvider>(
            builder: (context, provider, _) => IconButton(
              onPressed: () => _showResetDialog(context, provider),
              icon: Icon(Icons.delete_outline, color: theme.colorScheme.onSurface.withOpacity(0.5)),
            ),
          ),
        ],
      ),
      body: Consumer<QuizProvider>(
        builder: (context, provider, child) {
          if (provider.totalQuizzesTaken == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bar_chart_rounded, size: 64, color: primary.withOpacity(0.3)),
                  const SizedBox(height: 16),
                  Text('Henüz quiz çözmedin', style: GoogleFonts.poppins(fontSize: 18, color: theme.colorScheme.onSurface.withOpacity(0.5))),
                  const SizedBox(height: 8),
                  Text('İlk quiz\'ini çözdüğünde istatistiklerin burada görünecek.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: 13, color: theme.colorScheme.onSurface.withOpacity(0.3))),
                ],
              ),
            );
          }

          final successRate = provider.totalCorrect + provider.totalWrong > 0
              ? (provider.totalCorrect / (provider.totalCorrect + provider.totalWrong)) * 100 : 0.0;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Genel istatistik kartları
                Row(
                  children: [
                    Expanded(child: _buildStatCard('Toplam Quiz', '${provider.totalQuizzesTaken}', Icons.quiz_outlined, primary, theme)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildStatCard('Başarı Oranı', '%${successRate.toStringAsFixed(1)}', Icons.trending_up, Colors.amberAccent, theme)),
                  ],
                ).animate().fadeIn(duration: 400.ms),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildStatCard('Toplam Doğru', '${provider.totalCorrect}', Icons.check_circle_outline, Colors.greenAccent, theme)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildStatCard('Toplam Yanlış', '${provider.totalWrong}', Icons.cancel_outlined, Colors.redAccent, theme)),
                  ],
                ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

                const SizedBox(height: 28),

                Text('Quiz Geçmişi', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface))
                    .animate().fadeIn(delay: 400.ms),
                const SizedBox(height: 4),
                Text('Detayları görmek için bir quize dokun', style: GoogleFonts.poppins(fontSize: 12, color: theme.colorScheme.onSurface.withOpacity(0.4)))
                    .animate().fadeIn(delay: 450.ms),
                const SizedBox(height: 12),

                if (provider.quizHistory.isEmpty)
                  Text('Henüz geçmiş yok.', style: GoogleFonts.poppins(color: theme.colorScheme.onSurface.withOpacity(0.4)))
                else
                  ...provider.quizHistory.asMap().entries.map((entry) {
                    final index = entry.key;
                    final result = entry.value;
                    final dateStr = DateFormat('dd MMM yyyy, HH:mm', 'tr').format(result.date);

                    Color gradeColor;
                    if (result.scorePercentage >= 80) gradeColor = Colors.greenAccent;
                    else if (result.scorePercentage >= 60) gradeColor = Colors.orangeAccent;
                    else gradeColor = Colors.redAccent;

                    return GestureDetector(
                      onTap: () {
                        // Quiz detayına git (eğer cevaplar kaydedilmişse)
                        if (result.answeredQuestions.isNotEmpty) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (_) => ResultScreen(result: result),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Bu quizin soru detayları mevcut değil.', style: GoogleFonts.poppins()),
                              backgroundColor: theme.cardColor,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.cardColor, borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: theme.dividerColor),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48, height: 48,
                              decoration: BoxDecoration(
                                color: gradeColor.withOpacity(0.15), borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(result.grade, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: gradeColor)),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(QuestionBank.getCategoryName(result.category),
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface)),
                                  Text('${result.correctAnswers}/${result.totalQuestions} doğru • $dateStr',
                                      style: GoogleFonts.poppins(fontSize: 12, color: theme.colorScheme.onSurface.withOpacity(0.5))),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text('%${result.scorePercentage.toStringAsFixed(0)}',
                                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: gradeColor)),
                                if (result.answeredQuestions.isNotEmpty)
                                  Icon(Icons.chevron_right, size: 18, color: theme.colorScheme.onSurface.withOpacity(0.3)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(delay: Duration(milliseconds: 500 + index * 100), duration: 400.ms);
                  }),

                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor, borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 10),
          Text(value, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: theme.colorScheme.onSurface)),
          Text(label, style: GoogleFonts.poppins(fontSize: 12, color: theme.colorScheme.onSurface.withOpacity(0.5))),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context, QuizProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('İstatistikleri Sıfırla', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        content: Text('Tüm istatistikler ve quiz geçmişi silinecek. Bu işlem geri alınamaz.', style: GoogleFonts.poppins(fontSize: 14)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('İptal', style: GoogleFonts.poppins())),
          ElevatedButton(
            onPressed: () { provider.resetStats(); Navigator.pop(context); },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: Text('Sıfırla', style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
