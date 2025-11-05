import 'package:flutter/material.dart';
import '../../domain/entities/testimonial.dart';
import '../../domain/usecases/get_testimonials.dart';

class TestimonialProvider extends ChangeNotifier {
  final GetTestimonials getTestimonials;

  TestimonialProvider({required this.getTestimonials});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Testimonial> _items = [];
  List<Testimonial> get items => _items;

  // --- التحسين 1: إضافة متغير للخطأ ---
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  // ------------------------------------

  bool _hasFetched = false;

  Future<void> fetchTestimonials() async {
    // 1. إذا كنا نحمل حالياً، أو قمنا بالتحميل من قبل، لا تكمل
    if (_hasFetched || _isLoading) return;

    _isLoading = true;
    _errorMessage = null; // تنظيف أي خطأ قديم
    notifyListeners();

    try {
      _items = await getTestimonials();
      _hasFetched = true;
    } catch (e) {
      print("Error fetching testimonials: $e");
      // --- التحسين 1: تسجيل الخطأ ليظهر في الـ UI ---
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // --- التحسين 2: دالة لإعادة التحميل (Refresh) ---
  // هذه الدالة تتجاهل _hasFetched
  Future<void> refreshTestimonials() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // جلب البيانات من جديد
      _items = await getTestimonials();
      _hasFetched = true; // التأكد من أننا قمنا بالتحديث
    } catch (e) {
      print("Error refreshing testimonials: $e");
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
// ------------------------------------
}

