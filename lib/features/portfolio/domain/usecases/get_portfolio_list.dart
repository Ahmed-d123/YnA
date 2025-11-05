import '../entities/portfolio.dart';
import '../repositories/portfolio_repository.dart';

// 3. Domain Layer: Connects presentation to repository.
class GetPortfolioList {
  final PortfolioRepository repository;

  GetPortfolioList(this.repository);

  Future<List<Portfolio>> call() async {
    return await repository.getPortfolioList();
  }
}
