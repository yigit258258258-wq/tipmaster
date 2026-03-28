import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../data/question_bank.dart';
import 'quiz_screen.dart';

class QuizSetupScreen extends StatefulWidget {
  const QuizSetupScreen({super.key});

  @override
  State<QuizSetupScreen> createState() => _QuizSetupScreenState();
}

class _QuizSetupScreenState extends State<QuizSetupScreen> {
  String _selectedCategory = 'all';
  String _selectedSubcategory = 'all';
  int _questionCount = 10;
  int _timeLimit = 10;
  String _questionType = 'mixed';
  String _difficulty = 'mixed';

  final List<Map<String, dynamic>> _categories = [
    {'key': 'all', 'name': 'Tümü', 'icon': Icons.all_inclusive},
    {'key': 'anatomy', 'name': 'Anatomi', 'icon': Icons.accessibility_new},
    {'key': 'physiology', 'name': 'Fizyoloji', 'icon': Icons.favorite},
    {'key': 'pharmacology', 'name': 'Farmakoloji', 'icon': Icons.medication},
    {'key': 'pathology', 'name': 'Patoloji', 'icon': Icons.coronavirus},
  ];

  final Map<String, List<Map<String, dynamic>>> _subcategories = {
    'anatomy': [
      {'key': 'all', 'name': 'Tümü', 'icon': Icons.all_inclusive},
      {'key': 'skeletal_system', 'name': 'İskelet Sistemi', 'icon': Icons.directions_walk},
      {'key': 'muscular_system', 'name': 'Kas Sistemi', 'icon': Icons.fitness_center},
      {'key': 'organs', 'name': 'Organlar', 'icon': Icons.health_and_safety},
      {'key': 'nervous_system', 'name': 'Sinir Sistemi', 'icon': Icons.psychology},
    ],
    'physiology': [
      {'key': 'all', 'name': 'Tümü', 'icon': Icons.all_inclusive},
      {'key': 'cardiovascular', 'name': 'Kardiyovasküler', 'icon': Icons.favorite},
      {'key': 'respiratory', 'name': 'Solunum', 'icon': Icons.air},
      {'key': 'nervous', 'name': 'Sinir Sistemi', 'icon': Icons.psychology},
      {'key': 'endocrine', 'name': 'Endokrin', 'icon': Icons.science},
      {'key': 'digestive', 'name': 'Sindirim', 'icon': Icons.restaurant},
      {'key': 'renal', 'name': 'Böbrek', 'icon': Icons.water_drop},
      {'key': 'muscular', 'name': 'Kas Fizyolojisi', 'icon': Icons.fitness_center},
    ],
    'pharmacology': [
      {'key': 'all', 'name': 'Tümü', 'icon': Icons.all_inclusive},
      {'key': 'analgesics', 'name': 'Ağrı Kesiciler', 'icon': Icons.healing},
      {'key': 'antibiotics', 'name': 'Antibiyotikler', 'icon': Icons.medication},
      {'key': 'cardiovascular', 'name': 'Kardiyovasküler', 'icon': Icons.favorite},
      {'key': 'general', 'name': 'Genel', 'icon': Icons.medical_services},
    ],
    'pathology': [
      {'key': 'all', 'name': 'Tümü', 'icon': Icons.all_inclusive},
      {'key': 'general', 'name': 'Genel Patoloji', 'icon': Icons.coronavirus},
    ],
  };

  final List<Map<String, dynamic>> _questionTypes = [
    {'key': 'mixed', 'name': 'Karışık', 'icon': Icons.shuffle},
    {'key': 'test', 'name': 'Çoktan Seçmeli', 'icon': Icons.checklist},
    {'key': 'open', 'name': 'Açık Uçlu', 'icon': Icons.edit_note},
  ];

  final List<Map<String, dynamic>> _difficulties = [
    {'key': 'mixed', 'name': 'Karışık', 'color': Colors.blueAccent},
    {'key': 'easy', 'name': 'Kolay', 'color': Colors.greenAccent},
    {'key': 'medium', 'name': 'Orta', 'color': Colors.orangeAccent},
    {'key': 'hard', 'name': 'Zor', 'color': Colors.redAccent},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    int availableQuestions = QuestionBank.getQuestions(
      category: _selectedCategory,
      subcategory: _selectedSubcategory,
      type: _questionType,
      difficulty: _difficulty,
    ).length;

    bool hasSubcategories = _selectedCategory != 'all' && _subcategories.containsKey(_selectedCategory);

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Ayarları', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kategori
            _buildSectionTitle('Kategori', Icons.category_outlined).animate().fadeIn(duration: 400.ms),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: _categories.map((cat) {
                return _buildChip(
                  label: cat['name'], icon: cat['icon'],
                  isSelected: _selectedCategory == cat['key'],
                  onTap: () => setState(() {
                    _selectedCategory = cat['key'];
                    _selectedSubcategory = 'all';
                  }),
                );
              }).toList(),
            ).animate().fadeIn(delay: 100.ms, duration: 400.ms),

            // Alt Kategori (varsa)
            if (hasSubcategories) ...[
              const SizedBox(height: 20),
              _buildSectionTitle('Alt Kategori', Icons.subdirectory_arrow_right).animate().fadeIn(delay: 150.ms, duration: 400.ms),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8, runSpacing: 8,
                children: _subcategories[_selectedCategory]!.map((sub) {
                  return _buildChip(
                    label: sub['name'], icon: sub['icon'],
                    isSelected: _selectedSubcategory == sub['key'],
                    onTap: () => setState(() => _selectedSubcategory = sub['key']),
                  );
                }).toList(),
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
            ],

            const SizedBox(height: 28),

            // Soru Tipi
            _buildSectionTitle('Soru Tipi', Icons.quiz_outlined).animate().fadeIn(delay: 250.ms, duration: 400.ms),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: _questionTypes.map((qt) {
                return _buildChip(
                  label: qt['name'], icon: qt['icon'],
                  isSelected: _questionType == qt['key'],
                  onTap: () => setState(() => _questionType = qt['key']),
                );
              }).toList(),
            ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

            const SizedBox(height: 28),

            // Zorluk
            _buildSectionTitle('Zorluk Seviyesi', Icons.speed).animate().fadeIn(delay: 350.ms, duration: 400.ms),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: _difficulties.map((d) {
                return _buildChip(
                  label: d['name'],
                  isSelected: _difficulty == d['key'],
                  onTap: () => setState(() => _difficulty = d['key']),
                  activeColor: d['color'],
                );
              }).toList(),
            ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

            const SizedBox(height: 28),

            // Soru Sayısı
            _buildSectionTitle('Soru Sayısı: $_questionCount', Icons.format_list_numbered).animate().fadeIn(delay: 450.ms, duration: 400.ms),
            const SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                activeTrackColor: primary, inactiveTrackColor: primary.withOpacity(0.2),
                thumbColor: primary, overlayColor: primary.withOpacity(0.1),
                valueIndicatorColor: primary, valueIndicatorTextStyle: GoogleFonts.poppins(color: Colors.white),
              ),
              child: Slider(
                value: _questionCount.toDouble(), min: 5, max: 50, divisions: 9,
                label: '$_questionCount soru',
                onChanged: (value) => setState(() => _questionCount = value.toInt()),
              ),
            ).animate().fadeIn(delay: 500.ms, duration: 400.ms),

            const SizedBox(height: 20),

            // Süre
            _buildSectionTitle('Süre: $_timeLimit dakika', Icons.timer_outlined).animate().fadeIn(delay: 550.ms, duration: 400.ms),
            const SizedBox(height: 8),
            SliderTheme(
              data: SliderThemeData(
                activeTrackColor: theme.colorScheme.secondary, inactiveTrackColor: theme.colorScheme.secondary.withOpacity(0.2),
                thumbColor: theme.colorScheme.secondary, overlayColor: theme.colorScheme.secondary.withOpacity(0.1),
                valueIndicatorColor: theme.colorScheme.secondary, valueIndicatorTextStyle: GoogleFonts.poppins(color: Colors.white),
              ),
              child: Slider(
                value: _timeLimit.toDouble(), min: 1, max: 60, divisions: 59,
                label: '$_timeLimit dk',
                onChanged: (value) => setState(() => _timeLimit = value.toInt()),
              ),
            ).animate().fadeIn(delay: 600.ms, duration: 400.ms),

            const SizedBox(height: 12),

            // Bilgi
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.cardColor, borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primary.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 18, color: primary.withOpacity(0.7)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Seçime uygun $availableQuestions soru mevcut (toplam ${QuestionBank.getTotalQuestionCount()} soru)',
                      style: GoogleFonts.poppins(fontSize: 12, color: theme.colorScheme.onSurface.withOpacity(0.6)),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 650.ms, duration: 400.ms),

            const SizedBox(height: 32),

            // Başlat
            SizedBox(
              width: double.infinity, height: 56,
              child: ElevatedButton(
                onPressed: availableQuestions > 0 ? () {
                  final quizProvider = Provider.of<QuizProvider>(context, listen: false);
                  quizProvider.setCategory(_selectedCategory);
                  quizProvider.setSubcategory(_selectedSubcategory);
                  quizProvider.setQuestionCount(_questionCount > availableQuestions ? availableQuestions : _questionCount);
                  quizProvider.setTimeLimit(_timeLimit);
                  quizProvider.setQuestionType(_questionType);
                  quizProvider.setDifficulty(_difficulty);
                  quizProvider.startQuiz();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const QuizScreen()));
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary, disabledBackgroundColor: primary.withOpacity(0.3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.play_arrow_rounded, size: 28),
                    const SizedBox(width: 8),
                    Text('Quiz\'i Başlat', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: 700.ms, duration: 500.ms).slideY(begin: 0.1),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Text(title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: theme.colorScheme.onSurface)),
      ],
    );
  }

  Widget _buildChip({required String label, IconData? icon, required bool isSelected, required VoidCallback onTap, Color? activeColor}) {
    final theme = Theme.of(context);
    final color = activeColor ?? theme.colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.15) : theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? color : theme.dividerColor, width: isSelected ? 1.5 : 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: isSelected ? color : theme.colorScheme.onSurface.withOpacity(0.5)),
              const SizedBox(width: 6),
            ],
            Text(label, style: GoogleFonts.poppins(
              fontSize: 13, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? color : theme.colorScheme.onSurface.withOpacity(0.7),
            )),
          ],
        ),
      ),
    );
  }
}
