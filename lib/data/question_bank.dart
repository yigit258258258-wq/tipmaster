import '../models/question.dart';
import 'anatomy_skeletal_questions.dart';
import 'anatomy_muscular_questions.dart';
import 'anatomy_organs_questions.dart';
import 'physiology_questions.dart';
import 'pharmacology_pathology_questions.dart';
import 'visual_questions.dart';
import 'anatomy_extra_questions.dart';
import 'extra_questions.dart';
import 'anatomy_extra_questions2.dart';
import 'extra_questions2.dart';
import 'anatomy_extra_questions3.dart';
import 'extra_questions3.dart';
import 'anatomy_extra_questions4.dart';
import 'extra_questions4.dart';

class QuestionBank {
  static const Map<String, String> categoryNames = {
    'all': 'Tümü',
    'anatomy': 'Anatomi',
    'physiology': 'Fizyoloji',
    'pharmacology': 'Farmakoloji',
    'pathology': 'Patoloji',
  };

  static const Map<String, Map<String, String>> subcategoryNames = {
    'anatomy': {
      'all': 'Tümü',
      'skeletal_system': 'İskelet Sistemi',
      'muscular_system': 'Kas Sistemi',
      'organs': 'Organlar',
      'nervous_system': 'Sinir Sistemi',
    },
    'physiology': {
      'all': 'Tümü',
      'cardiovascular': 'Kardiyovasküler',
      'respiratory': 'Solunum',
      'nervous': 'Sinir Sistemi',
      'endocrine': 'Endokrin',
      'digestive': 'Sindirim',
      'renal': 'Böbrek',
      'muscular': 'Kas Fizyolojisi',
    },
    'pharmacology': {
      'all': 'Tümü',
      'analgesics': 'Ağrı Kesiciler',
      'antibiotics': 'Antibiyotikler',
      'cardiovascular': 'Kardiyovasküler İlaçlar',
      'general': 'Genel Farmakoloji',
    },
    'pathology': {
      'all': 'Tümü',
      'general': 'Genel Patoloji',
    },
  };

  static String getCategoryName(String key) {
    return categoryNames[key] ?? key;
  }

  static String getSubcategoryName(String category, String subcategory) {
    return subcategoryNames[category]?[subcategory] ?? subcategory;
  }

  static List<String> getSubcategories(String category) {
    return subcategoryNames[category]?.keys.toList() ?? ['all'];
  }

  static List<Question> _getAllQuestions() {
    return [
      ...AnatomySkeletalQuestions.questions,
      ...AnatomyMuscularQuestions.questions,
      ...AnatomyOrgansQuestions.questions,
      ...PhysiologyQuestions.questions,
      ...PharmacologyQuestions.questions,
      ...PathologyQuestions.questions,
      ...VisualQuestions.questions,
      ...AnatomyExtraQuestions.questions,
      ...PhysiologyExtraQuestions.questions,
      ...PharmacologyExtraQuestions.questions,
      ...PathologyExtraQuestions.questions,
      ...AnatomyExtraQuestions2.questions,
      ...PhysiologyExtraQuestions2.questions,
      ...PharmacologyExtraQuestions2.questions,
      ...PathologyExtraQuestions2.questions,
      ...AnatomyExtraQuestions3.questions,
      ...PhysiologyExtraQuestions3.questions,
      ...PharmacologyExtraQuestions3.questions,
      ...PathologyExtraQuestions3.questions,
      ...AnatomyExtraQuestions4.questions,
      ...ExtraQuestions4.questions,
    ];
  }

  static List<Question> getQuestions({
    String category = 'all',
    String subcategory = 'all',
    String type = 'mixed',
    String difficulty = 'mixed',
  }) {
    List<Question> allQuestions = _getAllQuestions();

    return allQuestions.where((q) {
      if (category != 'all' && q.category != category) return false;
      if (subcategory != 'all' && q.subcategory != subcategory) return false;
      if (type != 'mixed' && q.type != type) return false;
      if (difficulty != 'mixed' && q.difficulty != difficulty) return false;
      return true;
    }).toList();
  }

  static List<Question> getUniqueQuestions({
    required int count,
    String category = 'all',
    String subcategory = 'all',
    String type = 'mixed',
    String difficulty = 'mixed',
    List<String> excludeIds = const [],
  }) {
    List<Question> pool = getQuestions(
      category: category,
      subcategory: subcategory,
      type: type,
      difficulty: difficulty,
    );

    if (excludeIds.isNotEmpty) {
      pool = pool.where((q) => !excludeIds.contains(q.id)).toList();
    }

    pool.shuffle();
    return pool.take(count).toList();
  }

  static int getTotalQuestionCount() {
    return _getAllQuestions().length;
  }

  static Map<String, int> getQuestionCountByCategory() {
    final all = _getAllQuestions();
    Map<String, int> counts = {};
    for (var q in all) {
      counts[q.category] = (counts[q.category] ?? 0) + 1;
    }
    return counts;
  }
}
