import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/quiz_result.dart';
import '../models/question.dart';
import 'home_screen.dart';

class ResultScreen extends StatefulWidget {
  final QuizResult result;
  const ResultScreen({super.key, required this.result});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _filter = 'all'; // 'all', 'correct', 'wrong', 'skipped'

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final result = widget.result;

    Color gradeColor;
    String gradeEmoji;
    String gradeMessage;

    if (result.scorePercentage >= 90) {
      gradeColor = Colors.greenAccent; gradeEmoji = '🏆'; gradeMessage = 'Muhteşem! Tıp uzmanı gibisin!';
    } else if (result.scorePercentage >= 70) {
      gradeColor = Colors.lightGreenAccent; gradeEmoji = '👏'; gradeMessage = 'Harika iş çıkardın!';
    } else if (result.scorePercentage >= 50) {
      gradeColor = Colors.orangeAccent; gradeEmoji = '💪'; gradeMessage = 'Fena değil, biraz daha çalışmayla mükemmel!';
    } else {
      gradeColor = Colors.redAccent; gradeEmoji = '📚'; gradeMessage = 'Yanlışlarını gözden geçirmeye ne dersin?';
    }

    int skippedCount = result.answeredQuestions.where((a) => a['isSkipped'] == true).length;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Tab Bar
              Container(
                color: theme.colorScheme.surface,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: primary,
                  labelColor: primary,
                  unselectedLabelColor: theme.colorScheme.onSurface.withOpacity(0.5),
                  labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  tabs: const [
                    Tab(text: 'Sonuç'),
                    Tab(text: 'Soru Analizi'),
                  ],
                ),
              ),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // ============================================================
                    // TAB 1: SONUÇ ÖZETİ
                    // ============================================================
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Text(gradeEmoji, style: const TextStyle(fontSize: 64))
                              .animate().fadeIn(duration: 600.ms)
                              .scale(begin: const Offset(0.3, 0.3), curve: Curves.easeOutBack),
                          const SizedBox(height: 16),
                          Text(result.grade, style: GoogleFonts.playfairDisplay(
                            fontSize: 56, fontWeight: FontWeight.w700, color: gradeColor,
                          )).animate().fadeIn(delay: 300.ms, duration: 600.ms),
                          const SizedBox(height: 8),
                          Text(gradeMessage, textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(fontSize: 16, color: theme.colorScheme.onSurface.withOpacity(0.7)))
                              .animate().fadeIn(delay: 500.ms, duration: 600.ms),
                          const SizedBox(height: 32),

                          // Skor kartı
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: theme.cardColor, borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: gradeColor.withOpacity(0.2)),
                            ),
                            child: Column(
                              children: [
                                Text('%${result.scorePercentage.toStringAsFixed(0)}', style: GoogleFonts.poppins(
                                  fontSize: 48, fontWeight: FontWeight.w700, color: gradeColor,
                                )),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildStatBox('Toplam', '${result.totalQuestions}', primary, theme),
                                    _buildStatBox('Doğru', '${result.correctAnswers}', Colors.greenAccent, theme),
                                    _buildStatBox('Yanlış', '${result.wrongAnswers - skippedCount}', Colors.redAccent, theme),
                                    _buildStatBox('Atlandı', '$skippedCount', Colors.orangeAccent, theme),
                                  ],
                                ),
                              ],
                            ),
                          ).animate().fadeIn(delay: 700.ms, duration: 600.ms).slideY(begin: 0.1),

                          const SizedBox(height: 24),

                          // Detaylı analiz butonu
                          SizedBox(
                            width: double.infinity, height: 52,
                            child: OutlinedButton.icon(
                              onPressed: () => _tabController.animateTo(1),
                              icon: Icon(Icons.analytics_outlined, color: primary),
                              label: Text('Soru Analizini Gör', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: primary)),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: primary),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              ),
                            ),
                          ).animate().fadeIn(delay: 900.ms),

                          const SizedBox(height: 16),

                          // Ana menü butonu
                          SizedBox(
                            width: double.infinity, height: 52,
                            child: ElevatedButton(
                              onPressed: () => Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false),
                              child: Text('Ana Menüye Dön', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                            ),
                          ).animate().fadeIn(delay: 1000.ms),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),

                    // ============================================================
                    // TAB 2: SORU ANALİZİ (DETAYLI)
                    // ============================================================
                    Column(
                      children: [
                        // Filtre çipleri
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                _buildFilterChip('Tümü (${result.answeredQuestions.length})', 'all', theme, primary),
                                const SizedBox(width: 8),
                                _buildFilterChip('Doğru (${result.correctAnswers})', 'correct', theme, Colors.greenAccent),
                                const SizedBox(width: 8),
                                _buildFilterChip('Yanlış (${result.wrongAnswers - skippedCount})', 'wrong', theme, Colors.redAccent),
                                const SizedBox(width: 8),
                                _buildFilterChip('Atlandı ($skippedCount)', 'skipped', theme, Colors.orangeAccent),
                              ],
                            ),
                          ),
                        ),

                        // Soru listesi
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: _getFilteredQuestions(result).length,
                            itemBuilder: (context, index) {
                              final data = _getFilteredQuestions(result)[index];
                              return _buildDetailedQuestionCard(data, theme, primary);
                            },
                          ),
                        ),

                        // Ana menü butonu
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                            width: double.infinity, height: 48,
                            child: ElevatedButton(
                              onPressed: () => Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false),
                              child: Text('Ana Menüye Dön', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredQuestions(QuizResult result) {
    switch (_filter) {
      case 'correct': return result.answeredQuestions.where((a) => a['isCorrect'] == true).toList();
      case 'wrong': return result.answeredQuestions.where((a) => a['isCorrect'] == false && a['isSkipped'] != true).toList();
      case 'skipped': return result.answeredQuestions.where((a) => a['isSkipped'] == true).toList();
      default: return result.answeredQuestions;
    }
  }

  Widget _buildFilterChip(String label, String filterKey, ThemeData theme, Color color) {
    final isSelected = _filter == filterKey;
    return GestureDetector(
      onTap: () => setState(() => _filter = filterKey),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.15) : theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? color : theme.dividerColor),
        ),
        child: Text(label, style: GoogleFonts.poppins(
          fontSize: 12, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          color: isSelected ? color : theme.colorScheme.onSurface.withOpacity(0.6),
        )),
      ),
    );
  }

  // ============================================================
  // DETAYLI SORU KARTI
  // ============================================================
  Widget _buildDetailedQuestionCard(Map<String, dynamic> data, ThemeData theme, Color primary) {
    final question = data['question'] as Question;
    final userAnswer = data['userAnswer'] as String;
    final isCorrect = data['isCorrect'] as bool;
    final isSkipped = data['isSkipped'] == true;
    final questionIndex = data['questionIndex'] as int;

    Color statusColor = isSkipped ? Colors.orangeAccent : isCorrect ? Colors.greenAccent : Colors.redAccent;
    IconData statusIcon = isSkipped ? Icons.skip_next : isCorrect ? Icons.check_circle : Icons.cancel;
    String statusText = isSkipped ? 'Atlandı' : isCorrect ? 'Doğru' : 'Yanlış';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Container(
          width: 36, height: 36,
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: Icon(statusIcon, color: statusColor, size: 20)),
        ),
        title: Text(
          'Soru ${questionIndex + 1}',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color: theme.colorScheme.onSurface),
        ),
        subtitle: Text(
          statusText,
          style: GoogleFonts.poppins(fontSize: 12, color: statusColor),
        ),
        children: [
          // Soru metni
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Zorluk + tip
                Row(
                  children: [
                    _buildMiniTag(question.difficulty == 'easy' ? 'Kolay' : question.difficulty == 'medium' ? 'Orta' : 'Zor',
                        question.difficulty == 'easy' ? Colors.greenAccent : question.difficulty == 'medium' ? Colors.orangeAccent : Colors.redAccent),
                    const SizedBox(width: 6),
                    _buildMiniTag(question.type == 'test' ? 'Test' : 'Açık Uçlu', primary),
                  ],
                ),
                const SizedBox(height: 10),

                // Soru
                Text(question.questionText, style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface, height: 1.4,
                )),

                // Latince terim
                if (question.latinTerm != null) ...[
                  const SizedBox(height: 6),
                  Text('🔬 Latince: ${question.latinTerm}',
                      style: GoogleFonts.poppins(fontSize: 12, fontStyle: FontStyle.italic, color: theme.colorScheme.secondary)),
                ],

                const SizedBox(height: 14),

                // Şıklar (test ise)
                if (question.type == 'test' && question.options != null)
                  ...question.options!.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final opt = entry.value;
                    final isUserChoice = opt == userAnswer;
                    final isCorrectOpt = opt == question.correctAnswer;
                    final letters = ['A', 'B', 'C', 'D'];

                    Color optColor;
                    Color optBg;

                    if (isCorrectOpt) {
                      optColor = Colors.greenAccent; optBg = Colors.greenAccent.withOpacity(0.08);
                    } else if (isUserChoice && !isCorrectOpt) {
                      optColor = Colors.redAccent; optBg = Colors.redAccent.withOpacity(0.08);
                    } else {
                      optColor = theme.colorScheme.onSurface.withOpacity(0.4); optBg = Colors.transparent;
                    }

                    return Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: optBg,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: optColor.withOpacity(0.4)),
                      ),
                      child: Row(
                        children: [
                          Text('${letters[idx]}. ', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13, color: optColor)),
                          Expanded(child: Text(opt, style: GoogleFonts.poppins(fontSize: 13, color: theme.colorScheme.onSurface))),
                          if (isCorrectOpt) const Icon(Icons.check_circle, color: Colors.greenAccent, size: 16),
                          if (isUserChoice && !isCorrectOpt) const Icon(Icons.cancel, color: Colors.redAccent, size: 16),
                          if (isUserChoice && !isSkipped && !isCorrectOpt) ...[
                            const SizedBox(width: 4),
                            Text('Senin cevabın', style: GoogleFonts.poppins(fontSize: 10, color: Colors.redAccent)),
                          ],
                        ],
                      ),
                    );
                  }),

                // Açık uçlu cevap
                if (question.type == 'open') ...[
                  if (!isSkipped) ...[
                    _buildAnswerRow('Senin cevabın:', userAnswer, isCorrect ? Colors.greenAccent : Colors.redAccent, theme),
                    const SizedBox(height: 4),
                  ],
                  _buildAnswerRow('Doğru cevap:', question.correctAnswer, Colors.greenAccent, theme),
                ],

                const SizedBox(height: 12),

                // Açıklama
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: primary.withOpacity(0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('💡 Açıklama', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: primary)),
                      const SizedBox(height: 4),
                      Text(question.explanation, style: GoogleFonts.poppins(fontSize: 13, color: theme.colorScheme.onSurface.withOpacity(0.8), height: 1.5)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
      child: Text(text, style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: color)),
    );
  }

  Widget _buildAnswerRow(String label, String value, Color color, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: theme.colorScheme.onSurface.withOpacity(0.6))),
        const SizedBox(width: 6),
        Expanded(child: Text(value, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: color))),
      ],
    );
  }

  Widget _buildStatBox(String label, String value, Color color, ThemeData theme) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: color)),
        Text(label, style: GoogleFonts.poppins(fontSize: 11, color: theme.colorScheme.onSurface.withOpacity(0.5))),
      ],
    );
  }
}
