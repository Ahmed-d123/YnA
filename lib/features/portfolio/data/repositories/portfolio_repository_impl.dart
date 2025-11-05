import '../../domain/entities/portfolio.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_remote_datasource.dart';

// 7. Data Layer: Implements the repository contract.
class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioRemoteDataSource remoteDataSource;

  PortfolioRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Portfolio>> getPortfolioList() async {
    try {
      // The model is compatible with the entity
      return await remoteDataSource.getPortfolioList();
    } catch (e) {
      rethrow;
    }
  }
}
