import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hakkında', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Logo ve isim
            Icon(Icons.auto_awesome, color: primary, size: 48)
                .animate().fadeIn(duration: 500.ms),
            const SizedBox(height: 12),
            Text('TıpMaster', style: GoogleFonts.playfairDisplay(
              fontSize: 32, fontWeight: FontWeight.w700, color: primary,
            )).animate().fadeIn(delay: 200.ms, duration: 500.ms),
            const SizedBox(height: 4),
            Text('v1.0.0', style: GoogleFonts.poppins(
              fontSize: 13, color: theme.colorScheme.onSurface.withOpacity(0.4),
            )).animate().fadeIn(delay: 300.ms),
            const SizedBox(height: 8),
            Text('"Bilgi iyileştirir, öğrenmek güçlendirir."',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14, fontStyle: FontStyle.italic,
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            ).animate().fadeIn(delay: 400.ms),

            const SizedBox(height: 32),

            // Uygulama hakkında
            _buildSection(
              theme: theme,
              icon: Icons.info_outline,
              title: 'Uygulama Hakkında',
              content: 'TıpMaster, tıp öğrencileri için hazırlanmış kapsamlı bir quiz uygulamasıdır. Anatomi, Fizyoloji, Farmakoloji ve Patoloji alanlarında yüzlerce soru içerir.',
              delay: 500,
            ),

            _buildSection(
              theme: theme,
              icon: Icons.image_outlined,
              title: 'Görsel Kaynaklar',
              content: 'Uygulamada kullanılan tıbbi görseller Wikimedia Commons\'tan alınmıştır. Bu görseller Creative Commons (CC BY-SA) ve Public Domain lisansları altında ücretsiz kullanıma açıktır.\n\nKaynak: commons.wikimedia.org',
              delay: 600,
            ),

            _buildSection(
              theme: theme,
              icon: Icons.school_outlined,
              title: 'Eğitim Amaçlı',
              content: 'Bu uygulama yalnızca eğitim amaçlıdır. Tıbbi teşhis veya tedavi amacıyla kullanılmamalıdır. Sağlık sorunları için her zaman bir sağlık profesyoneline başvurunuz.',
              delay: 700,
            ),

            _buildSection(
              theme: theme,
              icon: Icons.code,
              title: 'Geliştirici',
              content: 'Flutter ile geliştirilmiştir.\n\nSoru önerileri ve geri bildirimler için iletişime geçebilirsiniz.',
              delay: 800,
            ),

            const SizedBox(height: 32),

            // Alt bilgi
            Text(
              '© 2026 TıpMaster. Tüm hakları saklıdır.',
              style: GoogleFonts.poppins(
                fontSize: 11, color: theme.colorScheme.onSurface.withOpacity(0.3),
              ),
            ).animate().fadeIn(delay: 900.ms),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required ThemeData theme,
    required IconData icon,
    required String title,
    required String content,
    required int delay,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: theme.colorScheme.primary),
              const SizedBox(width: 10),
              Text(title, style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              )),
            ],
          ),
          const SizedBox(height: 10),
          Text(content, style: GoogleFonts.poppins(
            fontSize: 13, color: theme.colorScheme.onSurface.withOpacity(0.7),
            height: 1.6,
          )),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay), duration: 500.ms)
        .slideY(begin: 0.05);
  }
}
