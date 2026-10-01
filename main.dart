import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rohan Kale | Senior Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFF00E5FF),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      ),
      home: const MainPortfolioPage(),
    );
  }
}

class MainPortfolioPage extends StatelessWidget {
  const MainPortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            HeroSection(isMobile: isMobile),
            MetricsBentoGrid(isMobile: isMobile),
            ExperienceTimeline(isMobile: isMobile),
            ProjectsGallery(isMobile: isMobile),
            ContactFooter(isMobile: isMobile),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// HERO SECTION
// -----------------------------------------------------------------------------
class HeroSection extends StatelessWidget {
  final bool isMobile;
  const HeroSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF00E5FF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.3)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(radius: 4, backgroundColor: Color(0xFF00E5FF)),
                SizedBox(width: 8),
                Text(
                  "AVAILABLE FOR LEADERSHIP & ARCHITECTURE ROLES",
                  style: TextStyle(
                    color: Color(0xFF00E5FF),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Rohan Suresh Kale",
            style: TextStyle(
              fontSize: isMobile ? 36 : 64,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.0,
              height: 1.1,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF00E5FF), Color(0xFF3B82F6)],
            ).createShader(bounds),
            child: Text(
              "Senior Flutter Developer & Technical Lead",
              style: TextStyle(
                fontSize: isMobile ? 20 : 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: const Text(
              "Architecting high-performance, enterprise-grade cross-platform applications "
              "for global leaders like SBI YONO 2.0 and TATA NEU. Specialized in Clean Mobile "
              "Architecture, BLoC, and Flutter Web strategy for 10M+ users.",
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF94A3B8),
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 36),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              ElevatedButton.icon(
                onPressed: () => _launchURL("mailto:rohankale7058@gmail.com"),
                icon: const Icon(Icons.email_outlined, color: Colors.black),
                label: const Text(
                  "Get In Touch",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E5FF),
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () => _launchURL("https://linkedin.com/in/rohan-kale-378263160"),
                icon: const Icon(Icons.link, color: Colors.white),
                label: const Text("LinkedIn Profile", style: TextStyle(color: Colors.white)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0x1AFFFFFF)),
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// BENTO GRID METRICS
// -----------------------------------------------------------------------------
class MetricsBentoGrid extends StatelessWidget {
  final bool isMobile;
  const MetricsBentoGrid({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Impact & Performance",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildMetricCard("10M+", "Concurrent Users", "Core retail banking for SBI YONO 2.0", const Color(0xFF00E5FF), isMobile),
              _buildMetricCard("99.9%", "Crash-Free Rate", "Sustained production stability", Colors.greenAccent, isMobile),
              _buildMetricCard("85%", "Code Reusability", "Modular design & Flutter Web", Colors.orangeAccent, isMobile),
              _buildMetricCard("30%", "Latency Reduction", "Optimized async data sync patterns", Colors.purpleAccent, isMobile),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String val, String title, String desc, Color color, bool isMobile) {
    return SizedBox(
      width: isMobile ? double.infinity : 300,
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(val, style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 4),
            Text(desc, style: const TextStyle(fontSize: 14, color: Color(0xFF94A3B8))),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// EXPERIENCE TIMELINE
// -----------------------------------------------------------------------------
class ExperienceTimeline extends StatelessWidget {
  final bool isMobile;
  const ExperienceTimeline({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Professional Experience",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 24),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Senior Flutter Developer & Tech Lead", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF00E5FF))),
                    Text("Jan 2023 - Present", style: TextStyle(color: Color(0xFF94A3B8))),
                  ],
                ),
                const SizedBox(height: 4),
                const Text("Tata Consultancy Services Ltd., Pune, India", style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 12),
                const Text("• Led and mentored an engineering team of 4 Flutter developers.", style: TextStyle(color: Color(0xFF94A3B8))),
                const Text("• Architected critical Change Requests for SBI YONO 2.0 with 0% post-deployment regression.", style: TextStyle(color: Color(0xFF94A3B8))),
                const Text("• Sustained 99.9% crash-free session rate across high-volume production builds.", style: TextStyle(color: Color(0xFF94A3B8))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Flutter Developer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF00E5FF))),
                    Text("Nov 2021 - Dec 2022", style: TextStyle(color: Color(0xFF94A3B8))),
                  ],
                ),
                const SizedBox(height: 4),
                const Text("Tata Consultancy Services Ltd., Pune, India", style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 12),
                const Text("• Commanded functional migration of TATA NEU transaction modules to Flutter Web.", style: TextStyle(color: Color(0xFF94A3B8))),
                const Text("• Achieved 85% cross-platform reusability through modular widget architecture.", style: TextStyle(color: Color(0xFF94A3B8))),
                const Text("• Overhauled RESTful APIs to reduce runtime battery consumption by 15%.", style: TextStyle(color: Color(0xFF94A3B8))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// PROJECTS GALLERY
// -----------------------------------------------------------------------------
class ProjectsGallery extends StatelessWidget {
  final bool isMobile;
  const ProjectsGallery({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Technical Projects",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SizedBox(
                width: isMobile ? double.infinity : 350,
                child: const GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hospital Survey App", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 8),
                      Text("EHR management framework boosting data processing speed by 40%.", style: TextStyle(color: Color(0xFF94A3B8))),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: isMobile ? double.infinity : 350,
                child: const GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Dairy Management App", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(height: 8),
                      Text("Milk logistics automation tracking system with background microservices.", style: TextStyle(color: Color(0xFF94A3B8))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// CONTACT FOOTER
// -----------------------------------------------------------------------------
class ContactFooter extends StatelessWidget {
  final bool isMobile;
  const ContactFooter({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 60),
      color: const Color(0xFF0B1120),
      width: double.infinity,
      child: Column(
        children: [
          const Text("Designed & Built by Rohan Suresh Kale", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text("Pune, Maharashtra, India | +91-7058426247", style: TextStyle(color: Color(0xFF94A3B8))),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SHARED REUSABLE GLASS CARD WIDGET
// -----------------------------------------------------------------------------
class GlassCard extends StatelessWidget {
  final Widget child;
  const GlassCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B).withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0x1AFFFFFF)),
          ),
          child: child,
        ),
      ),
    );
  }
}

void _launchURL(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  }
}

