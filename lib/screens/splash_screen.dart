import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 4000), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.scaffoldBackgroundColor,
              theme.colorScheme.surface,
              theme.scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // DNA + Kitap İkonu
              _buildLogo(primary, secondary)
                  .animate()
                  .fadeIn(duration: 800.ms)
                  .scale(begin: const Offset(0.5, 0.5), duration: 800.ms, curve: Curves.easeOutBack),

              const SizedBox(height: 32),

              // TıpMaster Yazısı
              Text(
                'TıpMaster',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                  color: primary,
                  letterSpacing: 2,
                ),
              )
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 800.ms)
                  .slideY(begin: 0.3, duration: 800.ms, curve: Curves.easeOut),

              const SizedBox(height: 12),

              // Hoşgeldiniz
              Text(
                'Hoşgeldiniz',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                  color: theme.colorScheme.onSurface.withOpacity(0.8),
                  letterSpacing: 6,
                ),
              )
                  .animate()
                  .fadeIn(delay: 800.ms, duration: 800.ms)
                  .slideY(begin: 0.3, duration: 800.ms),

              const SizedBox(height: 48),

              // Motto
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: primary.withOpacity(0.5), width: 2),
                    ),
                  ),
                  child: Text(
                    '"Bilgi iyileştirir, öğrenmek güçlendirir."',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                      fontStyle: FontStyle.italic,
                      height: 1.6,
                    ),
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: 1200.ms, duration: 1000.ms),

              const Spacer(flex: 2),

              // Yükleniyor
              SizedBox(
                width: 160,
                child: LinearProgressIndicator(
                  backgroundColor: theme.colorScheme.surface,
                  valueColor: AlwaysStoppedAnimation<Color>(primary.withOpacity(0.7)),
                  minHeight: 2,
                ),
              )
                  .animate()
                  .fadeIn(delay: 1500.ms, duration: 600.ms),

              const SizedBox(height: 16),

              Text(
                'Yükleniyor...',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface.withOpacity(0.4),
                ),
              )
                  .animate()
                  .fadeIn(delay: 1500.ms, duration: 600.ms),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(Color primary, Color secondary) {
    return SizedBox(
      width: 120,
      height: 120,
      child: CustomPaint(
        painter: _DNABookLogoPainter(primary: primary, secondary: secondary),
      ),
    );
  }
}

class _DNABookLogoPainter extends CustomPainter {
  final Color primary;
  final Color secondary;

  _DNABookLogoPainter({required this.primary, required this.secondary});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Kitap
    final bookPaint = Paint()
      ..color = primary.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Sol sayfa
    final leftPage = Path()
      ..moveTo(centerX, centerY + 20)
      ..lineTo(centerX - 35, centerY + 15)
      ..lineTo(centerX - 35, centerY - 25)
      ..lineTo(centerX, centerY - 20);
    canvas.drawPath(leftPage, bookPaint);

    // Sağ sayfa
    final rightPage = Path()
      ..moveTo(centerX, centerY + 20)
      ..lineTo(centerX + 35, centerY + 15)
      ..lineTo(centerX + 35, centerY - 25)
      ..lineTo(centerX, centerY - 20);
    canvas.drawPath(rightPage, bookPaint);

    // DNA Sarmalı
    final dnaPaint = Paint()
      ..color = primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final dnaPaint2 = Paint()
      ..color = secondary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    // DNA çizgileri
    for (int i = 0; i < 8; i++) {
      double y = centerY - 40 + (i * 12);
      double offset = 12 * (i % 2 == 0 ? 1 : -1).toDouble();

      // Sol helix
      canvas.drawLine(
        Offset(centerX - 8 + offset, y),
        Offset(centerX + 8 - offset, y),
        i % 2 == 0 ? dnaPaint : dnaPaint2,
      );

      // Noktalar
      final dotPaint = Paint()
        ..color = i % 2 == 0 ? primary : secondary
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(centerX - 8 + offset, y), 2.5, dotPaint);
      canvas.drawCircle(Offset(centerX + 8 - offset, y), 2.5, dotPaint);
    }

    // Dış çerçeve - daire
    final circlePaint = Paint()
      ..color = primary.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(Offset(centerX, centerY), 55, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
