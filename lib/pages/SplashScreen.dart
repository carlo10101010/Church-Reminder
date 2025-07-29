import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
import 'Dashboard.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _churchController;
  late AnimationController _textController;
  late AnimationController _fadeController;
  late AnimationController _pulseController;
  late AnimationController _particleController;
  
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _churchRotation;
  late Animation<double> _churchScale;
  late Animation<double> _textSlide;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _particleAnimation;

  final List<Particle> _particles = [];

  @override
  void initState() {
    super.initState();
    
    // Initialize particles
    _initializeParticles();
    
    // Initialize animation controllers
    _logoController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _churchController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _textController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
    );

    // Logo animations
    _logoScale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));
    
    _logoOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeIn,
    ));

    // Church icon animations
    _churchRotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _churchController,
      curve: Curves.easeInOut,
    ));
    
    _churchScale = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _churchController,
      curve: Curves.bounceOut,
    ));

    // Text animation
    _textSlide = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutCubic,
    ));

    // Fade animation for background
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    // Pulse animation
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Particle animation
    _particleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _particleController,
      curve: Curves.linear,
    ));

    // Start animations in sequence
    _startAnimations();
  }

  void _initializeParticles() {
    final random = math.Random();
    for (int i = 0; i < 20; i++) {
      _particles.add(Particle(
        x: random.nextDouble() * 400,
        y: random.nextDouble() * 800,
        size: random.nextDouble() * 3 + 1,
        speed: random.nextDouble() * 2 + 0.5,
        opacity: random.nextDouble() * 0.5 + 0.2,
      ));
    }
  }

  void _startAnimations() async {
    // Start fade animation
    _fadeController.forward();
    
    // Start particle animation
    _particleController.repeat();
    
    // Wait a bit then start logo animation
    await Future.delayed(Duration(milliseconds: 300));
    _logoController.forward();
    
    // Start church animation after logo starts
    await Future.delayed(Duration(milliseconds: 500));
    _churchController.forward();
    
    // Start pulse animation
    _pulseController.repeat(reverse: true);
    
    // Start text animation
    await Future.delayed(Duration(milliseconds: 800));
    _textController.forward();
    
    // Navigate to dashboard after animations complete
    await Future.delayed(Duration(milliseconds: 2000));
    _navigateToDashboard();
  }

  void _navigateToDashboard() {
    Navigator.of(context).pushReplacementNamed('/dashboard');
  }

  @override
  void dispose() {
    _logoController.dispose();
    _churchController.dispose();
    _textController.dispose();
    _fadeController.dispose();
    _pulseController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1565C0).withOpacity(_fadeAnimation.value),
                  Color(0xFF4F6DAD).withOpacity(_fadeAnimation.value),
                  Color(0xFF6A8EDB).withOpacity(_fadeAnimation.value),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Particle background
                AnimatedBuilder(
                  animation: _particleAnimation,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: ParticlePainter(
                        particles: _particles,
                        animation: _particleAnimation.value,
                      ),
                      size: Size.infinite,
                    );
                  },
                ),
                
                // Main content
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo and Church Icon Section
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Church Icon with Animation
                            AnimatedBuilder(
                              animation: _churchController,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: _churchRotation.value * 0.1,
                                  child: Transform.scale(
                                    scale: _churchScale.value,
                                    child: AnimatedBuilder(
                                      animation: _pulseAnimation,
                                      builder: (context, child) {
                                        return Transform.scale(
                                          scale: _pulseAnimation.value,
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              // Outer glow ring
                                              Container(
                                                width: 140,
                                                height: 140,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  gradient: RadialGradient(
                                                    colors: [
                                                      Colors.white.withOpacity(0.3),
                                                      Colors.transparent,
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              // Main church icon container
                                              Container(
                                                width: 120,
                                                height: 120,
                                                decoration: BoxDecoration(
                                                  gradient: RadialGradient(
                                                    colors: [
                                                      Colors.white.withOpacity(0.3),
                                                      Colors.white.withOpacity(0.1),
                                                    ],
                                                  ),
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.white.withOpacity(0.4),
                                                      blurRadius: 25,
                                                      spreadRadius: 8,
                                                    ),
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.1),
                                                      blurRadius: 20,
                                                      spreadRadius: 5,
                                                    ),
                                                  ],
                                                ),
                                                child: Icon(
                                                  Icons.church,
                                                  size: 80,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                            
                            SizedBox(height: 40),
                            
                            // Decorative line
                            AnimatedBuilder(
                              animation: _textController,
                              builder: (context, child) {
                                return Opacity(
                                  opacity: _textController.value,
                                  child: Container(
                                    width: 60,
                                    height: 2,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          Colors.white.withOpacity(0.6),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            
                            SizedBox(height: 30),
                            
                            // App Logo Icon
                            AnimatedBuilder(
                              animation: _logoController,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _logoScale.value,
                                  child: Opacity(
                                    opacity: _logoOpacity.value,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.white,
                                            Colors.white.withOpacity(0.9),
                                          ],
                                        ),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 15,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.notifications_active,
                                        size: 50,
                                        color: Color(0xFF1565C0),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      
                      // Text Section
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedBuilder(
                              animation: _textController,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, _textSlide.value),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Church Reminder',
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: 1.2,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black.withOpacity(0.3),
                                              offset: Offset(0, 2),
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        'Stay connected with your faith journey',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white.withOpacity(0.9),
                                          letterSpacing: 0.5,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.favorite,
                                            size: 16,
                                            color: Colors.white.withOpacity(0.7),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Faith • Family • Community',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white.withOpacity(0.7),
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Icon(
                                            Icons.favorite,
                                            size: 16,
                                            color: Colors.white.withOpacity(0.7),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            
                            SizedBox(height: 60),
                            
                            // Loading indicator with custom animation
                            AnimatedBuilder(
                              animation: _pulseAnimation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _pulseAnimation.value,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      strokeWidth: 3,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Particle {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double opacity;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double animation;

  ParticlePainter({
    required this.particles,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    for (final particle in particles) {
      final y = (particle.y + animation * particle.speed * 100) % size.height;
      canvas.drawCircle(
        Offset(particle.x, y),
        particle.size,
        paint..color = Colors.white.withOpacity(particle.opacity),
      );
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
} 