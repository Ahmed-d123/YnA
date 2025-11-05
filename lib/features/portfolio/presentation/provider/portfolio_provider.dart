import 'package:flutter/material.dart';
import '../../domain/entities/portfolio.dart';
import '../../domain/usecases/get_portfolio_list.dart';

// 8. Presentation Layer: Manages state for Portfolio.
class PortfolioProvider extends ChangeNotifier {
  final GetPortfolioList getPortfolioList;

  PortfolioProvider({required this.getPortfolioList});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Portfolio> _items = [];
  List<Portfolio> get items => _items;

  bool _hasFetched = false;

  Future<void> fetchPortfolioItems() async {
    // Evita إعادة الجلب إذا تم جلبه من قبل
    if (_hasFetched || _isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      _items = await getPortfolioList();
      _hasFetched = true;
    } catch (e) {
      print("Error fetching portfolio: $e");
      // يمكنك إضافة متغير للخطأ هنا
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
