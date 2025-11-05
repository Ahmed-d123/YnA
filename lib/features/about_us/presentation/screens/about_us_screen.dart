import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ya_tech_flutter/core/utils/size_config.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../testimonials/domain/entities/testimonial.dart';
import '../../../testimonials/presentation/provider/testimonial_provider.dart';
import '../../../shell/app_drawer.dart';


class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

// --- 1. تحويلها إلى StatefulWidget ---
class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void initState() {
    super.initState();
    // --- 2. جلب البيانات عند فتح الشاشة ---
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // نستخدم listen: false لجلب البيانات مرة واحدة
      Provider.of<TestimonialProvider>(context, listen: false)
          .fetchTestimonials();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final double size = SizeConfig.defultSize!;

    final s = S.of(context);
    final textTheme = Theme
        .of(context)
        .textTheme;
    final colorScheme = Theme
        .of(context)
        .colorScheme;

    // --- 3. مراقبة الـ Provider ---
    final testimonialProvider = context.watch<TestimonialProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(s.navAbout),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Hero Section ---
            Container(
              height: size * 20,
              // 480
              width: double.infinity,
              padding: EdgeInsets.all(size),
              // 24
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuA73PRZUtOR2eHcy-xgR78UIlzNRHn3Y4Xnr3z-lhOsHNlqlv8NTf-LuxZwwMAlKuPxPkCkmP3_9PcbUSUkQ6I5hGvUncDoAmBmiLmndW_c3VNVKQLCupLL7sNAYmB_7xLOK4qMq1VsL0DiLb-4YCFldHBBuoC3Dsv3cdyW0kWgrC3DMALE2p6awwEHHfCKSuHFZf1JtMjrMSAtR6WxDqXihxcTwD9zULFLauNnHc_uXuDfW8-Uxc5aLUCMuhazbXVA8Cc_RjhUuu0"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black38,
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    s.aboutHeroTitle,
                    textAlign: TextAlign.center,
                    style: textTheme.displayMedium?.copyWith(
                      color: AppColors.textWhite,
                      fontSize: size * 2, // 48
                    ),
                  ),
                  SizedBox(height: size * 0.4), // 10
                  Text(
                    s.aboutHeroSubtitle,
                    textAlign: TextAlign.center,
                    style: textTheme.titleMedium
                        ?.copyWith(
                        color: AppColors.textLight, fontSize: size * 0.75 // 18
                    ),
                  ),
                ],
              ),
            ),

            // --- Mission Section ---
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size * 2, horizontal: size * 0.8), // 48, 20
              child: Column(
                children: [
                  Text(
                    s.aboutMissionTitle,
                    style: textTheme.displaySmall?.copyWith(
                        fontSize: size * 1.5), // 36
                  ),
                  SizedBox(height: size * 0.66), // 16
                  Text(
                    s.aboutMissionDescription,
                    textAlign: TextAlign.center,
                    style: textTheme.titleMedium
                        ?.copyWith(fontSize: size * 0.75, height: 1.5), // 18
                  ),
                ],
              ),
            ),

            // --- Values Section ---
            Container(
              color: colorScheme.surface,
              padding: EdgeInsets.symmetric(
                  vertical: size * 2.5, horizontal: size), // 60, 24
              child: Column(
                children: [
                  Text(
                    s.aboutValuesTitle,
                    style: textTheme.displaySmall?.copyWith(
                        fontSize: size * 1.5), // 36
                  ),
                  SizedBox(height: size * 0.66), // 16
                  Text(
                    s.aboutValuesSubtitle,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyLarge
                        ?.copyWith(fontSize: size * 0.66, height: 1.5), // 16
                  ),
                  SizedBox(height: size * 2), // 48

                  Wrap(
                    children: [
                      _buildValueCard(context, Icons.lightbulb_outline,
                          s.valueInnovation, "Pushing boundaries.", size),
                      SizedBox(height: size), // 24
                      _buildValueCard(context, Icons.shield_outlined,
                          s.valueReliability, "Building robust solutions.", size),
                      SizedBox(height: size), // 24
                      _buildValueCard(context, Icons.palette_outlined,
                          s.valueCreativity, "Designing unique experiences.", size),
                    ],
                  )

                ],
              ),
            ),

            // --- Team Section ---
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size * 2.5, horizontal: size), // 60, 24
              child: Column(
                children: [
                  Text(
                    s.aboutTeamTitle,
                    style: textTheme.displaySmall?.copyWith(
                        fontSize: size * 1.5), // 36
                  ),
                  SizedBox(height: size * 2), // 48
                  Wrap(
                    spacing: size, // 24
                    runSpacing: size, // 24
                    alignment: WrapAlignment.center,
                    // --- هذا هو التعديل ---
                    children: [
                      TeamMemberCard(
                        imageUrl: "assets/images/youssef_hatem.jpg",
                        name: "Youssef Hatem",
                        title: "CEO & CoFounder",
                        description: "Youssef drives the company's vision, strategy, and growth.", size: size,
                      ),
                      TeamMemberCard(
                        imageUrl: "assets/images/ahmed_allam.jpg",
                        name: "Ahmed Alam",
                        title: "CTO & CoFounder",
                        description: "Ahmed leads the engineering and innovation teams, shaping the company's technology vision and driving product excellence.", size: size,
                      ),
                    ],
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  // --- 5. دالة جديدة لعرض محتوى المقولات ---
  Widget _buildTestimonialContent(BuildContext context,
      TestimonialProvider provider, double size) {
    if (provider.isLoading) {
      return const CircularProgressIndicator();
    }

    if (provider.errorMessage != null) {
      return Text("Error: ${provider.errorMessage}");
    }

    // --- هذا هو التعديل ---
    if (provider.items.isEmpty) {
      return const Text("No testimonials yet.");
    }

    return Column(
      children: provider.items // <-- تم التعديل
          .map((item) => _buildTestimonialCard(context, item, size))
          .toList(),
    );
    // --- نهاية التعديل ---
  }

  Widget _buildValueCard(BuildContext context, IconData icon, String title,
      String desc, double size) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return Card(
      elevation: 0,
      color: Theme
          .of(context)
          .colorScheme
          .background,
      child: Padding(
        padding: EdgeInsets.all(size), // 24
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: size * 2),
            // 48
            SizedBox(height: size * 0.66),
            // 16
            Text(title,
                style: textTheme.headlineSmall?.copyWith(fontSize: size * 0.9)),
            // 22
            SizedBox(height: size * 0.33),
            // 8
            Text(
              desc,
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.copyWith(fontSize: size * 0.66), // 16
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTestimonialCard(
      BuildContext context, Testimonial testimonial, double size) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: size * 0.66), // 16
      color: Theme.of(context).colorScheme.background,
      child: Padding(
        padding: EdgeInsets.all(size * 0.8), // 20
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              testimonial.quote,
              style: textTheme.titleMedium
                  ?.copyWith(fontStyle: FontStyle.italic, fontSize: size * 0.75), // 18
            ),
            SizedBox(height: size * 0.66), // 16
            Text(
              "- ${testimonial.name}",
              style: textTheme.titleMedium
                  ?.copyWith(color: AppColors.primary, fontSize: size * 0.66), // 16
            ),
          ],
        ),
      ),
    );
  }
}
  class TeamMemberCard extends StatelessWidget {
  const TeamMemberCard({
  super.key,
  required this.name,
  required this.title,
  required this.description,
  required this.imageUrl,
  required this.size,
  });

  final String name;
  final String title;
  final String description;
  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;
  final colorScheme = Theme.of(context).colorScheme;

  // --- 1. التعديل: تمت إضافة SizedBox لتحديد العرض ---
  return SizedBox(
  width: size * 21, // حوالي 500px كعرض أقصى للبطاقة
  child: Card(
  margin: EdgeInsets.only(bottom: size), // 24
  clipBehavior: Clip.antiAlias,
  child: Padding(
  padding: EdgeInsets.all(size * 0.66), // 16
  child: Row(
  crossAxisAlignment: CrossAxisAlignment.start, // لجعل الكلام يبدأ من الأعلى
  children: [
  // --- 1. الصورة الدائرية ---
  CircleAvatar(
  radius: size * 2.5, // 60
  backgroundImage: NetworkImage(imageUrl),
  // fallback in case of error
  onBackgroundImageError: (exception, stackTrace) {
  // You can log the error if needed
  },
  // A fallback child
  child: (imageUrl.isEmpty)
  ? Icon(Icons.person, size: size * 2.5)
      : null,
  ),

  SizedBox(width: size * 0.66), // 16

  // --- 2. البيانات النصية ---
  Expanded(
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Text(name, style: textTheme.titleLarge?.copyWith(fontSize: size * 0.9)), // 22
  SizedBox(height: size * 0.16), // 4
  Text(title,
  style: textTheme.titleMedium
      ?.copyWith(color: AppColors.primary, fontSize: size * 0.66)), // 16
  SizedBox(height: size * 0.5), // 12
  Text(description,
  style: textTheme.bodyLarge?.copyWith(
  color: colorScheme.onSurface.withOpacity(0.7),
  fontSize: size * 0.66 // 16
  )),
  ],
  ),
  ),
  ],
  ),
  ),
  ),
  );
  }
  }

