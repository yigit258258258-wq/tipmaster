import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../providers/quiz_provider.dart';
import '../models/question.dart';

class AddQuestionScreen extends StatefulWidget {
  const AddQuestionScreen({super.key});

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final _correctAnswerController = TextEditingController();
  final _explanationController = TextEditingController();
  final _latinTermController = TextEditingController();
  final _option1Controller = TextEditingController();
  final _option2Controller = TextEditingController();
  final _option3Controller = TextEditingController();
  final _option4Controller = TextEditingController();

  String _selectedCategory = 'anatomy';
  String _selectedType = 'test';
  String _selectedDifficulty = 'medium';

  @override
  void dispose() {
    _questionController.dispose();
    _correctAnswerController.dispose();
    _explanationController.dispose();
    _latinTermController.dispose();
    _option1Controller.dispose();
    _option2Controller.dispose();
    _option3Controller.dispose();
    _option4Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text('Soru Ekle',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Consumer<QuizProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mevcut kullanıcı soruları bilgisi
                  if (provider.userQuestions.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: primary.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, size: 18, color: primary),
                          const SizedBox(width: 8),
                          Text(
                            '${provider.userQuestions.length} kendi sorun mevcut',
                            style: GoogleFonts.poppins(
                                fontSize: 13, color: primary),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 300.ms),

                  // Kategori
                  _buildLabel('Kategori'),
                  const SizedBox(height: 8),
                  _buildDropdown<String>(
                    value: _selectedCategory,
                    items: const [
                      DropdownMenuItem(value: 'anatomy', child: Text('Anatomi')),
                      DropdownMenuItem(value: 'physiology', child: Text('Fizyoloji')),
                      DropdownMenuItem(value: 'pharmacology', child: Text('Farmakoloji')),
                      DropdownMenuItem(value: 'pathology', child: Text('Patoloji')),
                    ],
                    onChanged: (val) => setState(() => _selectedCategory = val!),
                    theme: theme,
                  ),

                  const SizedBox(height: 20),

                  // Soru tipi
                  _buildLabel('Soru Tipi'),
                  const SizedBox(height: 8),
                  _buildDropdown<String>(
                    value: _selectedType,
                    items: const [
                      DropdownMenuItem(value: 'test', child: Text('Çoktan Seçmeli')),
                      DropdownMenuItem(value: 'open', child: Text('Açık Uçlu')),
                    ],
                    onChanged: (val) => setState(() => _selectedType = val!),
                    theme: theme,
                  ),

                  const SizedBox(height: 20),

                  // Zorluk
                  _buildLabel('Zorluk'),
                  const SizedBox(height: 8),
                  _buildDropdown<String>(
                    value: _selectedDifficulty,
                    items: const [
                      DropdownMenuItem(value: 'easy', child: Text('Kolay')),
                      DropdownMenuItem(value: 'medium', child: Text('Orta')),
                      DropdownMenuItem(value: 'hard', child: Text('Zor')),
                    ],
                    onChanged: (val) => setState(() => _selectedDifficulty = val!),
                    theme: theme,
                  ),

                  const SizedBox(height: 20),

                  // Soru metni
                  _buildLabel('Soru'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _questionController,
                    hint: 'Soru metnini yazın...',
                    maxLines: 3,
                    validator: (val) => val!.isEmpty ? 'Soru boş olamaz' : null,
                    theme: theme,
                  ),

                  const SizedBox(height: 20),

                  // Şıklar (sadece test ise)
                  if (_selectedType == 'test') ...[
                    _buildLabel('Şıklar'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _option1Controller,
                      hint: 'A şıkkı',
                      theme: theme,
                      validator: (val) =>
                          _selectedType == 'test' && val!.isEmpty
                              ? 'Boş olamaz'
                              : null,
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _option2Controller,
                      hint: 'B şıkkı',
                      theme: theme,
                      validator: (val) =>
                          _selectedType == 'test' && val!.isEmpty
                              ? 'Boş olamaz'
                              : null,
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _option3Controller,
                      hint: 'C şıkkı',
                      theme: theme,
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _option4Controller,
                      hint: 'D şıkkı',
                      theme: theme,
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Doğru cevap
                  _buildLabel('Doğru Cevap'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _correctAnswerController,
                    hint: _selectedType == 'test'
                        ? 'Şıklardan birini aynen yazın'
                        : 'Doğru cevabı yazın',
                    validator: (val) =>
                        val!.isEmpty ? 'Doğru cevap boş olamaz' : null,
                    theme: theme,
                  ),

                  const SizedBox(height: 20),

                  // Latince terim (opsiyonel)
                  _buildLabel('Latince Terim (opsiyonel)'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _latinTermController,
                    hint: 'Örn: Os femoris',
                    theme: theme,
                  ),

                  const SizedBox(height: 20),

                  // Açıklama
                  _buildLabel('Açıklama'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _explanationController,
                    hint: 'Cevabın açıklamasını yazın...',
                    maxLines: 4,
                    validator: (val) =>
                        val!.isEmpty ? 'Açıklama boş olamaz' : null,
                    theme: theme,
                  ),

                  const SizedBox(height: 32),

                  // Kaydet butonu
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () => _saveQuestion(provider),
                      icon: const Icon(Icons.save),
                      label: Text(
                        'Soruyu Kaydet',
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Kullanıcı soruları listesi
                  if (provider.userQuestions.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Eklediğin Sorular',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...provider.userQuestions.map((q) => Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: theme.dividerColor),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  q.questionText,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                onPressed: () => provider.removeUserQuestion(q.id),
                                icon: const Icon(Icons.delete_outline,
                                    color: Colors.redAccent, size: 20),
                              ),
                            ],
                          ),
                        )),
                  ],

                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    String? Function(String?)? validator,
    required ThemeData theme,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      style: GoogleFonts.poppins(color: theme.colorScheme.onSurface),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
            color: theme.colorScheme.onSurface.withOpacity(0.3)),
        filled: true,
        fillColor: theme.cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required T value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          isExpanded: true,
          dropdownColor: theme.cardColor,
          style: GoogleFonts.poppins(color: theme.colorScheme.onSurface),
        ),
      ),
    );
  }

  void _saveQuestion(QuizProvider provider) {
    if (!_formKey.currentState!.validate()) return;

    List<String>? options;
    if (_selectedType == 'test') {
      options = [
        _option1Controller.text.trim(),
        _option2Controller.text.trim(),
        if (_option3Controller.text.trim().isNotEmpty)
          _option3Controller.text.trim(),
        if (_option4Controller.text.trim().isNotEmpty)
          _option4Controller.text.trim(),
      ];
    }

    final question = Question(
      id: 'user_${const Uuid().v4()}',
      category: _selectedCategory,
      subcategory: 'custom',
      type: _selectedType,
      difficulty: _selectedDifficulty,
      questionText: _questionController.text.trim(),
      options: options,
      correctAnswer: _correctAnswerController.text.trim(),
      latinTerm: _latinTermController.text.trim().isNotEmpty
          ? _latinTermController.text.trim()
          : null,
      explanation: _explanationController.text.trim(),
    );

    provider.addUserQuestion(question);

    // Temizle
    _questionController.clear();
    _correctAnswerController.clear();
    _explanationController.clear();
    _latinTermController.clear();
    _option1Controller.clear();
    _option2Controller.clear();
    _option3Controller.clear();
    _option4Controller.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Soru başarıyla eklendi! ✅',
            style: GoogleFonts.poppins()),
        backgroundColor: Colors.greenAccent.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
