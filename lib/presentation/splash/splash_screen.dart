import 'package:dio_api_call/res/app_colors.dart';
import 'package:dio_api_call/res/app_images.dart';
import 'package:dio_api_call/res/app_strings.dart';
import 'package:flutter/material.dart';
import '../../core/routes/route_name.dart';
import '../../core/storage/secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();

    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Wait for animation to play a bit
    await Future.delayed(const Duration(seconds: 2));
    
    final token = await SecureStorage.getToken();
    
    if (mounted) {
      if (token != null && token.isNotEmpty) {
        Navigator.pushReplacementNamed(context, RoutesName.home);
      } else {
        Navigator.pushReplacementNamed(context, RoutesName.login);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;

          final iconSize = w * 0.22;
          final logoSize = w * 0.7;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.orangeLight,
                  AppColors.orangeDark,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // logo container
                        Container(
                          width: iconSize,
                          height: iconSize,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(iconSize / 3),
                          ),
                          child: Image.asset(
                            AppImages.chefLogo,
                          ),
                        ),

                        SizedBox(height: h * 0.03),

                        // Title
                        Text(
                          AppStrings.appName,
                          style: theme.textTheme.headlineLarge?.copyWith(
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),

                        SizedBox(height: h * 0.015),

                        // Subtitle
                        Text(
                          AppStrings.appMoto,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withOpacity(0.85),
                          ),
                        ),

                        SizedBox(height: h * 0.06),

                        // Logo
                        Image.asset(
                          AppImages.appLogo,
                          width: logoSize,
                          height: logoSize,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
