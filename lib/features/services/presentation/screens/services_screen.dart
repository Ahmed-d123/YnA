import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:ya_tech_flutter/core/utils/size_config.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/social_links.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../shell/app_drawer.dart'; // <-- إضافة القائمة

class ServicesScreen extends StatefulWidget {
  // --- تعديل: استقبال الرقم فقط ---
  final int? scrollToIndex;

  const ServicesScreen({
    super.key,
    this.scrollToIndex,
    // تم حذف onScrollComplete
  });
  // ---------------------------------

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final ItemScrollController _itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.scrollToIndex != null && widget.scrollToIndex! >= 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _jumpToItem(widget.scrollToIndex!);
      });
    }
  }

  void _jumpToItem(int index) {
    if (!_itemScrollController.isAttached) return;

    _itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      alignment: 0.1,
    );
    // (تم حذف onScrollComplete)
  }

  // (تم حذف didUpdateWidget لأنه غير مطلوب الآن)

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _launchWhatsApp(String serviceName) async {
    // (الكود هنا لم يتغير)
    if (!mounted) return;
    final s = S.of(context);
    final String message =
        "I want to ask about $serviceName service, please";
    final String phone = SocialLinks.whatsappPhoneNumber;

    final String encodedMessage = Uri.encodeComponent(message);
    final Uri whatsappUrl =
    Uri.parse("https://wa.me/$phone?text=$encodedMessage");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch WhatsApp");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s.contactFormError)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final double size = SizeConfig.defultSize!;

    final s = S.of(context);

    final serviceItems = [
      {'icon': Symbols.language_rounded, 'title': s.serviceWebTitle, 'description': s.serviceWebDescription,},
      {'icon': Symbols.smartphone_rounded, 'title': s.serviceAppTitle, 'description': s.serviceAppDescription,},
      {'icon': Symbols.psychology_rounded, 'title': s.serviceAiTitle, 'description': s.serviceAiDescription,},
      {'icon': Symbols.palette_rounded, 'title': s.serviceBrandingTitle, 'description': s.serviceBrandingDescription,},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(s.navServices),
      ),
      drawer: const AppDrawer(),
      body: ScrollablePositionedList.builder(
        itemScrollController: _itemScrollController,
        itemCount: serviceItems.length,
        padding: EdgeInsets.all(size * 0.66), // 16
        itemBuilder: (context, index) {
          final item = serviceItems[index];
          final bool isEven = index % 2 == 0;

          return _VisibilityAnimatedCard(
            key: ValueKey('service_card_$index'),
            index: index,
            isEven: isEven,
            size: size,
            icon: item['icon'] as IconData,
            title: item['title'] as String,
            description: item['description'] as String,
            onLearnMorePressed: () => _launchWhatsApp(item['title'] as String),
          );
        },
      ),
    );
  }
}

// ... (الكود الخاص بـ _VisibilityAnimatedCard و _AnimatedLearnMoreButton لم يتغير) ...
class _VisibilityAnimatedCard extends StatefulWidget {
  final int index;
// ... (الكود هنا لم يتغير) ...
  final bool isEven;
  final double size;
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onLearnMorePressed;

  const _VisibilityAnimatedCard({
// ... (الكود هنا لم يتغير) ...
    super.key,
    required this.index,
    required this.isEven,
    required this.size,
    required this.icon,
    required this.title,
    required this.description,
    required this.onLearnMorePressed,
  });

  @override
  State<_VisibilityAnimatedCard> createState() =>
      _VisibilityAnimatedCardState();
}

class _VisibilityAnimatedCardState extends State<_VisibilityAnimatedCard> {
// ... (الكود هنا لم يتغير) ...
  double _visibleFraction = 0.0;
  static const Duration _animDuration = Duration(milliseconds: 650);

  void _onVisibilityChanged(VisibilityInfo info) {
    setState(() {
// ... (الكود هنا لم يتغير) ...
      _visibleFraction = info.visibleFraction.clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
// ... (الكود هنا لم يتغير) ...
    final t = _visibleFraction; // 0..1
    final slideDistance = (1 - t) * (MediaQuery.of(context).size.width * 0.6);
    final opacity = t;

    return VisibilityDetector(
// ... (الكود هنا لم يتغير) ...
      key: Key('visibility_detector_${widget.index}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: TweenAnimationBuilder<double>(
        curve: Curves.easeOutCubic,
        duration: _animDuration,
        tween: Tween(begin: 0.0, end: opacity),
        builder: (context, value, child) {
          final v = value.clamp(0.0, 1.0);
          final currentSlide = Offset(
              widget.isEven
                  ? -((1 - v) * slideDistance)
                  : ((1 - v) * slideDistance),
              0);
          final currentScale = 0.85 + (v * 0.15);
          final currentRotation = (widget.isEven ? -0.08 : 0.08) * (1 - v);
          return Opacity(
// ... (الكود هنا لم يتغير) ...
            opacity: v,
            child: Transform.translate(
              offset: currentSlide,
              child: Transform.rotate(
                angle: currentRotation,
                child: Transform.scale(
// ... (الكود هنا لم يتغير) ...
                  scale: currentScale,
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width < 600
                          ? double.infinity
                          : MediaQuery.of(context).size.width / 1.8,
                      child: Card(
// ... (الكود هنا لم يتغير) ...
                        margin: EdgeInsets.only(bottom: widget.size * 0.66),
                        color: Theme.of(context).cardTheme.color,
                        child: Padding(
                          padding: EdgeInsets.all(widget.size),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
// ... (الكود هنا لم يتغير) ...
                              Icon(widget.icon,
                                  color: AppColors.primary,
                                  size: widget.size * 1.66),
                              SizedBox(height: widget.size * 0.66),
                              Text(widget.title,
                                  style: Theme.of(context).textTheme.titleLarge),
                              SizedBox(height: widget.size * 0.33),
// ... (الكود هنا لم يتغير) ...
                              Text(
                                widget.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.7),
                                ),
                              ),
                              SizedBox(height: widget.size),
                              _AnimatedLearnMoreButton(
                                  onPressed: widget.onLearnMorePressed),
                            ],
                          ),
                        ),
                      ),
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

class _AnimatedLearnMoreButton extends StatefulWidget {
// ... (الكود هنا لم يتغير) ...
  final VoidCallback onPressed;
  const _AnimatedLearnMoreButton({required this.onPressed});

  @override
  State<_AnimatedLearnMoreButton> createState() =>
      _AnimatedLearnMoreButtonState();
}

class _AnimatedLearnMoreButtonState extends State<_AnimatedLearnMoreButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
// ... (الكود هنا لم يتغير) ...
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: OutlinedButton(
// ... (الكود هنا لم يتغير) ...
          key: ValueKey<bool>(_isHovered),
          style: _isHovered
              ? OutlinedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.backgroundDark,
          )
              : OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: BorderSide(color: AppColors.primary.withOpacity(0.5)),
          ),
          onPressed: widget.onPressed,
          child: const Text("LearnMore"), // TODO: Localize
        ),
      ),
    );
  }
}

