import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:ya_tech_flutter/core/assets/app_images.dart';
import 'package:ya_tech_flutter/core/localization/app_localizations.dart';
import 'package:ya_tech_flutter/core/navigation/app_routes.dart';
import 'package:ya_tech_flutter/core/theme/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    // الحصول على المسار الحالي لتحديد الصفحة النشطة
    final String? currentRoute = ModalRoute.of(context)?.settings.name;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.surfaceDarkLighter,
            ),
            child: Image.asset(AppImages.logo,),
          ),
          _buildDrawerItem(
            context: context,
            icon: Symbols.home_rounded,
            title: s.navHome,
            route: AppRoutes.home,
            isCurrent: currentRoute == AppRoutes.home,
          ),
          _buildDrawerItem(
            context: context,
            icon: Symbols.grid_view_rounded,
            title: s.navServices,
            route: AppRoutes.services,
            isCurrent: currentRoute == AppRoutes.services,
          ),
          _buildDrawerItem(
            context: context,
            icon: Symbols.info_rounded,
            title: s.navAbout,
            route: AppRoutes.about,
            isCurrent: currentRoute == AppRoutes.about,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String route,
    bool isCurrent = false,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: isCurrent, // تلوين العنصر النشط
      selectedTileColor: AppColors.primary.withOpacity(0.1),
      onTap: () {
        if (isCurrent) {
          // إذا كنا بالفعل في الصفحة، فقط أغلق القائمة
          Navigator.pop(context);
        } else {
          // اذهب للصفحة الجديدة (واحذف كل الصفحات السابقة من الـ stack)
          Navigator.pushNamedAndRemoveUntil(
            context,
            route,
                (route) => false, // حذف كل ما سبق
          );
        }
      },
    );
  }
}
