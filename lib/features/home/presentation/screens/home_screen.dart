import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Required for social icons
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:url_launcher/url_launcher.dart'; // Required for social icons
import '../../../../core/assets/app_icons.dart'; // Required for social icons
import '../../../../core/constants/social_links.dart'; // Required for social icons
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/navigation/app_routes.dart'; // Import routes
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/size_config.dart'; // Import SizeConfig
import '../../../portfolio/domain/entities/portfolio.dart'; // Import Portfolio entity
import '../../../portfolio/presentation/provider/portfolio_provider.dart'; // Import Portfolio provider
import '../../../testimonials/domain/entities/testimonial.dart'; // Import Testimonial entity
import '../../../testimonials/presentation/provider/testimonial_provider.dart'; // Import Testimonial provider
import '../widgets/contact_form_section.dart';
import '../../../shell/app_drawer.dart'; // 1. إضافة القائمة الجانبية

// 2. تم حذف onServiceTapped من هنا
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _fetchData() {
    Provider.of<PortfolioProvider>(context, listen: false).fetchPortfolioItems();
    Provider.of<TestimonialProvider>(context, listen: false).fetchTestimonials();
  }

  @override
  Widget build(BuildContext context) {
    // --- 3. إصلاح الخطأ: تهيئة SizeConfig هنا ---
    SizeConfig.init(context);
    // ------------------------------------------

    final s = S.of(context);
    final textTheme = Theme.of(context).textTheme;
    final double size = SizeConfig.defultSize!;

    final portfolioProvider = context.watch<PortfolioProvider>();
    final testimonialProvider = context.watch<TestimonialProvider>();

    return Scaffold(
      // 4. إضافة AppBar والـ Drawer
      appBar: AppBar(
        title: Text(s.appTitle),
        centerTitle: false,
      ),
      drawer: const AppDrawer(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // --- Hero Section ---
          SliverToBoxAdapter(
            child: Container(
              height: size * 20, // 480
              width: double.infinity,
              padding: EdgeInsets.all(size), // 24
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                image: DecorationImage(
                  image: NetworkImage(
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuCfw09ccU1Z9DbNM8DPE6IN1npUHtZGSMFZhbNBUh3JJZ--D31bJ0HtfKE6btjdIVZlO1l0jwnAPh2WY6T7yqjZdIYDnq2_bgEjv94NBn26yBRdt98B4O1xgrg1_8ESfhH-aKyP0tvCb3tyDxktEfkDhGfEvW90FYig8gQyCNgbrQlBw__y2_hD8R_Dcz4Oicj-xElwVnHfFHy9AP_ywiBlCxDrQTGvRwrtKnVAVMSIywa0eh73po5_Km7h0Ehzd5nqsQX3ywXr1Kc"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.darken),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    s.homeHeroTitle,
                    textAlign: TextAlign.center,
                    style: textTheme.displayMedium?.copyWith(
                      color: AppColors.textWhite,
                      fontSize: size * 2, // 48
                    ),
                  ),
                  SizedBox(height: size), // 24
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: size, // 24
                        vertical: size * 0.75, // 18
                      ),
                      textStyle: TextStyle(fontSize: size * 0.75), // 18
                    ),
                    onPressed: () {
                      _launchSocialURL(SocialLinks.whatsapp);
                    },
                    child: Text(s.homeHeroButton),
                  ),
                ],
              ),
            ),
          ),

          // --- Services Overview Section ---
          SliverToBoxAdapter(
            child: _buildSectionHeader(context, s.homeSectionServices, size),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: size * 6.25, // 150
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: size * 0.66), // 16
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: SizeConfig.screenWidth! - (size * 0.66 * 2),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // --- 5. تعديل الـ Service Cards ---
                        _HoverableServiceCard(
                          icon: Symbols.web,
                          title: s.serviceWebTitle,
                          size: size,
                          // 6. إضافة onTap للربط
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.services,
                              arguments: 0, // Index 0
                            );
                          },
                        ),
                        SizedBox(width: size * 0.5), // 12
                        _HoverableServiceCard(
                          icon: Symbols.phone_iphone,
                          title: s.serviceAppTitle,
                          size: size,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.services,
                              arguments: 1, // Index 1
                            );
                          },
                        ),
                        SizedBox(width: size * 0.5), // 12
                        _HoverableServiceCard(
                          icon: Symbols.auto_awesome,
                          title: s.serviceAiTitle,
                          size: size,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.services,
                              arguments: 2, // Index 2
                            );
                          },
                        ),
                        SizedBox(width: size * 0.5), // 12
                        _HoverableServiceCard(
                          icon: Symbols.palette,
                          title: s.serviceBrandingTitle,
                          size: size,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.services,
                              arguments: 3, // Index 3
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // --- Portfolio Section (Dynamic) ---
          SliverToBoxAdapter(
            child: _buildSectionHeader(context, s.homeSectionPortfolio, size),
          ),
          _buildPortfolioList(context, portfolioProvider, size),

          // --- Testimonials Section (Dynamic) ---
          SliverToBoxAdapter(
            child: _buildSectionHeader(context, s.homeSectionTestimonials, size),
          ),
          _buildTestimonialList(context, testimonialProvider, size),

          // --- Contact Form Section ---
          SliverToBoxAdapter(
            child: _buildSectionHeader(context, s.homeSectionContact, size),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(size * 0.66), // 16
              child: const ContactFormSection(),
            ),
          ),

          // --- Social Links Section ---
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: size), // 24
              child: _buildSocialLinks(context, size),
            ),
          ),

          // Footer padding
          SliverToBoxAdapter(child: SizedBox(height: size * 1.66)), // 40
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollToTop,
        child: const Icon(Symbols.arrow_upward),
      ),
    );
  }

  // (باقي الدوال المساعدة لم تتغير)
  // ... _buildPortfolioList, _buildTestimonialList, etc. ...
  // --- Dynamic Portfolio List Builder ---
  Widget _buildPortfolioList(
      BuildContext context, PortfolioProvider provider, double size) {
    if (provider.isLoading) {
      return const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    }


    if (provider.items.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(child: Text("No portfolio items found.")),
      );
    }

    return SliverList.list(
      children: provider.items.map((portfolioItem) {
        return _buildPortfolioCard(
          context,
          portfolioItem,
          size,
        );
      }).toList(),
    );
  }

  // --- Dynamic Testimonial List Builder ---
  Widget _buildTestimonialList(
      BuildContext context, TestimonialProvider provider, double size) {
    if (provider.isLoading) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: size * 7.5, // 180
          child: const Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (provider.errorMessage != null) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: size * 7.5, // 180
          child: Center(child: Text("Error: ${provider.errorMessage}")),
        ),
      );
    }

    if (provider.items.isEmpty) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: size * 7.5, // 180
          child: const Center(child: Text("No testimonials found.")),
        ),
      );
    }

    return SliverToBoxAdapter(
      child: SizedBox(
        height: size * 7.5, // 180
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: size * 0.66), // 16
          itemCount: provider.items.length,
          itemBuilder: (context, index) {
            final testimonial = provider.items[index];
            return _buildTestimonialCard(
              context,
              testimonial,
              size,
            );
          },
        ),
      ),
    );
  }

  // --- Helper to open social URLs ---
  Future<void> _launchSocialURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      print('Could not launch $url');
    }
  }

  // --- Helper to build the row of social icons ---
  Widget _buildSocialLinks(BuildContext context, double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(AppIcons.facebook, SocialLinks.facebook, size),
        _buildSocialIcon(AppIcons.instagram, SocialLinks.instagram, size),
        _buildSocialIcon(AppIcons.linkedin, SocialLinks.linkedin, size),
        _buildSocialIcon(AppIcons.whatsapp, SocialLinks.whatsapp, size),
      ],
    );
  }

  // --- Helper for a single social icon ---
  Widget _buildSocialIcon(String iconPath, String url, double size) {
    return IconButton(
      icon: SvgPicture.asset(
        iconPath,
        width: size, // 24
        height: size, // 24
        colorFilter: const ColorFilter.mode(
          Colors.transparent,
          BlendMode.dstOver, // Use dstOver to show original color
        ),
      ),
      onPressed: () => _launchSocialURL(url),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, double size) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          size * 0.66, size, size * 0.66, size * 0.66), // 16, 24, 16, 16
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  Widget _buildPortfolioCard(
      BuildContext context, Portfolio portfolioItem, double size) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size * 0.66, vertical: size * 0.33), // 16, 8
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.portfolioDetail,
              arguments: portfolioItem,
            );
          },
          child: SizedBox(
            height: size * 8.33, // 200
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  portfolioItem.mainImage,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                        child: Icon(Icons.error, color: Colors.red));
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: size * 0.66, // 16
                  left: size * 0.66, // 16
                  right: size * 0.66, // 16
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        portfolioItem.title,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: AppColors.textWhite),
                      ),
                      Text(
                        portfolioItem.description,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.textLight),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTestimonialCard(
      BuildContext context, Testimonial testimonial, double size) {
    return Container(
      width: size * 12.5, // 300
      margin: EdgeInsets.only(right: size * 0.5), // 12
      padding: EdgeInsets.all(size * 0.66), // 16
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(size * 0.5), // 12
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              '"${testimonial.quote}"',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: size * 0.66), // 16
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  testimonial.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  testimonial.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HoverableServiceCard extends StatefulWidget {
  const _HoverableServiceCard({
    required this.icon,
    required this.title,
    required this.size,
    required this.onTap, // 7. إضافة onTap
  });

  final IconData icon;
  final String title;
  final double size;
  final VoidCallback onTap; // 7. إضافة onTap

  @override
  State<_HoverableServiceCard> createState() => _HoverableServiceCardState();
}

class _HoverableServiceCardState extends State<_HoverableServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final Color defaultColor =
    Theme.of(context).colorScheme.surface.withOpacity(0.5);
    final Color hoverColor = AppColors.surfaceDarkLighter;
    final textTheme = Theme.of(context).textTheme;

    final Matrix4 transform = _isHovered
        ? Matrix4.translationValues(0, -5, 0)
        : Matrix4.identity();

    // 8. استخدام InkWell للضغط
    return InkWell(
      onTap: widget.onTap,
      onHover: (hovering) {
        setState(() => _isHovered = hovering);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: transform,
        width: widget.size * 6.66, // 160
        decoration: BoxDecoration(
          color: _isHovered ? hoverColor : defaultColor,
          borderRadius: BorderRadius.circular(widget.size * 0.5), // 12
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon,
                color: AppColors.primary, size: widget.size * 1.66), // 40
            SizedBox(height: widget.size * 0.66), // 16
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: textTheme.titleMedium?.copyWith(
                color: _isHovered
                    ? AppColors.primary
                    : textTheme.titleMedium?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

