import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../config/themes.dart';

class ThemeSelectorScreen extends StatelessWidget {
  const ThemeSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tema Seç',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gözünü yormayan bir tema seç',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ).animate().fadeIn(duration: 300.ms),

            const SizedBox(height: 24),

            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.3,
                ),
                itemCount: AppThemes.themeList.length,
                itemBuilder: (context, index) {
                  final themeItem = AppThemes.themeList[index];
                  final themeData = AppThemes.getTheme(themeItem['key']);
                  final isSelected =
                      themeProvider.currentThemeKey == themeItem['key'];

                  return GestureDetector(
                    onTap: () => themeProvider.setTheme(themeItem['key']),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: themeData.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? themeData.colorScheme.primary
                              : Colors.transparent,
                          width: 2.5,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: themeData.colorScheme.primary
                                      .withOpacity(0.3),
                                  blurRadius: 12,
                                  spreadRadius: 1,
                                ),
                              ]
                            : [],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Renk önizleme
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildColorDot(themeData.colorScheme.primary),
                              const SizedBox(width: 6),
                              _buildColorDot(themeData.colorScheme.secondary),
                              const SizedBox(width: 6),
                              _buildColorDot(themeData.colorScheme.surface),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Icon(
                            themeItem['icon'],
                            color: themeData.colorScheme.primary,
                            size: 24,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            themeItem['name'],
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: themeData.colorScheme.onSurface,
                            ),
                          ),
                          if (isSelected)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Icon(
                                Icons.check_circle,
                                size: 16,
                                color: themeData.colorScheme.primary,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(
                      delay: Duration(milliseconds: index * 80),
                      duration: 400.ms);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorDot(Color color) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
    );
  }
}
