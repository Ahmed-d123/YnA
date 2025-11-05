import '../entities/portfolio.dart';

// 2. Domain Layer: The contract for the data layer.
abstract class PortfolioRepository {
  Future<List<Portfolio>> getPortfolioList();
}
